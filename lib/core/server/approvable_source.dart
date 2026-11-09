import 'dart:async';

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