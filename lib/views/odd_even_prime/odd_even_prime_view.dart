import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/odd_even_prime_controller.dart';
import '../../app/theme/app_theme.dart';
import '../../app/theme/app_widgets.dart';

class OddEvenPrimeView extends StatelessWidget {
  const OddEvenPrimeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OddEvenPrimeController>();
    final inputCtrl = TextEditingController();

    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration:
                const BoxDecoration(color: AppColors.navy),
            child: const GradientAppBar(title: 'Ganjil, Genap & Prima'),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                      title: 'Cek Bilangan', icon: Icons.numbers_outlined),
                  const InfoBanner(
                    text:
                        'Masukkan bilangan bulat. Angka 0 dan 1 bukan bilangan prima. Bilangan negatif tidak termasuk prima.',
                  ),
                  const SizedBox(height: 18),

                  Obx(() => TextField(
                        controller: inputCtrl,
                        maxLength: 20,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true),
                        decoration: InputDecoration(
                          labelText: 'Masukkan Angka',
                          prefixIcon: const Icon(Icons.tag_rounded),
                          counterText: '',
                          errorText: controller.inputError.value.isEmpty
                              ? null
                              : controller.inputError.value,
                        ),
                        onChanged: (_) => controller.inputError.value = '',
                        onSubmitted: (_) => controller.check(inputCtrl.text),
                      )),
                  const SizedBox(height: 18),

                  GradientButton(
                    label: 'CEK BILANGAN',
                    icon: Icons.search_rounded,
                    colors: const [AppColors.deepBlue, AppColors.blue],
                    onPressed: () => controller.check(inputCtrl.text),
                  ),
                  const SizedBox(height: 26),

                  Obx(() {
                    if (!controller.hasResult.value) return const SizedBox.shrink();
                    return Column(
                      children: [
                        _ResultTile(
                          icon: Icons.swap_horiz_rounded,
                          label: 'GANJIL / GENAP',
                          value: controller.oddEvenResult.value,
                          colors: const [AppColors.deepBlue, AppColors.blue],
                        ),
                        const SizedBox(height: 10),
                        _ResultTile(
                          icon: Icons.star_rounded,
                          label: 'BILANGAN PRIMA',
                          value: controller.primeResult.value,
                          colors: const [AppColors.charcoal, AppColors.navy],
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final List<Color> colors;

  const _ResultTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
            color: AppColors.deepBlue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                    color: AppColors.textSub,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
