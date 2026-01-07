import 'package:drift/drift.dart';

import '../../domain/entities/category.dart' as domain;
import '../db/app_database.dart';

class CategoryMapper {
  static domain.Category fromData(Category data) {
    return domain.Category(
      id: data.id,
      name: data.name,
      iconKey: data.iconKey,
      isEnabled: data.isEnabled,
      sortOrder: data.sortOrder,
    );
  }

  static CategoriesCompanion toCompanion(domain.Category category) {
    return CategoriesCompanion(
      id: Value(category.id),
      name: Value(category.name),
      iconKey: Value(category.iconKey),
      isEnabled: Value(category.isEnabled),
      sortOrder: Value(category.sortOrder),
    );
  }
}
