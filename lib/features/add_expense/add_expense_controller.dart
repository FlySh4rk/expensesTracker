import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../data/repositories/settings_repository.dart';
import '../../domain/entities/expense.dart';
import '../../domain/entities/expense_source.dart';

class AddExpenseState {
  const AddExpenseState({
    required this.amountCents,
    required this.categoryId,
    required this.currency,
    required this.occurredAt,
    required this.showMore,
    required this.keepLastCategory,
    this.merchant,
    this.note,
  });

  final int amountCents;
  final String? categoryId;
  final String currency;
  final DateTime occurredAt;
  final bool showMore;
  final bool keepLastCategory;
  final String? merchant;
  final String? note;

  bool get canSave => amountCents > 0 && categoryId != null;

  AddExpenseState copyWith({
    int? amountCents,
    String? categoryId,
    String? currency,
    DateTime? occurredAt,
    bool? showMore,
    bool? keepLastCategory,
    Object? merchant = _sentinel,
    Object? note = _sentinel,
  }) {
    return AddExpenseState(
      amountCents: amountCents ?? this.amountCents,
      categoryId: categoryId ?? this.categoryId,
      currency: currency ?? this.currency,
      occurredAt: occurredAt ?? this.occurredAt,
      showMore: showMore ?? this.showMore,
      keepLastCategory: keepLastCategory ?? this.keepLastCategory,
      merchant: merchant == _sentinel ? this.merchant : merchant as String?,
      note: note == _sentinel ? this.note : note as String?,
    );
  }

  factory AddExpenseState.initial({required String currency, required bool keepLastCategory}) {
    final now = DateTime.now();
    return AddExpenseState(
      amountCents: 0,
      categoryId: null,
      currency: currency,
      occurredAt: DateTime(now.year, now.month, now.day),
      showMore: false,
      keepLastCategory: keepLastCategory,
      merchant: null,
      note: null,
    );
  }
}

const _sentinel = Object();

class AddExpenseController extends StateNotifier<AddExpenseState> {
  AddExpenseController(this._ref, {required String currency, required bool keepLastCategory})
      : super(AddExpenseState.initial(currency: currency, keepLastCategory: keepLastCategory));

  final Ref _ref;

  void setAmountCents(int cents) {
    state = state.copyWith(amountCents: cents);
  }

  void setCategory(String? id) {
    state = state.copyWith(categoryId: id);
  }

  void toggleMore() {
    state = state.copyWith(showMore: !state.showMore);
  }

  void setDate(DateTime date) {
    state = state.copyWith(occurredAt: date);
  }

  void setMerchant(String value) {
    state = state.copyWith(merchant: value.isEmpty ? null : value);
  }

  void setNote(String value) {
    state = state.copyWith(note: value.isEmpty ? null : value);
  }

  Future<void> save() async {
    if (!state.canSave) return;
    final now = DateTime.now();
    final expense = Expense(
      id: _ref.read(uuidProvider).newId(),
      amountCents: state.amountCents,
      currency: state.currency,
      occurredAt: state.occurredAt,
      categoryId: state.categoryId!,
      merchant: state.merchant,
      note: state.note,
      source: ExpenseSource.manual,
      createdAt: now,
      updatedAt: now,
      deletedAt: null,
    );
    await _ref.read(expenseRepositoryProvider).upsertExpense(expense);
    final lastCategory = state.keepLastCategory ? state.categoryId : null;
    state = AddExpenseState.initial(
      currency: state.currency,
      keepLastCategory: state.keepLastCategory,
    ).copyWith(categoryId: lastCategory);
  }
}

final addExpenseControllerProvider = StateNotifierProvider<AddExpenseController, AddExpenseState>((ref) {
  final settings = ref.read(settingsRepositoryProvider);
  return AddExpenseController(
    ref,
    currency: 'EUR',
    keepLastCategory: true,
  )
    .._hydrate(settings);
});

extension on AddExpenseController {
  Future<void> _hydrate(SettingsRepository settings) async {
    final currency = await settings.loadCurrency();
    final keepLast = await settings.loadKeepLastCategory();
    final now = DateTime.now();
    state = AddExpenseState(
      amountCents: 0,
      categoryId: null,
      currency: currency,
      occurredAt: DateTime(now.year, now.month, now.day),
      showMore: false,
      keepLastCategory: keepLast,
      merchant: null,
      note: null,
    );
  }
}
