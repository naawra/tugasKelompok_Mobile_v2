import 'dart:async';
import 'package:get/get.dart';

enum StopwatchState { idle, running, paused }

class LapEntry {
  final int lapNumber;
  final Duration lapTime;
  final Duration totalTime;

  LapEntry({
    required this.lapNumber,
    required this.lapTime,
    required this.totalTime,
  });
}

class StopwatchController extends GetxController {
  static const int _maxLaps = 999;

  final state = StopwatchState.idle.obs;
  final elapsed = Duration.zero.obs;
  final laps = <LapEntry>[].obs;
  final lapLimitReached = false.obs;

  final _stopwatch = Stopwatch();
  Timer? _timer;
  Duration _lastLapTime = Duration.zero;

  @override
  void onClose() {
    _timer?.cancel();
    _stopwatch.stop();
    super.onClose();
  }

  bool get isRunning => state.value == StopwatchState.running;
  bool get isPaused => state.value == StopwatchState.paused;
  bool get isIdle => state.value == StopwatchState.idle;

  void start() {
    if (state.value == StopwatchState.running) return;
    _stopwatch.start();
    state.value = StopwatchState.running;
    _timer = Timer.periodic(const Duration(milliseconds: 10), (_) {
      elapsed.value = _stopwatch.elapsed;
    });
  }

  void pause() {
    if (!isRunning) return;
    _stopwatch.stop();
    _timer?.cancel();
    state.value = StopwatchState.paused;
  }

  void reset() {
    _timer?.cancel();
    _stopwatch.stop();
    _stopwatch.reset();
    elapsed.value = Duration.zero;
    laps.clear();
    _lastLapTime = Duration.zero;
    lapLimitReached.value = false;
    state.value = StopwatchState.idle;
  }

  void lap() {
    if (!isRunning) return;
    if (laps.length >= _maxLaps) {
      lapLimitReached.value = true;
      return;
    }

    final currentTotal = _stopwatch.elapsed;
    final lapTime = currentTotal - _lastLapTime;
    _lastLapTime = currentTotal;

    laps.insert(
      0,
      LapEntry(
        lapNumber: laps.length + 1,
        lapTime: lapTime,
        totalTime: currentTotal,
      ),
    );
  }

  String formatDuration(Duration d) {
    // Cap at 99:59:59.99
    final capped = d.inHours > 99
        ? const Duration(hours: 99, minutes: 59, seconds: 59, milliseconds: 990)
        : d;

    final h = capped.inHours.toString().padLeft(2, '0');
    final m = (capped.inMinutes % 60).toString().padLeft(2, '0');
    final s = (capped.inSeconds % 60).toString().padLeft(2, '0');
    final ms = ((capped.inMilliseconds % 1000) ~/ 10).toString().padLeft(2, '0');
    return '$h:$m:$s.$ms';
  }
}
