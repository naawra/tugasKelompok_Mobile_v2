import 'dart:math';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../app/utils/input_sanitizer.dart';

class PyramidController extends GetxController {
  final errorA = ''.obs;
  final errorB = ''.obs;
  final errorT = ''.obs;

  final luasAlas = ''.obs;
  final luasPermukaan = ''.obs;
  final volume = ''.obs;
  final hasResult = false.obs;

  final _formatter = NumberFormat('#,##0.######', 'id_ID');

  void calculate(String rawA, String rawB, String rawT) {
    errorA.value = '';
    errorB.value = '';
    errorT.value = '';
    hasResult.value = false;

    bool valid = true;

    valid &= _validateField(rawA, errorA);
    valid &= _validateField(rawB, errorB);
    valid &= _validateField(rawT, errorT);

    if (!valid) return;

    final a = double.tryParse(InputSanitizer.sanitizeNumber(rawA))!;
    final b = double.tryParse(InputSanitizer.sanitizeNumber(rawB))!;
    final t = double.tryParse(InputSanitizer.sanitizeNumber(rawT))!;

    if (a > 1e15 || b > 1e15 || t > 1e15) {
      errorA.value = 'Nilai terlalu besar untuk dihitung';
      return;
    }

    try {
      final la = a * b;
      final slantA = sqrt(pow(a / 2, 2) + pow(t, 2));
      final slantB = sqrt(pow(b / 2, 2) + pow(t, 2));
      final lp = la + (b * slantA) + (a * slantB);
      final v = (1 / 3) * a * b * t;

      if (!InputSanitizer.isValidResult(la) ||
          !InputSanitizer.isValidResult(lp) ||
          !InputSanitizer.isValidResult(v)) {
        errorA.value = 'Hasil tidak valid, periksa kembali input';
        return;
      }

      luasAlas.value = '${_formatter.format(la)} satuan²';
      luasPermukaan.value = '${_formatter.format(lp)} satuan²';
      volume.value = '${_formatter.format(v)} satuan³';
      hasResult.value = true;
    } catch (e) {
      errorA.value = 'Terjadi kesalahan dalam perhitungan';
    }
  }

  bool _validateField(String raw, RxString errorObs) {
    final input = raw.trim();

    if (input.isEmpty) {
      errorObs.value = 'Field tidak boleh kosong';
      return false;
    }
    if (InputSanitizer.containsHtml(input)) {
      errorObs.value = 'Input mengandung karakter tidak valid';
      return false;
    }
    if (!InputSanitizer.isValidNumber(input)) {
      errorObs.value = 'Input harus berupa angka';
      return false;
    }

    final val = double.tryParse(InputSanitizer.sanitizeNumber(input));
    if (val == null || val <= 0) {
      errorObs.value = 'Nilai harus lebih dari 0';
      return false;
    }

    return true;
  }
}
