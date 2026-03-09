import 'package:get/get.dart';
import '../app/utils/input_sanitizer.dart';

class OddEvenPrimeController extends GetxController {
  final inputError = ''.obs;
  final oddEvenResult = ''.obs;
  final primeResult = ''.obs;
  final hasResult = false.obs;

  void check(String rawInput) {
    inputError.value = '';
    oddEvenResult.value = '';
    primeResult.value = '';
    hasResult.value = false;

    final input = rawInput.trim();

    if (input.isEmpty) {
      inputError.value = 'Input tidak boleh kosong';
      return;
    }

    if (InputSanitizer.containsHtml(input)) {
      inputError.value = 'Input mengandung karakter tidak valid';
      return;
    }

    if (input.length > 20) {
      inputError.value = 'Angka terlalu besar untuk diproses';
      return;
    }

    // Cek apakah desimal
    final sanitized = input.replaceAll(',', '.');
    final parsed = double.tryParse(sanitized);
    if (parsed == null) {
      inputError.value = 'Input harus berupa angka';
      return;
    }

    // Cek desimal
    if (parsed != parsed.truncateToDouble()) {
      inputError.value = 'Bilangan desimal tidak bisa dicek ganjil/genap/prima';
      return;
    }

    final number = parsed.toInt();

    // Ganjil / Genap
    if (number < 0) {
      oddEvenResult.value = number.abs() % 2 == 0
        ? '$number adalah Bilangan Genap (negatif)'
        : '$number adalah Bilangan Ganjil (negatif)';
      primeResult.value = 'Angka negatif bukan bilangan prima';
    } else {
      oddEvenResult.value =
        number % 2 == 0 ? '$number adalah Bilangan Genap' : '$number adalah Bilangan Ganjil';
      primeResult.value = _checkPrime(number)
        ? '$number adalah Bilangan Prima'
        : '$number bukan Bilangan Prima';
    }

    hasResult.value = true;
  }

  bool _checkPrime(int n) {
    if (n < 2) return false;
    if (n == 2) return true;
    if (n % 2 == 0) return false;
    for (int i = 3; i * i <= n; i += 2) {
      if (n % i == 0) return false;
    }
    return true;
  }
}
