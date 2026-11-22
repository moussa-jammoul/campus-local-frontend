// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussajammoul/campuslocal)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class EmailAnimation extends ConsumerWidget {
  const EmailAnimation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RepaintBoundary(
      child: SizedBox(
        width: 200,
        height: 200,
        child: LottieBuilder.asset(
          'assets/animations/lottiesFilesAnimations/Email.json',
          repeat: true,
        ),

      ),
    );
  }


}