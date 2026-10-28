import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerHelper extends Notifier<int?> {
  static const defaultSeconds = 120;
  Timer? _timer;

  @override
  int? build() {
    ref.onDispose(() => _timer?.cancel());
    return null;
  }

  
  void startTimer(void Function() onExpired, {int seconds = defaultSeconds}) {
    _timer?.cancel();
    state = seconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      final left = (state ?? 0) - 1;
      if (left <= 0) {
        t.cancel();
        _timer = null;
        state = null;
        onExpired();
      } else {
        state = left;
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
    state = null;
  }
}

final timerHelperProvider =
    NotifierProvider<TimerHelper, int?>(TimerHelper.new);