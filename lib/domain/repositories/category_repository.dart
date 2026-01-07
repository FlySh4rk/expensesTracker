import '../entities/category.dart';

abstract class CategoryRepository {
  Stream<List<Category>> watchEnabledCategories();
  Stream<List<Category>> watchAllCategories();
  Future<void> updateCategory(Category category);
  Future<void> insertDefaultsIfNeeded();
  Future<Category?> getCategory(String id);
}
