import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:logger/logger.dart';
// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
class NumberFilesRecieved extends Notifier<int?> {
   int? maxNBfiles;
   late Logger logger;

   @override
   int? build(){
    logger = ref.read(loggerProvider);
    return null;
    } 
  
   void setTotal(int n){ state = 0;maxNBfiles = n;}
  
   int? getMax() => maxNBfiles;
  
   int? increment() {
    final current = state;
    if (current == null) return null;
    final next = current + 1;
    state = next;
    logger.i("current file received : $state");
    return next;
  }

  void reset() {state = null; maxNBfiles = null;}


}

final filesRecievedProvider = NotifierProvider<NumberFilesRecieved, int?>(NumberFilesRecieved.new);