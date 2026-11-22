import 'package:flutter_riverpod/flutter_riverpod.dart';
// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.

//hold a json , we use it to generate the qr code
class QrcodeData extends Notifier<String?> {
  @override
  String? build() {
    return null;
  }

  void addData(String json){
    state = json;
  }

  void clear(){
    state = null;
  }

}

final qrCodeDataProvider = NotifierProvider<QrcodeData,String?>((){
  return QrcodeData();
});