class InputSanitizer {
  /// Cek apakah input mengandung HTML tags
  static bool containsHtml(String input) {
    return RegExp(r'<[^>]*>').hasMatch(input);
  }

  /// Bersihkan input angka: hanya izinkan digit, titik, koma, dan minus di awal
  static String sanitizeNumber(String input) {
    // Ganti koma dengan titik (desimal)
    String result = input.trim().replaceAll(',', '.');
    // Hapus semua karakter selain digit, titik, dan minus
    // Pertahankan minus hanya di posisi pertama
    bool isNegative = result.startsWith('-');
    result = result.replaceAll(RegExp(r'[^0-9.]'), '');
    // Pastikan hanya ada satu titik desimal
    final parts = result.split('.');
    if (parts.length > 2) {
      result = '${parts[0]}.${parts.sublist(1).join('')}';
    }
    if (isNegative && result.isNotEmpty) result = '-$result';
    return result;
  }

  /// Potong input jika terlalu panjang
  static String truncate(String input, {int maxLength = 50000}) {
    if (input.length > maxLength) return input.substring(0, maxLength);
    return input;
  }

  /// Cek apakah string adalah angka valid (termasuk desimal dan negatif)
  static bool isValidNumber(String input) {
    if (input.trim().isEmpty) return false;
    return double.tryParse(input.trim().replaceAll(',', '.')) != null;
  }

  /// Cek apakah string adalah integer valid
  static bool isValidInteger(String input) {
    if (input.trim().isEmpty) return false;
    return int.tryParse(input.trim()) != null;
  }

  /// Trim dan validasi username (satu kata, tanpa spasi)
  static String trimUsername(String input) => input.trim();

  static bool usernameHasSpaces(String input) => input.trim().contains(' ');

  /// Cek apakah hasil double valid (bukan NaN / Infinity)
  static bool isValidResult(double value) {
    return !value.isNaN && !value.isInfinite;
  }

  /// Cek apakah input angka terlalu besar
  static bool isTooBig(String input, {int maxLength = 20}) {
    return input.replaceAll('-', '').replaceAll('.', '').length > maxLength;
  }
}
