import 'package:drift/drift.dart';

import '../../domain/entities/expense.dart' as domain;
import '../../domain/entities/expense_source.dart';
import '../db/app_database.dart';

class ExpenseMapper {
  static domain.Expense fromData(Expense data) {
    return domain.Expense(
      id: data.id,
      amountCents: data.amountCents,
      currency: data.currency,
      occurredAt: DateTime.fromMillisecondsSinceEpoch(data.occurredAt),
      categoryId: data.categoryId,
      merchant: data.merchant,
      note: data.note,
      source: ExpenseSource.values.firstWhere(
        (value) => value.name == data.source,
        orElse: () => ExpenseSource.manual,
      ),
      createdAt: DateTime.fromMillisecondsSinceEpoch(data.createdAt),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(data.updatedAt),
      deletedAt: data.deletedAt == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(data.deletedAt!),
    );
  }

  static ExpensesCompanion toCompanion(domain.Expense expense) {
    return ExpensesCompanion(
      id: Value(expense.id),
      amountCents: Value(expense.amountCents),
      currency: Value(expense.currency),
      occurredAt: Value(expense.occurredAt.millisecondsSinceEpoch),
      categoryId: Value(expense.categoryId),
      merchant: Value(expense.merchant),
      note: Value(expense.note),
      source: Value(expense.source.name),
      createdAt: Value(expense.createdAt.millisecondsSinceEpoch),
      updatedAt: Value(expense.updatedAt.millisecondsSinceEpoch),
      deletedAt: Value(expense.deletedAt?.millisecondsSinceEpoch),
    );
  }
}
