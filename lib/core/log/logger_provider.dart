import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/web.dart';


//logger of the application , use it for debug , testing , and more
final loggerProvider = Provider<Logger>((ref){
  return Logger();
});