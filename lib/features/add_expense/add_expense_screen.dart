import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../app/providers.dart';
import '../../utils/currency_formatter.dart';
import 'add_expense_controller.dart';

class AddExpenseScreen extends ConsumerWidget {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addExpenseControllerProvider);
    final controller = ref.read(addExpenseControllerProvider.notifier);
    final categoriesAsync = ref.watch(categoryRepositoryProvider).watchEnabledCategories();

    return Scaffold(
      appBar: AppBar(title: const Text('Aggiungi spesa')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Importo', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          TextField(
            key: const Key('amountField'),
            keyboardType: TextInputType.number,
            style: Theme.of(context).textTheme.headlineMedium,
            decoration: InputDecoration(
              hintText: '0,00',
              suffixText: state.currency,
            ),
            onChanged: (value) {
              final cleaned = value.replaceAll(',', '.');
              final parsed = double.tryParse(cleaned);
              controller.setAmountCents(parsed == null ? 0 : (parsed * 100).round());
            },
          ),
          const SizedBox(height: 16),
          Text('Categoria', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          StreamBuilder(
            stream: categoriesAsync,
            builder: (context, snapshot) {
              final categories = snapshot.data ?? [];
              if (categories.isEmpty) {
                return const Text('Nessuna categoria disponibile.');
              }
              return GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: categories.map((category) {
                  final selected = state.categoryId == category.id;
                  return GestureDetector(
                    onTap: () => controller.setCategory(category.id),
                    child: Container(
                      decoration: BoxDecoration(
                        color: selected
                            ? Theme.of(context).colorScheme.primaryContainer
                            : Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            category.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: controller.toggleMore,
            icon: Icon(state.showMore ? Icons.expand_less : Icons.expand_more),
            label: Text(state.showMore ? 'Meno' : 'Altro'),
          ),
          if (state.showMore) ...[
            const SizedBox(height: 8),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Data'),
              subtitle: Text(DateFormat('dd MMM yyyy').format(state.occurredAt)),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: state.occurredAt,
                  firstDate: DateTime(DateTime.now().year - 1),
                  lastDate: DateTime(DateTime.now().year + 1),
                );
                if (picked != null) {
                  controller.setDate(picked);
                }
              },
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(labelText: 'Merchant'),
              onChanged: controller.setMerchant,
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(labelText: 'Note'),
              maxLines: 2,
              onChanged: controller.setNote,
            ),
          ],
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: state.canSave ? () async => controller.save() : null,
            child: Text(
              state.canSave
                  ? 'Salva ${formatCurrency(state.amountCents, state.currency)}'
                  : 'Seleziona importo e categoria',
            ),
          ),
        ],
      ),
    );
  }
}
