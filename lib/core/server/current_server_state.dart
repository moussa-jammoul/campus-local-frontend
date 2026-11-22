import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:logger/logger.dart';
// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
enum ServerStates{
  terminated, //server stopped
  stopping,
  starting, //while starting (e.g loading identity , generating qr code , ...)
  waitingToScanQrCode,//after the starting phase , before any request
  idle,//idle time between requests
  processing // while processing a request
}

class CurrentServerState extends Notifier<ServerStates> {
  late Logger logger;
  @override
  ServerStates build() {
    logger = ref.read(loggerProvider);
    return ServerStates.terminated;
  }

  ServerStates geCurrentState() => state;

  void changeCurrentState(ServerStates newState){
    logger.i("State of the server changes , current state : $state , new state : $newState");
    state = newState;
  }

}


final currentServerStateProvider = NotifierProvider<CurrentServerState,ServerStates>((){
  return CurrentServerState();
});