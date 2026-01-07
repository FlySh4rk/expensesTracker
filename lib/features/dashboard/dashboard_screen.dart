import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../utils/currency_formatter.dart';
import '../expenses_list/edit_expense_screen.dart';
import 'dashboard_controller.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final month = ref.watch(dashboardMonthProvider);
    final totalAsync = ref.watch(monthlyTotalProvider);
    final breakdownAsync = ref.watch(monthlyTotalsByCategoryProvider);
    final recentAsync = ref.watch(recentExpensesProvider);
    final categoriesAsync = ref.watch(categoriesProvider);
    final categoryNames = {
      for (final category in categoriesAsync.valueOrNull ?? []) category.id: category.name,
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _MonthSelector(
            month: month,
            onPrevious: () {
              ref.read(dashboardMonthProvider.notifier).state = DateTime(month.year, month.month - 1);
            },
            onNext: () {
              ref.read(dashboardMonthProvider.notifier).state = DateTime(month.year, month.month + 1);
            },
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: totalAsync.when(
                data: (total) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Totale mese', style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Text(
                      formatCurrency(total, 'EUR'),
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ],
                ),
                error: (err, _) => Text('Errore: $err'),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('Breakdown categorie', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: breakdownAsync.when(
                data: (breakdown) {
                  final categories = categoriesAsync.valueOrNull ?? [];
                  final total = breakdown.values.fold<int>(0, (sum, value) => sum + value);
                  if (breakdown.isEmpty) {
                    return const Text('Nessuna spesa in questo mese.');
                  }
                  return Column(
                    children: breakdown.entries.map((entry) {
                      final category = categories.firstWhereOrNull((item) => item.id == entry.key);
                      final label = category?.name ?? entry.key;
                      final percent = total == 0 ? 0 : (entry.value / total) * 100;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text(label)),
                            Text('${percent.toStringAsFixed(0)}%'),
                            const SizedBox(width: 12),
                            Text(formatCurrency(entry.value, 'EUR')),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
                error: (err, _) => Text('Errore: $err'),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('Ultime spese', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          recentAsync.when(
            data: (items) {
              if (items.isEmpty) {
                return const Text('Nessuna spesa recente.');
              }
              return Column(
                children: items
                    .map((expense) => ListTile(
                          title: Text(formatCurrency(expense.amountCents, expense.currency)),
                          subtitle: Text(DateFormat('dd MMM').format(expense.occurredAt)),
                          trailing: Text(categoryNames[expense.categoryId] ?? expense.categoryId),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => EditExpenseScreen(expense: expense),
                              ),
                            );
                          },
                        ))
                    .toList(),
              );
            },
            error: (err, _) => Text('Errore: $err'),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}

class _MonthSelector extends StatelessWidget {
  const _MonthSelector({
    required this.month,
    required this.onPrevious,
    required this.onNext,
  });

  final DateTime month;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final label = DateFormat('MMMM yyyy', 'it_IT').format(month);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: onPrevious, icon: const Icon(Icons.chevron_left)),
        Text(label, style: Theme.of(context).textTheme.titleMedium),
        IconButton(onPressed: onNext, icon: const Icon(Icons.chevron_right)),
      ],
    );
  }
}
