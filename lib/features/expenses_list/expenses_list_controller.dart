import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../domain/entities/expense.dart';

class ExpensesListState {
  const ExpensesListState({required this.month, required this.query});

  final DateTime month;
  final String query;

  ExpensesListState copyWith({DateTime? month, String? query}) {
    return ExpensesListState(
      month: month ?? this.month,
      query: query ?? this.query,
    );
  }
}

class ExpensesListController extends StateNotifier<ExpensesListState> {
  ExpensesListController() : super(ExpensesListState(month: DateTime(DateTime.now().year, DateTime.now().month), query: ''));

  void setMonth(DateTime month) {
    state = state.copyWith(month: month);
  }

  void setQuery(String query) {
    state = state.copyWith(query: query);
  }
}

final expensesListControllerProvider = StateNotifierProvider<ExpensesListController, ExpensesListState>((ref) {
  return ExpensesListController();
});

final expensesListResultsProvider = StreamProvider<List<Expense>>((ref) {
  final state = ref.watch(expensesListControllerProvider);
  return ref.watch(expenseRepositoryProvider).watchSearchResults(
        month: state.month,
        query: state.query,
      );
});
