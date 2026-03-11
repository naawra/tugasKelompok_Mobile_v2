import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/stopwatch_controller.dart';
import '../../app/theme/app_theme.dart';

class StopwatchView extends StatelessWidget {
  const StopwatchView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StopwatchController>();

    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(color: AppColors.slate),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new,
                            size: 18, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Expanded(
                        child: Text(
                          'Stopwatch',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 17),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 30),
                    child: Column(
                      children: [
                        Obx(() => Text(
                              controller
                                  .formatDuration(controller.elapsed.value),
                              style: const TextStyle(
                                fontSize: 54,
                                fontWeight: FontWeight.w200,
                                color: Colors.white,
                                letterSpacing: 3,
                              ),
                            )),
                        const SizedBox(height: 6),
                        Obx(() => _StatusPill(state: controller.state.value)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 28),
            child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Start / Resume
                    _CtrlBtn(
                      icon: controller.isPaused
                          ? Icons.play_arrow_rounded
                          : Icons.play_circle_outline_rounded,
                      label: controller.isPaused ? 'Lanjut' : 'Mulai',
                      colors: const [Color(0xFF1A5C2B), Color(0xFF2DC653)],
                      enabled: !controller.isRunning,
                      onTap: controller.start,
                    ),
                    // Pause
                    _CtrlBtn(
                      icon: Icons.pause_circle_outline_rounded,
                      label: 'Pause',
                      colors: const [Color(0xFF8B5500), Color(0xFFFF9500)],
                      enabled: controller.isRunning,
                      onTap: controller.pause,
                    ),
                    // Lap
                    _CtrlBtn(
                      icon: Icons.flag_outlined,
                      label: 'Lap',
                      colors: const [AppColors.deepBlue, AppColors.blue],
                      enabled: controller.isRunning,
                      onTap: controller.lap,
                    ),
                    // Reset
                    _CtrlBtn(
                      icon: Icons.restart_alt_rounded,
                      label: 'Reset',
                      colors: const [Color(0xFF8B1A1A), Colors.redAccent],
                      enabled: !controller.isIdle,
                      onTap: controller.reset,
                    ),
                  ],
                )),
          ),
          const Divider(height: 1, color: AppColors.divider),
          Obx(() => controller.lapLimitReached.value
              ? Container(
                  color: Colors.amber.shade50,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: const Row(
                    children: [
                      Icon(Icons.warning_amber_rounded,
                          color: Colors.amber, size: 15),
                      SizedBox(width: 8),
                      Text('Batas lap tercapai (maks. 999)',
                          style:
                              TextStyle(fontSize: 12.5, color: Colors.amber)),
                    ],
                  ),
                )
              : const SizedBox.shrink()),
          Obx(() {
            if (controller.laps.isEmpty) {
              return Expanded(
                child: Center(
                  child: Text(
                    'Belum ada lap',
                    style: TextStyle(
                        color: AppColors.textSub.withOpacity(0.5),
                        fontSize: 14),
                  ),
                ),
              );
            }
            return Expanded(
              child: Column(
                children: [
                  // Header
                  Container(
                    color: AppColors.surfaceWarm,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Text('Lap',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.8,
                                  color: AppColors.charcoal)),
                        ),
                        Expanded(
                          child: Text('Waktu Lap',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.8,
                                  color: AppColors.charcoal)),
                        ),
                        Expanded(
                          child: Text('Total',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.8,
                                  color: AppColors.charcoal)),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: controller.laps.length,
                      itemBuilder: (context, index) {
                        final lap = controller.laps[index];
                        final isLatest = index == 0;
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 11),
                          decoration: BoxDecoration(
                            color: isLatest
                                ? AppColors.deepBlue.withValues(alpha: 0.04)
                                : null,
                            border: const Border(
                              bottom: BorderSide(
                                  color: AppColors.divider, width: 0.8),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    if (isLatest)
                                      Container(
                                        width: 6,
                                        height: 6,
                                        margin: const EdgeInsets.only(right: 6),
                                        decoration: const BoxDecoration(
                                          color: AppColors.blue,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    Text(
                                      'Lap ${lap.lapNumber}',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: isLatest
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                        color: isLatest
                                            ? AppColors.deepBlue
                                            : AppColors.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  controller.formatDuration(lap.lapTime),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 12.5,
                                      color: AppColors.textPrimary),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  controller.formatDuration(lap.totalTime),
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      fontSize: 12.5, color: AppColors.textSub),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final StopwatchState state;
  const _StatusPill({required this.state});

  @override
  Widget build(BuildContext context) {
    final label = switch (state) {
      StopwatchState.idle => 'Siap',
      StopwatchState.running => 'Berjalan',
      StopwatchState.paused => 'Dijeda',
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Text(label,
          style: const TextStyle(
              color: Colors.white70, fontSize: 12, letterSpacing: 0.5)),
    );
  }
}

class _CtrlBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final List<Color> colors;
  final bool enabled;
  final VoidCallback onTap;

  const _CtrlBtn({
    required this.icon,
    required this.label,
    required this.colors,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedOpacity(
        opacity: enabled ? 1.0 : 0.3,
        duration: const Duration(milliseconds: 200),
        child: Column(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.navy,
                borderRadius: BorderRadius.circular(14),
                boxShadow: enabled
                    ? [
                        BoxShadow(
                          color: colors.last.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ]
                    : [],
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(height: 5),
            Text(label,
                style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.charcoal,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
