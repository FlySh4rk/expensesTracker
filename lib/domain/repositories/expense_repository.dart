import '../entities/expense.dart';

abstract class ExpenseRepository {
  Future<void> upsertExpense(Expense expense);
  Future<void> softDeleteExpense(String id, DateTime deletedAt);
  Future<Expense?> getExpense(String id);
  Stream<List<Expense>> watchRecentExpenses({int limit = 10});
  Stream<int> watchMonthlyTotal(DateTime month);
  Stream<Map<String, int>> watchMonthlyTotalsByCategory(DateTime month);
  Stream<List<Expense>> watchSearchResults({
    required DateTime month,
    required String query,
  });
}
