import 'dart:async';
// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
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