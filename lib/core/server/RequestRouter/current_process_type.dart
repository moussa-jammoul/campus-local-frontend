import 'dart:async';
// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ProcessType{
  d2dSameAccount,
  d2dDifferentAccount,
}

//this provider inform services the type of the current process the server is handling , 
//so they can decide what to handle next (ui , services...) , it can be set by the router or the service itself
class CurrentProcessType extends Notifier<void> {
  Completer<ProcessType>? _completer;
  @override
  void build() {
    
  }

  void reset() {
  _completer = null;
  }

  Future<ProcessType> waitForCurrentProcessType() async {
  _completer ??= Completer<ProcessType>();
  try {
    return await _completer!.future;
  } finally {
    _completer = null;
  }
}

  void setCurrentProcessType(ProcessType type){
    _completer ??= Completer();
    if (!_completer!.isCompleted) _completer!.complete(type);
  }

}

final currentServerProcessTypeProvider = NotifierProvider(CurrentProcessType.new);