import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharingSameAccount/presentation/widgets/number_of_files_that_doesnt_exist_locally_sheet.dart';
import 'package:flutterfrontenduniprojectmanager/features/homepage/presentation/widgets/card_style.dart';
import 'package:flutterfrontenduniprojectmanager/features/homepage/service/home_page_services.dart';

class FetshAnyMissedMediaButton extends ConsumerWidget {
  const FetshAnyMissedMediaButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CardStyleWidget(
      constraints: const BoxConstraints(
        
        minWidth: 350,
        maxWidth: 450,
        ),
      child: Row(
        spacing: 10,

        children: [
          Icon(
            Icons.file_download,
            color: Theme.of(context).colorScheme.primary,
          ),

          SizedBox(
  width: 170,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Fetch Unavailable Media',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        'Media is stored on the device it was added from, not on a server, Fetching pulls anything missing here directly from your other linked devices.',
        style: TextStyle(
          fontSize: 13,
          color: Colors.grey[600],
        ),
      ),
    ],
  ),
),
        Flexible(child: 
        Material(
  color: Colors.transparent,
  child: InkWell(
    borderRadius: BorderRadius.circular(12),
    onTap: () async {
      try{
        final media = await ref.read(homePageServiceProvider.notifier).fetchMissedMediaLocally();
        if(media == null){ //null cover both if empty or no media exist 
        if(context.mounted){
        ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          "All Media Exist Locally !",   
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
      }


        } else{
        NumberOfFilesThatDoesntExistLocallySheet.showSheet(media: media);
        }
      }catch(e){
        if(context.mounted){
        ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          "Error while fetching media , try again later",   
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
      }
      }
        
      
    },
    child: Ink(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Center(
          child: Icon(
          Icons.download,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        )
      ),
    ),
  ),
),
        )

        ],
      )
      );
  
  }


}