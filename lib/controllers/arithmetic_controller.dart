import 'package:get/get.dart';
import '../app/utils/input_sanitizer.dart';

class ArithmeticController extends GetxController {
  final result = ''.obs;
  final resultLabel = ''.obs;
  final errorA = ''.obs;
  final errorB = ''.obs;
  final hasResult = false.obs;

  void _clearErrors() {
    errorA.value = '';
    errorB.value = '';
    result.value = '';
    hasResult.value = false;
    resultLabel.value = '';
  }

  bool _validateInputs(String rawA, String rawB) {
    bool valid = true;

    if (rawA.trim().isEmpty) {
      errorA.value = 'Field tidak boleh kosong';
      valid = false;
    } else if (InputSanitizer.containsHtml(rawA)) {
      errorA.value = 'Input mengandung karakter tidak valid';
      valid = false;
    } else if (InputSanitizer.isTooBig(rawA)) {
      errorA.value = 'Angka terlalu besar';
      valid = false;
    } else if (!InputSanitizer.isValidNumber(rawA)) {
      errorA.value = 'Input harus berupa angka';
      valid = false;
    }

    if (rawB.trim().isEmpty) {
      errorB.value = 'Field tidak boleh kosong';
      valid = false;
    } else if (InputSanitizer.containsHtml(rawB)) {
      errorB.value = 'Input mengandung karakter tidak valid';
      valid = false;
    } else if (InputSanitizer.isTooBig(rawB)) {
      errorB.value = 'Angka terlalu besar';
      valid = false;
    } else if (!InputSanitizer.isValidNumber(rawB)) {
      errorB.value = 'Input harus berupa angka';
      valid = false;
    }

    return valid;
  }

  void add(String rawA, String rawB) {
    _clearErrors();
    if (!_validateInputs(rawA, rawB)) return;

    final a = double.tryParse(InputSanitizer.sanitizeNumber(rawA));
    final b = double.tryParse(InputSanitizer.sanitizeNumber(rawB));
    if (a == null || b == null) {
      errorA.value = 'Input tidak valid';
      return;
    }

    final res = a + b;
    if (!InputSanitizer.isValidResult(res)) {
      result.value = 'Hasil tidak valid (overflow)';
      hasResult.value = true;
      return;
    }

    resultLabel.value = 'Hasil Penjumlahan';
    result.value = _formatResult(res);
    hasResult.value = true;
  }

  void subtract(String rawA, String rawB) {
    _clearErrors();
    if (!_validateInputs(rawA, rawB)) return;

    final a = double.tryParse(InputSanitizer.sanitizeNumber(rawA));
    final b = double.tryParse(InputSanitizer.sanitizeNumber(rawB));
    if (a == null || b == null) {
      errorA.value = 'Input tidak valid';
      return;
    }

    final res = a - b;
    if (!InputSanitizer.isValidResult(res)) {
      result.value = 'Hasil tidak valid (overflow)';
      hasResult.value = true;
      return;
    }

    resultLabel.value = 'Hasil Pengurangan';
    result.value = _formatResult(res);
    hasResult.value = true;
  }

  String _formatResult(double value) {
    if (value == value.truncateToDouble()) {
      return value.toInt().toString();
    }
    return value.toStringAsFixed(6).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
  }
}
