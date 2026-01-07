import '../entities/expense.dart';
import '../repositories/expense_repository.dart';

class AddExpense {
  AddExpense(this._repository);

  final ExpenseRepository _repository;

  Future<void> call(Expense expense) => _repository.upsertExpense(expense);
}
