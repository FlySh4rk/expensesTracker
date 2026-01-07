import 'dart:convert';

import 'package:drift/drift.dart';

import '../../domain/entities/expense.dart' as domain;
import '../../domain/repositories/expense_repository.dart';
import '../../utils/date_utils.dart';
import '../db/app_database.dart';
import '../mappers/expense_mapper.dart';
import 'uuid_generator.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  ExpenseRepositoryImpl(this._db, this._uuidGenerator);

  final AppDatabase _db;
  final UuidGenerator _uuidGenerator;

  @override
  Future<void> upsertExpense(domain.Expense expense) async {
    final existing = await getExpense(expense.id);
    await _db.into(_db.expenses).insertOnConflictUpdate(
          ExpenseMapper.toCompanion(expense),
        );
    final eventType = expense.deletedAt != null
        ? 'delete'
        : existing == null
            ? 'create'
            : 'update';
    await _logEvent(expense, eventType);
  }

  @override
  Future<void> softDeleteExpense(String id, DateTime deletedAt) async {
    await (_db.update(_db.expenses)..where((row) => row.id.equals(id))).write(
      ExpensesCompanion(deletedAt: Value(deletedAt.millisecondsSinceEpoch)),
    );
    final expense = await getExpense(id);
    if (expense != null) {
      await _logEvent(expense.copyWith(deletedAt: deletedAt), 'delete');
    }
  }

  @override
  Future<domain.Expense?> getExpense(String id) async {
    final row = await (_db.select(_db.expenses)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    if (row == null) return null;
    return ExpenseMapper.fromData(row);
  }

  @override
  Stream<List<domain.Expense>> watchRecentExpenses({int limit = 10}) {
    final query = _db.select(_db.expenses)
      ..where((tbl) => tbl.deletedAt.isNull())
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.occurredAt)])
      ..limit(limit);
    return query.watch().map(
          (rows) => rows.map(ExpenseMapper.fromData).toList(),
        );
  }

  @override
  Stream<int> watchMonthlyTotal(DateTime month) {
    final start = startOfMonth(month).millisecondsSinceEpoch;
    final end = endOfMonth(month).millisecondsSinceEpoch - 1;
    final sumExpr = _db.expenses.amountCents.sum();
    final query = (_db.selectOnly(_db.expenses)
          ..addColumns([sumExpr])
          ..where(_db.expenses.occurredAt.isBetweenValues(start, end))
          ..where(_db.expenses.deletedAt.isNull()))
        .watch();
    return query.map((rows) => rows.first.read(sumExpr) ?? 0);
  }

  @override
  Stream<Map<String, int>> watchMonthlyTotalsByCategory(DateTime month) {
    final start = startOfMonth(month).millisecondsSinceEpoch;
    final end = endOfMonth(month).millisecondsSinceEpoch - 1;
    final sumExpr = _db.expenses.amountCents.sum();
    final query = (_db.selectOnly(_db.expenses)
          ..addColumns([_db.expenses.categoryId, sumExpr])
          ..where(_db.expenses.occurredAt.isBetweenValues(start, end))
          ..where(_db.expenses.deletedAt.isNull())
          ..groupBy([_db.expenses.categoryId]))
        .watch();
    return query.map((rows) {
      return {
        for (final row in rows)
          row.read(_db.expenses.categoryId)!
              : row.read(sumExpr) ?? 0,
      };
    });
  }

  @override
  Stream<List<domain.Expense>> watchSearchResults({
    required DateTime month,
    required String query,
  }) {
    final start = startOfMonth(month).millisecondsSinceEpoch;
    final end = endOfMonth(month).millisecondsSinceEpoch - 1;
    final likeQuery = '%${query.trim()}%';
    final driftQuery = _db.select(_db.expenses)
      ..where((tbl) => tbl.occurredAt.isBetweenValues(start, end))
      ..where((tbl) => tbl.deletedAt.isNull());

    if (query.trim().isNotEmpty) {
      driftQuery.where((tbl) => tbl.merchant.like(likeQuery) | tbl.note.like(likeQuery));
    }

    driftQuery.orderBy([(tbl) => OrderingTerm.desc(tbl.occurredAt)]);

    return driftQuery.watch().map(
          (rows) => rows.map(ExpenseMapper.fromData).toList(),
        );
  }

  Future<void> _logEvent(domain.Expense expense, String eventType) async {
    final payload = jsonEncode({
      'id': expense.id,
      'amount_cents': expense.amountCents,
      'currency': expense.currency,
      'occurred_at': expense.occurredAt.toIso8601String(),
      'category_id': expense.categoryId,
      'merchant': expense.merchant,
      'note': expense.note,
      'source': expense.source.name,
      'created_at': expense.createdAt.toIso8601String(),
      'updated_at': expense.updatedAt.toIso8601String(),
      'deleted_at': expense.deletedAt?.toIso8601String(),
    });

    await _db.into(_db.expenseEvents).insert(
          ExpenseEventsCompanion(
            id: Value(_uuidGenerator.newId()),
            entityId: Value(expense.id),
            eventType: Value(eventType),
            payloadJson: Value(payload),
            createdAt: Value(DateTime.now().millisecondsSinceEpoch),
            syncedAt: const Value(null),
          ),
        );
  }
}
