import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../app/theme/app_theme.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    final usernameCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: size.height * 0.42,
              decoration: const BoxDecoration(
                color: AppColors.charcoal,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
              ),
              child: Stack(
                children: [
                  // Photo placeholder + greeting
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColors.sand,
                              width: 2.5,
                            ),
                            color: AppColors.navy.withOpacity(0.4),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(13),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset('assets/images/profile.jpeg'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Selamat Datang',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 0.3,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Masuk untuk melanjutkan',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.6),
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ── Form section ────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 32, 28, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Label
                  const Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2.5,
                      color: AppColors.slate,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Username
                  Obx(() => TextField(
                        controller: usernameCtrl,
                        maxLength: 50,
                        enabled: !controller.isLocked.value,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          prefixIcon: const Icon(Icons.person_outline_rounded),
                          counterText: '',
                          errorText: controller.usernameError.value.isEmpty
                              ? null
                              : controller.usernameError.value,
                        ),
                        textInputAction: TextInputAction.next,
                        onChanged: (_) => controller.usernameError.value = '',
                      )),
                  const SizedBox(height: 14),

                  // Password
                  Obx(() => TextField(
                        controller: passwordCtrl,
                        maxLength: 50,
                        obscureText: !controller.passwordVisible.value,
                        enabled: !controller.isLocked.value,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          counterText: '',
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.passwordVisible.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppColors.slate,
                            ),
                            onPressed: controller.togglePasswordVisibility,
                          ),
                          errorText: controller.passwordError.value.isEmpty
                              ? null
                              : controller.passwordError.value,
                        ),
                        textInputAction: TextInputAction.done,
                        onChanged: (_) => controller.passwordError.value = '',
                        onSubmitted: (_) =>
                            controller.login(usernameCtrl.text, passwordCtrl.text),
                      )),
                  const SizedBox(height: 10),

                  // Lockout / General error
                  Obx(() {
                    if (controller.isLocked.value) {
                      return _LockoutBanner(
                          seconds: controller.lockoutCountdown.value);
                    }
                    if (controller.generalError.value.isNotEmpty) {
                      return _ErrorBanner(
                          message: controller.generalError.value);
                    }
                    return const SizedBox.shrink();
                  }),

                  const SizedBox(height: 22),

                  // Login button
                  Obx(() {
                    final disabled = controller.isLocked.value ||
                        controller.isLoading.value;
                    return GestureDetector(
                      onTap: disabled
                          ? null
                          : () => controller.login(
                              usernameCtrl.text, passwordCtrl.text),
                      child: AnimatedOpacity(
                        opacity: disabled ? 0.5 : 1.0,
                        duration: const Duration(milliseconds: 200),
                        child: Container(
                          width: double.infinity,
                          height: 52,
                          decoration: BoxDecoration(
                            color:  AppColors.sand,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: disabled
                                ? []
                                : [
                                    BoxShadow(
                                      color: AppColors.deepBlue.withOpacity(0.4),
                                      blurRadius: 16,
                                      offset: const Offset(0, 6),
                                    )
                                  ],
                          ),
                          child: Center(
                            child: controller.isLoading.value
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        color: Colors.white),
                                  )
                                : const Text(
                                    'MASUK',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14,
                                      letterSpacing: 2,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LockoutBanner extends StatelessWidget {
  final int seconds;
  const _LockoutBanner({required this.seconds});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        children: [
          const Icon(Icons.lock_clock_outlined, color: Colors.red, size: 17),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Terlalu banyak percobaan. Coba lagi dalam $seconds detik',
              style: const TextStyle(
                  color: Colors.red, fontSize: 12.5, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  final String message;
  const _ErrorBanner({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          const Icon(Icons.error_outline_rounded,
              color: Colors.redAccent, size: 15),
          const SizedBox(width: 6),
          Expanded(
            child: Text(message,
                style: const TextStyle(color: Colors.redAccent, fontSize: 12.5)),
          ),
        ],
      ),
    );
  }
}
