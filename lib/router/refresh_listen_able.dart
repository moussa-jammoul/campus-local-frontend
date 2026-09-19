import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:logger/logger.dart';



//A refreshable just to notify the router something change , it may be auth states , or any other listenable
class RefreshListenAbleRouterNotifier extends ChangeNotifier {
  
  late Logger logger;
  
  RefreshListenAbleRouterNotifier(Ref ref){
    logger = ref.read(loggerProvider);
    _listenToUserState(ref);
  }
  
  //this function detect whenever a user state change , if it was auth states , email verifaction changes...
  //note that email verification should have a manual button to call firebase auth reload , "so email verification actually change and we get notifie"
  void _listenToUserState(Ref ref){

    FirebaseAuth.instance.userChanges().listen((user){
      logger.i('userChanges fired : email : ${user?.email} , is verified : ${user?.emailVerified}' ,time: DateTime.now());
      notifyListeners();
    });
  }
}
