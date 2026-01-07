import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../app/providers.dart';
import '../../utils/currency_formatter.dart';
import 'edit_expense_screen.dart';
import 'expenses_list_controller.dart';

class ExpensesListScreen extends ConsumerWidget {
  const ExpensesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(expensesListControllerProvider);
    final controller = ref.read(expensesListControllerProvider.notifier);
    final expensesAsync = ref.watch(expensesListResultsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Spese')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: () {
                        controller.setMonth(DateTime(state.month.year, state.month.month - 1));
                      },
                    ),
                    Expanded(
                      child: Text(
                        DateFormat('MMMM yyyy', 'it_IT').format(state.month),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: () {
                        controller.setMonth(DateTime(state.month.year, state.month.month + 1));
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Cerca merchant o nota'),
                  onChanged: controller.setQuery,
                ),
              ],
            ),
          ),
          Expanded(
            child: expensesAsync.when(
              data: (items) {
                if (items.isEmpty) {
                  return const Center(child: Text('Nessuna spesa trovata.'));
                }
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final expense = items[index];
                    return Dismissible(
                      key: ValueKey(expense.id),
                      background: Container(color: Colors.red),
                      confirmDismiss: (_) async {
                        return await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Eliminare spesa?'),
                                content: const Text('Questa azione può essere annullata in futuro tramite sincronizzazione.'),
                                actions: [
                                  TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Annulla')),
                                  TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Elimina')),
                                ],
                              ),
                            ) ??
                            false;
                      },
                      onDismissed: (_) {
                        ref.read(expenseRepositoryProvider).softDeleteExpense(expense.id, DateTime.now());
                      },
                      child: ListTile(
                        title: Text(formatCurrency(expense.amountCents, expense.currency)),
                        subtitle: Text(expense.merchant ?? expense.note ?? ''),
                        trailing: Text(DateFormat('dd MMM').format(expense.occurredAt)),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => EditExpenseScreen(expense: expense),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
              error: (err, _) => Center(child: Text('Errore: $err')),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}
