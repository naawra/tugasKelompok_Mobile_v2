import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../app/utils/input_sanitizer.dart';
import '../app/routes/app_routes.dart';

class AuthController extends GetxController {
  static const _correctUsername = 'admin';
  static const _correctPassword = '1234';
  static const _maxAttempts = 3;
  static const _lockoutSeconds = 30;

  final _storage = const FlutterSecureStorage();

  // Observables
  final isLoading = false.obs;
  final isLocked = false.obs;
  final lockoutCountdown = 0.obs;
  final failedAttempts = 0.obs;
  final passwordVisible = false.obs;

  // Error messages
  final usernameError = ''.obs;
  final passwordError = ''.obs;
  final generalError = ''.obs;

  Timer? _lockoutTimer;

  @override
  void onClose() {
    _lockoutTimer?.cancel();
    super.onClose();
  }

  void togglePasswordVisibility() => passwordVisible.toggle();

  /// Validate and attempt login
  Future<void> login(String rawUsername, String rawPassword) async {
    // Clear previous errors
    usernameError.value = '';
    passwordError.value = '';
    generalError.value = '';

    if (isLocked.value) return;

    // Trim username
    final username = InputSanitizer.trimUsername(rawUsername);
    final password = rawPassword;

    // --- Validations ---
    bool hasError = false;

    if (username.isEmpty) {
      usernameError.value = 'Username tidak boleh kosong';
      hasError = true;
    } else if (InputSanitizer.usernameHasSpaces(username)) {
      usernameError.value = 'Username hanya boleh satu kata tanpa spasi';
      hasError = true;
    }

    if (password.isEmpty) {
      passwordError.value = 'Password tidak boleh kosong';
      hasError = true;
    }

    if (hasError) return;

    isLoading.value = true;

    // Simulate slight delay for UX
    await Future.delayed(const Duration(milliseconds: 300));

    if (username == _correctUsername && password == _correctPassword) {
      failedAttempts.value = 0;
      await _storage.write(key: 'is_logged_in', value: 'true');
      isLoading.value = false;
      Get.offAllNamed(AppRoutes.HOME);
    } else {
      failedAttempts.value++;
      isLoading.value = false;

      if (failedAttempts.value >= _maxAttempts) {
        _startLockout();
      } else {
        final remaining = _maxAttempts - failedAttempts.value;
        generalError.value =
            'Username atau password salah. Sisa percobaan: $remaining';
      }
    }
  }

  void _startLockout() {
    isLocked.value = true;
    lockoutCountdown.value = _lockoutSeconds;
    generalError.value = '';

    _lockoutTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      lockoutCountdown.value--;
      if (lockoutCountdown.value <= 0) {
        timer.cancel();
        isLocked.value = false;
        failedAttempts.value = 0;
        generalError.value = '';
      }
    });
  }

  Future<void> logout() async {
    try {
      await _storage.delete(key: 'is_logged_in');
    } catch (_) {}
    Get.offAllNamed(AppRoutes.LOGIN);
  }
}
