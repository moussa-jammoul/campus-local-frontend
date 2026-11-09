import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:logger/logger.dart';

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