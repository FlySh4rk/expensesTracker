class CategorizationResult {
  const CategorizationResult({required this.categoryId, this.confidence = 0});

  final String categoryId;
  final double confidence;
}

abstract class ExpenseCategorizer {
  Future<CategorizationResult> categorizeFromReceiptText({
    required String merchant,
    required String cleanedText,
    required int totalCents,
  });
}

class StubExpenseCategorizer implements ExpenseCategorizer {
  const StubExpenseCategorizer();

  @override
  Future<CategorizationResult> categorizeFromReceiptText({
    required String merchant,
    required String cleanedText,
    required int totalCents,
  }) {
    throw UnimplementedError('Online AI categorization is not enabled in MVP.');
  }
}
