import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/expense.dart';

final dashboardMonthProvider = StateProvider<DateTime>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month);
});

final monthlyTotalProvider = StreamProvider<int>((ref) {
  final month = ref.watch(dashboardMonthProvider);
  return ref.watch(expenseRepositoryProvider).watchMonthlyTotal(month);
});

final monthlyTotalsByCategoryProvider = StreamProvider<Map<String, int>>((ref) {
  final month = ref.watch(dashboardMonthProvider);
  return ref.watch(expenseRepositoryProvider).watchMonthlyTotalsByCategory(month);
});

final recentExpensesProvider = StreamProvider<List<Expense>>((ref) {
  return ref.watch(expenseRepositoryProvider).watchRecentExpenses(limit: 10);
});

final categoriesProvider = StreamProvider<List<Category>>((ref) {
  return ref.watch(categoryRepositoryProvider).watchAllCategories();
});
