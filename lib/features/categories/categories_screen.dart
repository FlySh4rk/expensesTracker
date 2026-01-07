import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'categories_controller.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesControllerProvider);
    final actions = ref.read(categoriesActionsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Categorie')),
      body: categoriesAsync.when(
        data: (categories) {
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: categories.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final category = categories[index];
              return SwitchListTile(
                title: Text(category.name),
                value: category.isEnabled,
                onChanged: (value) => actions.toggleCategory(category, value),
              );
            },
          );
        },
        error: (err, _) => Center(child: Text('Errore: $err')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
