import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:expenses_tracker/data/db/app_database.dart';
import 'package:expenses_tracker/data/repositories/category_repository_impl.dart';
import 'package:expenses_tracker/data/repositories/expense_repository_impl.dart';
import 'package:expenses_tracker/data/repositories/uuid_generator.dart';
import 'package:expenses_tracker/domain/entities/expense.dart';
import 'package:expenses_tracker/domain/entities/expense_source.dart';

void main() {
  late AppDatabase db;
  late ExpenseRepositoryImpl repo;
  late CategoryRepositoryImpl categoryRepo;

  setUp(() async {
    db = AppDatabase(executor: NativeDatabase.memory());
    repo = ExpenseRepositoryImpl(db, const UuidGenerator());
    categoryRepo = CategoryRepositoryImpl(db);
    await categoryRepo.insertDefaultsIfNeeded();
  });

  tearDown(() async {
    await db.close();
  });

  test('insert expense and fetch monthly total', () async {
    final now = DateTime(2024, 6, 10);
    final expense = Expense(
      id: '1',
      amountCents: 1200,
      currency: 'EUR',
      occurredAt: now,
      categoryId: 'groceries_food_home',
      merchant: 'Market',
      note: null,
      source: ExpenseSource.manual,
      createdAt: now,
      updatedAt: now,
      deletedAt: null,
    );

    await repo.upsertExpense(expense);

    final total = await repo.watchMonthlyTotal(now).first;
    expect(total, 1200);
  });

  test('totals by category', () async {
    final now = DateTime(2024, 6, 10);
    await repo.upsertExpense(
      Expense(
        id: '1',
        amountCents: 1000,
        currency: 'EUR',
        occurredAt: now,
        categoryId: 'groceries_food_home',
        merchant: null,
        note: null,
        source: ExpenseSource.manual,
        createdAt: now,
        updatedAt: now,
        deletedAt: null,
      ),
    );
    await repo.upsertExpense(
      Expense(
        id: '2',
        amountCents: 500,
        currency: 'EUR',
        occurredAt: now,
        categoryId: 'transport',
        merchant: null,
        note: null,
        source: ExpenseSource.manual,
        createdAt: now,
        updatedAt: now,
        deletedAt: null,
      ),
    );

    final totals = await repo.watchMonthlyTotalsByCategory(now).first;
    expect(totals['groceries_food_home'], 1000);
    expect(totals['transport'], 500);
  });

  test('soft delete removes from totals', () async {
    final now = DateTime(2024, 6, 10);
    final expense = Expense(
      id: '1',
      amountCents: 1200,
      currency: 'EUR',
      occurredAt: now,
      categoryId: 'groceries_food_home',
      merchant: 'Market',
      note: null,
      source: ExpenseSource.manual,
      createdAt: now,
      updatedAt: now,
      deletedAt: null,
    );

    await repo.upsertExpense(expense);
    await repo.softDeleteExpense('1', now);

    final total = await repo.watchMonthlyTotal(now).first;
    expect(total, 0);
  });

  test('search filters merchant and note', () async {
    final now = DateTime(2024, 6, 10);
    await repo.upsertExpense(
      Expense(
        id: '1',
        amountCents: 1200,
        currency: 'EUR',
        occurredAt: now,
        categoryId: 'groceries_food_home',
        merchant: 'Coffee Bar',
        note: null,
        source: ExpenseSource.manual,
        createdAt: now,
        updatedAt: now,
        deletedAt: null,
      ),
    );
    await repo.upsertExpense(
      Expense(
        id: '2',
        amountCents: 500,
        currency: 'EUR',
        occurredAt: now,
        categoryId: 'transport',
        merchant: null,
        note: 'Tram ticket',
        source: ExpenseSource.manual,
        createdAt: now,
        updatedAt: now,
        deletedAt: null,
      ),
    );

    final results = await repo.watchSearchResults(month: now, query: 'Coffee').first;
    expect(results.length, 1);
    expect(results.first.id, '1');
  });
}
