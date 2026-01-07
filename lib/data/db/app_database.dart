import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class Categories extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get iconKey => text().named('icon_key')();
  BoolColumn get isEnabled => boolean().named('is_enabled').withDefault(const Constant(true))();
  IntColumn get sortOrder => integer().named('sort_order')();

  @override
  Set<Column> get primaryKey => {id};
}

class Expenses extends Table {
  TextColumn get id => text()();
  IntColumn get amountCents => integer().named('amount_cents')();
  TextColumn get currency => text()();
  IntColumn get occurredAt => integer().named('occurred_at')();
  TextColumn get categoryId => text().named('category_id').references(Categories, #id)();
  TextColumn get merchant => text().nullable()();
  TextColumn get note => text().nullable()();
  TextColumn get source => text()();
  IntColumn get createdAt => integer().named('created_at')();
  IntColumn get updatedAt => integer().named('updated_at')();
  IntColumn get deletedAt => integer().named('deleted_at').nullable()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Index> get indexes => [
        Index('idx_expenses_occurred_at', [occurredAt]),
        Index('idx_expenses_category', [categoryId, occurredAt]),
        Index('idx_expenses_deleted', [deletedAt]),
        Index('idx_expenses_merchant', [merchant]),
      ];
}

class ExpenseEvents extends Table {
  TextColumn get id => text()();
  TextColumn get entityId => text().named('entity_id')();
  TextColumn get eventType => text().named('event_type')();
  TextColumn get payloadJson => text().named('payload_json')();
  IntColumn get createdAt => integer().named('created_at')();
  IntColumn get syncedAt => integer().named('synced_at').nullable()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Index> get indexes => [
        Index('idx_events_synced', [syncedAt]),
      ];
}

@DriftDatabase(tables: [Categories, Expenses, ExpenseEvents])
class AppDatabase extends _$AppDatabase {
  AppDatabase({QueryExecutor? executor}) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'expenses.sqlite'));
    return NativeDatabase(file);
  });
}
