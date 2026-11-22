import 'dart:async';
// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApprovableSource extends Notifier<void> {

  Completer<bool>? _completer;

  @override
  void build() {
   
  }
  

  Future<bool> waitApprovment() async{
      _completer ??= Completer<bool>();
     return await _completer!.future;
  }

  void approveSource() {
  _completer ??= Completer<bool>();
  if (!_completer!.isCompleted) _completer!.complete(true);
}

void declineSource() {
  _completer ??= Completer<bool>();
  if (!_completer!.isCompleted) _completer!.complete(false);
}

  void reset() {
  if (_completer != null && !_completer!.isCompleted) {
    _completer!.complete(false); 
  }
  _completer = null;
}

}

final approvableSourceProvider = NotifierProvider<ApprovableSource,void>(ApprovableSource.new);