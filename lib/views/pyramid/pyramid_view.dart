import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/pyramid_controller.dart';
import '../../app/theme/app_theme.dart';
import '../../app/theme/app_widgets.dart';

class PyramidView extends StatelessWidget {
  const PyramidView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PyramidController>();
    final ctrlA = TextEditingController();
    final ctrlB = TextEditingController();
    final ctrlT = TextEditingController();

    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration:
                const BoxDecoration(color: AppColors.navy),
            child: const GradientAppBar(title: 'Luas & Volume Piramid'),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Pyramid diagram card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.deepBlue,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.change_history_outlined,
                            size: 52, color: Colors.white70),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Piramid Segiempat',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'V = ⅓ × a × b × t',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white.withOpacity(0.6),
                                  letterSpacing: 0.3),
                            ),
                            Text(
                              'L = (a×b) + sisi miring',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white.withOpacity(0.6),
                                  letterSpacing: 0.3),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),

                  const SectionHeader(
                      title: 'Masukkan Dimensi', icon: Icons.straighten_outlined),

                  // Field Panjang Alas (a)
                  _PyramidField(
                    ctrl: ctrlA,
                    label: 'Panjang Alas (a)',
                    hint: 'contoh: 10',
                    icon: Icons.width_normal_outlined,
                    errorObs: controller.errorA,
                  ),
                  const SizedBox(height: 14),

                  // Field Lebar Alas (b)
                  _PyramidField(
                    ctrl: ctrlB,
                    label: 'Lebar Alas (b)',
                    hint: 'contoh: 8',
                    icon: Icons.height_outlined,
                    errorObs: controller.errorB,
                  ),
                  const SizedBox(height: 14),

                  // Field Tinggi (t)
                  _PyramidField(
                    ctrl: ctrlT,
                    label: 'Tinggi Piramid (t)',
                    hint: 'contoh: 6',
                    icon: Icons.vertical_align_top_rounded,
                    errorObs: controller.errorT,
                  ),
                  const SizedBox(height: 22),

                  GradientButton(
                    label: 'HITUNG',
                    icon: Icons.functions_rounded,
                    colors: const [AppColors.navy, AppColors.deepBlue],
                    onPressed: () =>
                        controller.calculate(ctrlA.text, ctrlB.text, ctrlT.text),
                  ),
                  const SizedBox(height: 26),

                  Obx(() {
                    if (!controller.hasResult.value) return const SizedBox.shrink();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionHeader(
                            title: 'Hasil Perhitungan',
                            icon: Icons.bar_chart_rounded),
                        _ResultTile(
                          icon: Icons.square_outlined,
                          label: 'LUAS ALAS',
                          value: controller.luasAlas.value,
                          colors: const [AppColors.charcoal, AppColors.navy],
                        ),
                        const SizedBox(height: 10),
                        _ResultTile(
                          icon: Icons.layers_outlined,
                          label: 'LUAS PERMUKAAN TOTAL',
                          value: controller.luasPermukaan.value,
                          colors: const [AppColors.deepBlue, AppColors.blue],
                        ),
                        const SizedBox(height: 10),
                        _ResultTile(
                          icon: Icons.view_in_ar_outlined,
                          label: 'VOLUME',
                          value: controller.volume.value,
                          colors: const [AppColors.navy, AppColors.charcoal],
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

class _PyramidField extends StatelessWidget {
  final TextEditingController ctrl;
  final String label;
  final String hint;
  final IconData icon;
  final RxString errorObs;

  const _PyramidField({
    required this.ctrl,
    required this.label,
    required this.hint,
    required this.icon,
    required this.errorObs,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => TextField(
          controller: ctrl,
          maxLength: 20,
          keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            prefixIcon: Icon(icon),
            counterText: '',
            errorText:
                errorObs.value.isEmpty ? null : errorObs.value,
          ),
          onChanged: (_) => errorObs.value = '',
        ));
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
              color: AppColors.navy,
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
                    fontSize: 15,
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
