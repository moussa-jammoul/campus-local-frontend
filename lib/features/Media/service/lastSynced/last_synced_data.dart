// ignore_for_file: unused_element

import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/lastSynced/form.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';


///this provider is used for fetching cloud data (note that it use the biggest updated_at media
///  , it is not relying to the precise time where we synced to
///the cloud) , already explained inside core/database/cloud/media domain
///


String get key => 'sync_data_${FirebaseAuth.instance.currentUser?.uid}';


class LastSyncedData extends Notifier<void>{

  late Logger logger;

  @override
  void build() {
    logger = ref.read(loggerProvider);
    
  }

  Future<void> updateLastSynced(LastSyncedForm data) async{
    logger.i("Updating last synced data... ${data.lastUpdateSynced} ${data.lastUuidSynced}");

    
    try{
    await _writeLastSynced(data);
    } catch(e){
      logger.e(e);
    }

  }
  

  ///for a simple object as this , no need to set up an entire hive object
  ///and generated code file , simple to json , from json is more than enough with
  ///a shared preference
  Future<void> _writeLastSynced(LastSyncedForm data) async{
    try{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(data.toJson()));
    } catch(e){
      rethrow;
    }
  }

  Future<LastSyncedForm?> readLastSynced() async{
    final prefs = await SharedPreferences.getInstance();
    logger.i("key of the 'last synced data' : $key ");
    if(prefs.containsKey(key)){
      logger.i("last synced info exist locally !");
      final json = prefs.getString(key);
      if(json != null){
        logger.i("last synced info : $json");
      return LastSyncedForm.fromJson(jsonDecode(json));
      } 
      return null;

    }
    return null;
  }

}

final lastsyncedDataProvider =  NotifierProvider<LastSyncedData,void>((){
  return LastSyncedData();
});