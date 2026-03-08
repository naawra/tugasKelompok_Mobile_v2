import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/arithmetic_controller.dart';
import '../../app/theme/app_theme.dart';
import '../../app/theme/app_widgets.dart';

class ArithmeticView extends StatelessWidget {
  const ArithmeticView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ArithmeticController>();
    final ctrlA = TextEditingController();
    final ctrlB = TextEditingController();

    return Scaffold(
      body: Column(
        children: [
          // Gradient AppBar
          Container(
            decoration: const BoxDecoration(gradient: AppColors.appBarGradient),
            child: const GradientAppBar(title: 'Penjumlahan & Pengurangan'),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                      title: 'Masukkan Dua Angka', icon: Icons.functions),
                  const InfoBanner(
                    text:
                        'Mendukung bilangan desimal (titik/koma) dan negatif. Maks. 20 karakter per field.',
                  ),
                  const SizedBox(height: 18),

                  // Field A
                  Obx(() => TextField(
                        controller: ctrlA,
                        maxLength: 20,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true, signed: true),
                        decoration: InputDecoration(
                          labelText: 'Angka A',
                          prefixIcon:
                              const Icon(Icons.looks_one_outlined),
                          counterText: '',
                          errorText: controller.errorA.value.isEmpty
                              ? null
                              : controller.errorA.value,
                        ),
                        onChanged: (_) => controller.errorA.value = '',
                      )),
                  const SizedBox(height: 14),

                  // Field B
                  Obx(() => TextField(
                        controller: ctrlB,
                        maxLength: 20,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true, signed: true),
                        decoration: InputDecoration(
                          labelText: 'Angka B',
                          prefixIcon:
                              const Icon(Icons.looks_two_outlined),
                          counterText: '',
                          errorText: controller.errorB.value.isEmpty
                              ? null
                              : controller.errorB.value,
                        ),
                        onChanged: (_) => controller.errorB.value = '',
                      )),
                  const SizedBox(height: 22),

                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: GradientButton(
                          label: 'JUMLAH',
                          icon: Icons.add_rounded,
                          colors: const [AppColors.deepBlue, AppColors.blue],
                          onPressed: () =>
                              controller.add(ctrlA.text, ctrlB.text),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GradientButton(
                          label: 'KURANG',
                          icon: Icons.remove_rounded,
                          colors: const [AppColors.charcoal, AppColors.navy],
                          onPressed: () =>
                              controller.subtract(ctrlA.text, ctrlB.text),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 26),

                  // Result
                  Obx(() {
                    if (!controller.hasResult.value) return const SizedBox.shrink();
                    return ResultCard(
                      label: controller.resultLabel.value,
                      value: controller.result.value,
                      accentColor: AppColors.deepBlue,
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
