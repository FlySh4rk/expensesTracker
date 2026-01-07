import 'expense_source.dart';

class Expense {
  const Expense({
    required this.id,
    required this.amountCents,
    required this.currency,
    required this.occurredAt,
    required this.categoryId,
    required this.source,
    required this.createdAt,
    required this.updatedAt,
    this.merchant,
    this.note,
    this.deletedAt,
  });

  final String id;
  final int amountCents;
  final String currency;
  final DateTime occurredAt;
  final String categoryId;
  final String? merchant;
  final String? note;
  final ExpenseSource source;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  Expense copyWith({
    int? amountCents,
    String? currency,
    DateTime? occurredAt,
    String? categoryId,
    String? merchant,
    String? note,
    ExpenseSource? source,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return Expense(
      id: id,
      amountCents: amountCents ?? this.amountCents,
      currency: currency ?? this.currency,
      occurredAt: occurredAt ?? this.occurredAt,
      categoryId: categoryId ?? this.categoryId,
      merchant: merchant ?? this.merchant,
      note: note ?? this.note,
      source: source ?? this.source,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}
