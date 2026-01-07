import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/db/app_database.dart';
import '../data/repositories/category_repository_impl.dart';
import '../data/repositories/expense_repository_impl.dart';
import '../data/repositories/export_repository.dart';
import '../data/repositories/settings_repository.dart';
import '../data/repositories/uuid_generator.dart';
import '../domain/repositories/category_repository.dart';
import '../domain/repositories/expense_repository.dart';
import '../domain/usecases/add_expense.dart';
import '../services/expense_categorizer.dart';
import '../services/receipt_ocr_service.dart';
import '../services/sync_service.dart';
import 'feature_flags.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final uuidProvider = Provider<UuidGenerator>((ref) => const UuidGenerator());

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  final repo = CategoryRepositoryImpl(ref.read(databaseProvider));
  repo.insertDefaultsIfNeeded();
  return repo;
});

final expenseRepositoryProvider = Provider<ExpenseRepository>((ref) {
  return ExpenseRepositoryImpl(
    ref.read(databaseProvider),
    ref.read(uuidProvider),
  );
});

final addExpenseProvider = Provider<AddExpense>((ref) {
  return AddExpense(ref.read(expenseRepositoryProvider));
});

final featureFlagsRepositoryProvider = Provider<FeatureFlagsRepository>((ref) {
  return FeatureFlagsRepository();
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepository();
});

final exportRepositoryProvider = Provider<ExportRepository>((ref) {
  return ExportRepository(ref.read(databaseProvider));
});

final receiptOcrServiceProvider = Provider<ReceiptOcrService>((ref) {
  return const StubReceiptOcrService();
});

final expenseCategorizerProvider = Provider<ExpenseCategorizer>((ref) {
  return const StubExpenseCategorizer();
});

final syncServiceProvider = Provider<SyncService>((ref) {
  return const StubSyncService();
});
