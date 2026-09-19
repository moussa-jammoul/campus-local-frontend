import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefreshListenAbleRouterNotifier extends ChangeNotifier {

  RefreshListenAbleRouterNotifier(Ref ref){
    _listenToAuthState(ref);
  }

  void _listenToAuthState(Ref ref){
    //TODO listen to auth state
  }


  

}
