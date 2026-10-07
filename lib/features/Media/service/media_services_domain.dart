import 'dart:typed_data';

import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';

abstract class MediaServicesDomain {
  ///in app opening , we run this funciton , it will decide which form
  ///of fetching data will use (e.g no data exist locally at all , or getting new updates)
  ///also use it for the refresh button inside the media ui
  Future<void> fetchCloudData(String? courseUuid);
  
}