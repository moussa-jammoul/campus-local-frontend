
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilesLeftNotifier extends Notifier<int?> {

  late final int? maxNBfiles;


  @override
  int? build() => null; 
  
  void setTotal(int n){ state = n;maxNBfiles = n;}
  
  int? getMax() => maxNBfiles;
  
  int? decrement() {
    final current = state;
    if (current == null) return null;
    final next = current - 1;
    state = next;
    return next;
  }

  void reset() => state = null;
}

final filesLeftProvider = NotifierProvider<FilesLeftNotifier, int?>(FilesLeftNotifier.new);
