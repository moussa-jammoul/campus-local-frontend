import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/cloud/domain/media_cloud_domain.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/media_provider.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/lastSynced/last_synced_data.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/media_services_domain.dart';

class MediaServices extends Notifier<void> implements MediaServicesDomain {

  @override
  void build() {
    
  }

  @override
  Future<void> fetchCloudData(String? courseUuid) async {
    if(FirebaseAuth.instance.currentUser != null){
    if(ref.read(lastsyncedDataProvider) == null){
      final data  = await ref.read(mediaCloudProvider.notifier).fetchAllMedia();
      if(data != null){
        await ref.read(mediaProvider.notifier).addListOfMedia(data);
        
        ///if course uuid != null , mean we call this function from the refresh button
        ///if == null , mean it is called at the start up of the app , when user click refresh we should
        ///load data , if from the start up we don't need
        
        if(courseUuid != null){
          ref.read(mediaProvider.notifier).resetMediaState();
        await ref.read(mediaProvider.notifier).loadPaginatedMediaForACourse(
          FirebaseAuth.instance.currentUser!.uid, 
          courseUuid, 
          70
          );
        }

      }
    } else{
      ///if there is data that exist locally

    }
    } else{


      
    }

  }


}