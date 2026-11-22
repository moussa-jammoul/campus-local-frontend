// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussajammoul/campuslocal)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class GraduateLottieCompleteProfile extends StatelessWidget {
  const GraduateLottieCompleteProfile({super.key});


 @override
Widget build(BuildContext context) {
 
  return SizedBox(
    width:130,  
    height: 130, 
    child: RepaintBoundary(
      child: LottieBuilder.asset(
        'assets/animations/lottiesFilesAnimations/GraduationHat.json',
        fit: BoxFit.fill,
        repeat: true,
      ),
    ),
  );
}

}