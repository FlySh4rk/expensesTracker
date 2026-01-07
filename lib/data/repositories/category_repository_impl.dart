import 'package:drift/drift.dart';

import '../../domain/entities/category.dart' as domain;
import '../../domain/repositories/category_repository.dart';
import '../db/app_database.dart';
import '../mappers/category_mapper.dart';

const defaultCategories = <domain.Category>[
  domain.Category(id: 'groceries_food_home', name: 'Spesa / Alimentari', iconKey: 'shopping_cart', isEnabled: true, sortOrder: 1),
  domain.Category(id: 'eating_out', name: 'Ristoranti / Bar', iconKey: 'restaurant', isEnabled: true, sortOrder: 2),
  domain.Category(id: 'transport', name: 'Trasporti', iconKey: 'directions_car', isEnabled: true, sortOrder: 3),
  domain.Category(id: 'bills_utilities', name: 'Bollette / Utenze', iconKey: 'receipt_long', isEnabled: true, sortOrder: 4),
  domain.Category(id: 'rent_mortgage', name: 'Affitto / Mutuo', iconKey: 'home', isEnabled: true, sortOrder: 5),
  domain.Category(id: 'health_pharmacy', name: 'Salute / Farmacia', iconKey: 'health_and_safety', isEnabled: true, sortOrder: 6),
  domain.Category(id: 'personal_care', name: 'Cura persona', iconKey: 'face', isEnabled: true, sortOrder: 7),
  domain.Category(id: 'home_cleaning', name: 'Casa / Pulizia', iconKey: 'cleaning_services', isEnabled: true, sortOrder: 8),
  domain.Category(id: 'entertainment', name: 'Svago', iconKey: 'local_movies', isEnabled: true, sortOrder: 9),
  domain.Category(id: 'shopping', name: 'Shopping', iconKey: 'shopping_bag', isEnabled: true, sortOrder: 10),
  domain.Category(id: 'education', name: 'Istruzione', iconKey: 'school', isEnabled: true, sortOrder: 11),
  domain.Category(id: 'other', name: 'Altro', iconKey: 'category', isEnabled: true, sortOrder: 12),
];

class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Stream<List<domain.Category>> watchEnabledCategories() {
    final query = _db.select(_db.categories)
      ..where((tbl) => tbl.isEnabled.equals(true))
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.sortOrder)]);
    return query.watch().map(
          (rows) => rows.map(CategoryMapper.fromData).toList(),
        );
  }

  @override
  Stream<List<domain.Category>> watchAllCategories() {
    final query = _db.select(_db.categories)
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.sortOrder)]);
    return query.watch().map(
          (rows) => rows.map(CategoryMapper.fromData).toList(),
        );
  }

  @override
  Future<void> updateCategory(domain.Category category) async {
    await _db.into(_db.categories).insertOnConflictUpdate(
          CategoryMapper.toCompanion(category),
        );
  }

  @override
  Future<void> insertDefaultsIfNeeded() async {
    final count = await _db.selectOnly(_db.categories)
        .addColumns([_db.categories.id.count()])
        .getSingle();
    final existing = count.read(_db.categories.id.count()) ?? 0;
    if (existing > 0) return;

    await _db.batch((batch) {
      batch.insertAll(
        _db.categories,
        defaultCategories.map(CategoryMapper.toCompanion).toList(),
      );
    });
  }

  @override
  Future<domain.Category?> getCategory(String id) async {
    final row = await (_db.select(_db.categories)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : CategoryMapper.fromData(row);
  }
}
