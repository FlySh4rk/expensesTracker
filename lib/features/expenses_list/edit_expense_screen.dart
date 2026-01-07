import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/expense.dart';

class EditExpenseScreen extends ConsumerStatefulWidget {
  const EditExpenseScreen({super.key, required this.expense});

  final Expense expense;

  @override
  ConsumerState<EditExpenseScreen> createState() => _EditExpenseScreenState();
}

class _EditExpenseScreenState extends ConsumerState<EditExpenseScreen> {
  late final TextEditingController _amountController;
  late final TextEditingController _merchantController;
  late final TextEditingController _noteController;
  late String _categoryId;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(text: (widget.expense.amountCents / 100).toStringAsFixed(2));
    _merchantController = TextEditingController(text: widget.expense.merchant ?? '');
    _noteController = TextEditingController(text: widget.expense.note ?? '');
    _categoryId = widget.expense.categoryId;
  }

  @override
  void dispose() {
    _amountController.dispose();
    _merchantController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoryRepositoryProvider).watchAllCategories();

    return Scaffold(
      appBar: AppBar(title: const Text('Modifica spesa')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder<List<Category>>(
          stream: categoriesAsync,
          builder: (context, snapshot) {
            final categories = snapshot.data ?? [];
            if (categories.isEmpty) {
              return const Center(child: Text('Nessuna categoria disponibile.'));
            }
            return ListView(
              children: [
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Importo'),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _categoryId,
                  items: categories
                      .map((category) => DropdownMenuItem(
                            value: category.id,
                            child: Text(category.name),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _categoryId = value);
                    }
                  },
                  decoration: const InputDecoration(labelText: 'Categoria'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _merchantController,
                  decoration: const InputDecoration(labelText: 'Merchant'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _noteController,
                  decoration: const InputDecoration(labelText: 'Note'),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    final amount = double.tryParse(_amountController.text.replaceAll(',', '.')) ?? 0;
                    final updated = widget.expense.copyWith(
                      amountCents: (amount * 100).round(),
                      categoryId: _categoryId,
                      merchant: _merchantController.text.isEmpty ? null : _merchantController.text,
                      note: _noteController.text.isEmpty ? null : _noteController.text,
                      updatedAt: DateTime.now(),
                    );
                    await ref.read(expenseRepositoryProvider).upsertExpense(updated);
                    if (mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Salva modifiche'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
