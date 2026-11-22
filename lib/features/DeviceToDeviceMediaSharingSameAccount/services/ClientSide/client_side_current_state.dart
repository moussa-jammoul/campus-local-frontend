import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:logger/logger.dart';
// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
enum ClientSideD2DState{ //simple in purpose , current model doesn't require more
  aborted,
  running,
}


class ClientSideCurrentState extends Notifier<ClientSideD2DState>{

  late Logger logger;

  @override
  ClientSideD2DState build() {
    logger = ref.read(loggerProvider);
    return ClientSideD2DState.aborted;
  }

  void changeCurrentState(ClientSideD2DState newState){
    logger.i("D2d client side : current state : ${newState.name}");
    state = newState;
  }

}

final clientSideCurrentStateProvider = NotifierProvider<ClientSideCurrentState,ClientSideD2DState>(ClientSideCurrentState.new);