import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:flutterfrontenduniprojectmanager/features/waitingToverifyEmailPage/data/verify_email_api_domain.dart';
import 'package:logger/logger.dart';

class VerifyEmailApiFirebase extends Notifier<void> implements VerifyEmailApiDomain {
  late Logger logger;
  @override
  void build() {
    logger = ref.read(loggerProvider);
  }

  @override
  Future<User?> reloadUser() async {
    logger.i("reloading user data");
    try{
    await FirebaseAuth.instance.currentUser?.reload();
    return FirebaseAuth.instance.currentUser;
    } catch(e){
      logger.e(e);
      return null;
    }
  }

  @override
  Future<void> resendEmail() async {
    try{
      ///firebase handle email rate limiter , arround 5 email per 1 hour
    await FirebaseAuth.instance.currentUser?.sendEmailVerification();
     logger.i("verification email request completed successfully");
    } catch(e){
      logger.e(e);
      rethrow; // needed to handle error in the service side 
    }
    
  }

}

final verfiyEmailApiProvider = NotifierProvider<VerifyEmailApiFirebase,void>((){
  return VerifyEmailApiFirebase();
});