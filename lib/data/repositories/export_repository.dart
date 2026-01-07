import 'package:drift/drift.dart';

import '../db/app_database.dart';

class ExportRow {
  const ExportRow({
    required this.id,
    required this.amountCents,
    required this.currency,
    required this.occurredAtIso,
    required this.categoryId,
    required this.categoryName,
    required this.merchant,
    required this.note,
    required this.source,
    required this.createdAtIso,
    required this.updatedAtIso,
    required this.deletedAtIso,
  });

  final String id;
  final int amountCents;
  final String currency;
  final String occurredAtIso;
  final String categoryId;
  final String categoryName;
  final String? merchant;
  final String? note;
  final String source;
  final String createdAtIso;
  final String updatedAtIso;
  final String? deletedAtIso;
}

class ExportRepository {
  ExportRepository(this._db);

  final AppDatabase _db;

  Future<List<ExportRow>> loadAll() async {
    final query = _db.select(_db.expenses).join([
      innerJoin(_db.categories, _db.categories.id.equalsExp(_db.expenses.categoryId)),
    ]);

    final rows = await query.get();
    return rows.map((row) {
      final expense = row.readTable(_db.expenses);
      final category = row.readTable(_db.categories);
      return ExportRow(
        id: expense.id,
        amountCents: expense.amountCents,
        currency: expense.currency,
        occurredAtIso: DateTime.fromMillisecondsSinceEpoch(expense.occurredAt).toIso8601String(),
        categoryId: expense.categoryId,
        categoryName: category.name,
        merchant: expense.merchant,
        note: expense.note,
        source: expense.source,
        createdAtIso: DateTime.fromMillisecondsSinceEpoch(expense.createdAt).toIso8601String(),
        updatedAtIso: DateTime.fromMillisecondsSinceEpoch(expense.updatedAt).toIso8601String(),
        deletedAtIso: expense.deletedAt == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(expense.deletedAt!).toIso8601String(),
      );
    }).toList();
  }
}
