import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/char_counter_controller.dart';
import '../../app/theme/app_theme.dart';
import '../../app/theme/app_widgets.dart';

class CharCounterView extends StatelessWidget {
  const CharCounterView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CharCounterController>();
    final inputCtrl = TextEditingController();

    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration:
                const BoxDecoration(color: AppColors.textSub),
            child: const GradientAppBar(title: 'Hitung Karakter'),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                      title: 'Input Teks', icon: Icons.text_fields_rounded),
                  const InfoBanner(
                    text:
                        'Tempel teks apapun — termasuk artikel panjang. Program memproses hingga 50.000 karakter tanpa crash.',
                  ),
                  const SizedBox(height: 18),

                  Obx(() => TextField(
                        controller: inputCtrl,
                        maxLines: 6,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          labelText: 'Masukkan atau tempel teks di sini',
                          alignLabelWithHint: true,
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(bottom: 80),
                            child: Icon(Icons.article_outlined),
                          ),
                          errorText: controller.inputError.value.isEmpty
                              ? null
                              : controller.inputError.value,
                        ),
                        onChanged: (_) => controller.inputError.value = '',
                      )),
                  const SizedBox(height: 8),

                  Obx(() => controller.wasTruncated.value
                      ? Container(
                          margin: const EdgeInsets.only(top: 6),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.amber.shade50,
                            borderRadius: BorderRadius.circular(9),
                            border: Border.all(color: Colors.amber.shade300),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.warning_amber_rounded,
                                  color: Colors.amber, size: 15),
                              SizedBox(width: 7),
                              Expanded(
                                child: Text(
                                  'Input terlalu panjang, diproses 50.000 karakter pertama',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.amber),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink()),

                  const SizedBox(height: 16),

                  Obx(() => GradientButton(
                        label: controller.isLoading.value
                            ? 'MENGHITUNG...'
                            : 'HITUNG KARAKTER',
                        icon: controller.isLoading.value
                            ? Icons.hourglass_top_rounded
                            : Icons.calculate_rounded,
                        colors: const [AppColors.charcoal, AppColors.navy],
                        onPressed: controller.isLoading.value
                            ? null
                            : () => controller.count(inputCtrl.text),
                      )),

                  const SizedBox(height: 26),

                  Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: CircularProgressIndicator(
                              color: AppColors.deepBlue),
                        ),
                      );
                    }
                    if (!controller.hasResult.value) return const SizedBox.shrink();

                    return Column(
                      children: [
                        // Total
                        ResultCard(
                          label: 'TOTAL KARAKTER',
                          value: '${controller.total.value}',
                          accentColor: AppColors.navy,
                        ),
                        const SizedBox(height: 14),

                        // Breakdown row
                        Row(
                          children: [
                            Expanded(
                              child: _BreakdownCard(
                                icon: Icons.abc_rounded,
                                label: 'Huruf',
                                count: controller.letters.value,
                                colors: const [AppColors.deepBlue, AppColors.blue],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _BreakdownCard(
                                icon: Icons.tag_rounded,
                                label: 'Angka',
                                count: controller.digits.value,
                                colors: const [AppColors.charcoal, AppColors.navy],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _BreakdownCard(
                                icon: Icons.emoji_symbols_rounded,
                                label: 'Simbol',
                                count: controller.symbols.value,
                                colors: const [AppColors.slate, AppColors.deepBlue],
                              ),
                            ),
                          ],
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

class _BreakdownCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final int count;
  final List<Color> colors;

  const _BreakdownCard({
    required this.icon,
    required this.label,
    required this.count,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
            color: AppColors.navy,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, color: Colors.white, size: 18),
          ),
          const SizedBox(height: 8),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: colors.first,
            ),
          ),
          const SizedBox(height: 2),
          Text(label,
              style: const TextStyle(
                  fontSize: 11, color: AppColors.textSub)),
        ],
      ),
    );
  }
}
