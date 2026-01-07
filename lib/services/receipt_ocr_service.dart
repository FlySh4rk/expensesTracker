import 'dart:typed_data';

class OcrResult {
  const OcrResult({required this.rawText});

  final String rawText;
}

abstract class ReceiptOcrService {
  Future<OcrResult> extractTextFromImage(Uint8List imageBytes);
}

class StubReceiptOcrService implements ReceiptOcrService {
  const StubReceiptOcrService();

  @override
  Future<OcrResult> extractTextFromImage(Uint8List imageBytes) {
    throw UnimplementedError('Online OCR service is not enabled in MVP.');
  }
}
