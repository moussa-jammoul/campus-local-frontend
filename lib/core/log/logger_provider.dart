import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/web.dart';
// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.

//logger of the application , use it for debug , testing , and more
final loggerProvider = Provider<Logger>((ref){
  return Logger();
});