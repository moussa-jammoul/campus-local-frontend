import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GraduateLottie extends StatelessWidget {
  const GraduateLottie({super.key});


 @override
Widget build(BuildContext context) {
 
  return SizedBox(
    width: 130,  
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