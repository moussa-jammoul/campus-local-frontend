
import 'dart:typed_data';


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/media_provider.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/presentation/widgets/media_detail_sheet.dart';
import 'package:go_router/go_router.dart';
import 'package:collection/collection.dart';


const double ktoolbarheightAppbar = 40;

class DetailedImage extends ConsumerWidget {
  const DetailedImage({super.key, required this.binary, required this.imageDetail });
  final MediaForm imageDetail;
  final Uint8List? binary;  
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: ktoolbarheightAppbar,
  backgroundColor: Colors.transparent,
  elevation: 0,
  scrolledUnderElevation: 0,       
  automaticallyImplyLeading: true,
  actions: [
    IconButton(
      onPressed: () {
        ///reading the last state of a media , because the passed imageDetail could hold
        ///ghost data if the user updated the media and didn't exit the picture , so he 
        ///will never see that the update really did anything , instead we rely here on always
        ///reading the new media 
        final live = ref
          .read(mediaProvider)
          ?.firstWhereOrNull((m) => m.uuid == imageDetail.uuid) ??
      imageDetail;                        
      MediaDetailSheet.show(context, live);
      },
      icon: const Icon(Icons.menu),
    ),
  ],
),
      body: 
      
      Center(
        
        child:
        
         binary == null
            ? _brokenImage(scheme)
            : InteractiveViewer(
                minScale: 1,
                maxScale: 5,
                child: Image.memory(
                  binary!,
                  fit: BoxFit.contain,     
                  width: double.infinity,
                  height: double.infinity,

                  
                  errorBuilder: (context, error, stackTrace) => _brokenImage(scheme),
                ),
              ),
      ),
      
    );
  }

  Widget _brokenImage(ColorScheme scheme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.broken_image_outlined, size: 64, color: scheme.outline),
        const SizedBox(height: 12),
        Padding(
          padding:EdgeInsetsGeometry.all(10),
          child:  
        Text(
          
          'Image could not be loaded or it does not exist in the current device , please make sure to run "Fetch Unavailable Media" inside the setting to get any missing media',
          style: TextStyle(color: scheme.onSurfaceVariant),
           textAlign: TextAlign.center,
        ), 
        )   
      ],
    );
  }
}