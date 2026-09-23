
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