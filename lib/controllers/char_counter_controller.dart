import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../app/utils/input_sanitizer.dart';

Map<String, int> _countCharsIsolate(String input) {
  int letters = 0, digits = 0, symbols = 0;
  for (int i = 0; i < input.length; i++) {
    final char = input[i];
    if (RegExp(r'[a-zA-Z]').hasMatch(char)) {
      letters++;
    } else if (RegExp(r'[0-9]').hasMatch(char)) {
      digits++;
    } else {
      symbols++;
    }
  }
  return {
    'letters': letters,
    'digits': digits,
    'symbols': symbols,
    'total': input.length,
  };
}

class CharCounterController extends GetxController {
  static const int _maxLength = 3000;

  final inputError = ''.obs;
  final letters = 0.obs;
  final digits = 0.obs;
  final symbols = 0.obs;
  final total = 0.obs;
  final hasResult = false.obs;
  final isLoading = false.obs;
  final wasTruncated = false.obs;

  int get maxLength => _maxLength;

  Future<void> count(String rawInput) async {
    inputError.value = '';
    hasResult.value = false;
    wasTruncated.value = false;

    if (rawInput.isEmpty) {
      inputError.value = 'Input tidak boleh kosong';
      return;
    }

    String input = rawInput;

    if (input.length > _maxLength) {
      input = InputSanitizer.truncate(input, maxLength: _maxLength);
      wasTruncated.value = true;
    }

    isLoading.value = true;

    try {
      final result = input.length > 5000
          ? await compute(_countCharsIsolate, input)
          : _countCharsIsolate(input);

      letters.value = result['letters'] ?? 0;
      digits.value = result['digits'] ?? 0;
      symbols.value = result['symbols'] ?? 0;
      total.value = result['total'] ?? 0;
      hasResult.value = true;
    } catch (e) {
      inputError.value = 'Terjadi kesalahan saat memproses input';
    } finally {
      isLoading.value = false;
    }
  }
}
