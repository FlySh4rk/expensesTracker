import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:expenses_tracker/app/app.dart';
import 'package:expenses_tracker/app/providers.dart';
import 'package:expenses_tracker/data/db/app_database.dart';
import 'package:expenses_tracker/data/repositories/category_repository_impl.dart';

void main() {
  testWidgets('Add flow saves expense and appears in recent list', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final db = AppDatabase(executor: NativeDatabase.memory());
    final categoryRepo = CategoryRepositoryImpl(db);
    await categoryRepo.insertDefaultsIfNeeded();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(db),
          categoryRepositoryProvider.overrideWithValue(categoryRepo),
        ],
        child: const ExpensesTrackerApp(),
      ),
    );

    await tester.pumpAndSettle();

    // Switch to Add tab.
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('amountField')), '12.00');
    await tester.pump();

    // Select first category.
    await tester.tap(find.text('Spesa / Alimentari'));
    await tester.pump();

    // Save.
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Go back to Dashboard.
    await tester.tap(find.text('Dashboard'));
    await tester.pumpAndSettle();

    expect(find.textContaining('12'), findsWidgets);

    await db.close();
  });
}
