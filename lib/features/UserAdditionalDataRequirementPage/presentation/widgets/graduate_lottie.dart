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