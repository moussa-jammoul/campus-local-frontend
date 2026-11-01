import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ServerStates{
  terminated, //server stopped
  stopping,
  starting, //while starting (e.g loading identity , generating qr code , ...)
  waitingToScanQrCode,//after the starting phase , before any request
  idle,//idle time between requests
  processing // while processing a request
}

class CurrentServerState extends Notifier<ServerStates> {
  @override
  ServerStates build() {
    return ServerStates.terminated;
  }

  ServerStates geCurrentState() => state;

  void changeCurrentState(ServerStates newState){
    state = newState;
  }

}


final currentServerStateProvider = NotifierProvider<CurrentServerState,ServerStates>((){
  return CurrentServerState();
});