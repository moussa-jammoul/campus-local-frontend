import 'package:flutter_riverpod/flutter_riverpod.dart';





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
