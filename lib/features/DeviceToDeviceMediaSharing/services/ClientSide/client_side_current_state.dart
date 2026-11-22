import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:logger/logger.dart';
// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
enum ClientSideD2DStateDifferentAccount{ //simple in purpose , current model doesn't require more
  aborted,
  running,
}


class ClientSideCurrentStateD2DDifferentAccount extends Notifier<ClientSideD2DStateDifferentAccount>{

  late Logger logger;

  @override
  ClientSideD2DStateDifferentAccount build() {
    logger = ref.read(loggerProvider);
    return ClientSideD2DStateDifferentAccount.aborted;
  }

  void changeCurrentState(ClientSideD2DStateDifferentAccount newState){
    logger.i("D2d client side : current state : ${newState.name}");
    state = newState;
  }

}

final clientSideCurrentStateDifferentAccountProvider = NotifierProvider<ClientSideCurrentStateD2DDifferentAccount,ClientSideD2DStateDifferentAccount>(ClientSideCurrentStateD2DDifferentAccount.new);