// ignore_for_file: unused_field

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';



///the state is the number of seconds left , null mean timer done ,
///the max threashhold between two send verification is around 50 second , if in 
///the future u need more like 1min + , u need a function  to cast the number of seconds to readable time 
///instead of raw seconds (if u need understandable time)
///this feature is only ux/ui , firebase auth handle real rate limiter (5 request per hour)
class TimerProviderSendingEmailVerification extends Notifier<int?> {
  
  static const int timeToWait = 50;
  Timer? _timer;
  @override
  int? build() {
    return null;
  }
  
  ///two in one , start the timer and handle cancelation , one function call
  ///more than enough
  void startTimerAndCancelIt(){
    _timer?.cancel();// guard against double proccesing 
    state = timeToWait;
    _timer = Timer.periodic(const Duration(seconds: 1),(timer){
      if(state !=null){
      if(state! > 0  ){
      state = state! - 1;
      }
      else{
        timer.cancel();
        state = null;
      }
      }
    } );

  }

  bool waiting(){
    return state !=null;
  }
  

}

final timerProviderSendingEmailVer = NotifierProvider<TimerProviderSendingEmailVerification,int?>((){
  return TimerProviderSendingEmailVerification();
});