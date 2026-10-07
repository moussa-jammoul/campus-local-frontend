// ignore_for_file: unused_element

import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/lastSynced/form.dart';
import 'package:shared_preferences/shared_preferences.dart';


///this provider is used for fetching cloud data (note that it use the biggest updated_at media
///  , it is not relying to the precise time where we synced to
///the cloud) , already explained inside core/database/cloud/media domain
///


String get key =>


class LastSyncedData extends Notifier<LastSyncedForm?>{
  @override
  LastSyncedForm? build() {
     LastSyncedForm? data ;
     Future.microtask(()async{
      data = await _readLastSynced();
     });
     return data;
  }

  void updateLastSynced(LastSyncedForm data){
    
    state = data;
    unawaited(_writeLastSynced(data));

  }
  

  ///for a simple object as this , no need to set up an entire hive object
  ///and generated code file , simple to json , from json is more than enough with
  ///a shared preference
  Future<void> _writeLastSynced(LastSyncedForm data) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(data.toJson()));
  }

  Future<LastSyncedForm?> _readLastSynced() async{
    final prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey(key)){
      final json = prefs.getString(key);
      if(json != null){
      return LastSyncedForm.fromJson(jsonDecode(json));
      } 
      return null;

    }
    return null;
  }

}

final lastsyncedDataProvider =  NotifierProvider<LastSyncedData,LastSyncedForm?>((){
  return LastSyncedData();
});