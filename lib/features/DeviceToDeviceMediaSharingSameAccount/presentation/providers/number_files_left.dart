// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilesLeftNotifier extends Notifier<int?> {

  int? maxNBfiles;


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

  void reset() {state = null; maxNBfiles = null;}
}

final filesLeftProvider = NotifierProvider<FilesLeftNotifier, int?>(FilesLeftNotifier.new);
