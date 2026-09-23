import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:flutterfrontenduniprojectmanager/features/waitingToverifyEmailPage/data/verify_email_api_firebase.dart';
import 'package:flutterfrontenduniprojectmanager/features/waitingToverifyEmailPage/presentation/errors/providers/reload_user_error.dart';
import 'package:flutterfrontenduniprojectmanager/features/waitingToverifyEmailPage/presentation/errors/providers/resend_email_verification_error.dart';
import 'package:flutterfrontenduniprojectmanager/features/waitingToverifyEmailPage/presentation/providers/timer_provider_sending_email_verification.dart';
import 'package:flutterfrontenduniprojectmanager/features/waitingToverifyEmailPage/service/verify_email_service_domain.dart';
import 'package:logger/logger.dart';

class VerifyEmailService extends Notifier<void> implements VerifyEmailServiceDomain {
  late Logger logger;
  @override
  void build() {
    logger = ref.read(loggerProvider); 
  }

  @override
  Future<void> reloadUser() async {
    logger.i("reloading user data to check if email is verfied");
    final user = await ref.read(verfiyEmailApiProvider.notifier).reloadUser();
    if(user == null){
    ///no need to handle if the user is null , the router is doing its job by routing
    ///to the log in page again
    ref.read(reloadUserErrorProvider.notifier).showUserError();
    return;
    }
    
    if(!user.emailVerified){
      ref.read(reloadUserErrorProvider.notifier).showEmailNotVerified();
      return;
    }
    ref.read(reloadUserErrorProvider.notifier).removeError();
    
    
  }

  @override
  Future<void> resendEmail() async{
    logger.i("resending email to the user...");
    if(ref.read(timerProviderSendingEmailVer.notifier).waiting()){
      return;
    }
    
    try{
    ref.read(verfiyEmailApiProvider.notifier).resendEmail();
    ref.read(resendEmailVerificationErrorProvider.notifier).removeError();
    ref.read(timerProviderSendingEmailVer.notifier).startTimerAndCancelIt();
    } on FirebaseAuthException catch(e){
    if (e.code == 'too-many-requests') {
      logger.e("to many request happened");
      ref.read(resendEmailVerificationErrorProvider.notifier).showRateLimitError();
    } 
    else{
      ref.read(resendEmailVerificationErrorProvider.notifier).showNetworkError();
    }
    }

    
  }

}
final verifyEmailServiceProvider = NotifierProvider<VerifyEmailService,void>((){
  return VerifyEmailService();
});