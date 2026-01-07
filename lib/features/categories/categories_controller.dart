import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../domain/entities/category.dart';

final categoriesControllerProvider = StreamProvider<List<Category>>((ref) {
  return ref.watch(categoryRepositoryProvider).watchAllCategories();
});

class CategoriesActions {
  CategoriesActions(this._ref);

  final Ref _ref;

  Future<void> toggleCategory(Category category, bool enabled) async {
    await _ref.read(categoryRepositoryProvider).updateCategory(
          category.copyWith(isEnabled: enabled),
        );
  }
}

final categoriesActionsProvider = Provider<CategoriesActions>((ref) {
  return CategoriesActions(ref);
});
