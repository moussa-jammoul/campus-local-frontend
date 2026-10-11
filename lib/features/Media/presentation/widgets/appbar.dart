// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/courses/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/media_provider.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/presentation/widgets/add_image_sheet.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/ImageService/media_image_service.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/media_services.dart';
import 'package:go_router/go_router.dart';

class ImageAppBar extends ConsumerWidget {
  const ImageAppBar({super.key, required this.courseDetails});

  final Course courseDetails;


  Future<void> addImage(BuildContext context , WidgetRef ref) async {
  final data =  await showModalBottomSheet<({String? sourcePath, String? description, String? imageName , String? type})?>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.3),
    builder: (context) {
      return const AddImageBottomSheetContent();
    },
  );
  if(data != null && data.sourcePath != null && data.imageName != null && FirebaseAuth.instance.currentUser != null
  && data.type != null){
  await ref.read(mediaImageServiceProvider.notifier).addMedia(
    sourcePath: data.sourcePath!, 
    userUid: FirebaseAuth.instance.currentUser!.uid, 
    courseUuid: courseDetails.uuid!, 
    filename: data.imageName!, 
    fileDescription: data.description, 
    fileExtension: data.type!, 
    isFavorite: false
    );
  } 

}


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SliverAppBar(
      pinned: true,
      toolbarHeight: 70,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading:  BackButton(
        onPressed: (){
          context.pop();
          
        },
      ),
      title: Text(
        courseDetails.courseName,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: scheme.onSurface,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.add_rounded, size: 20),
          onPressed: () {
            unawaited(addImage(context , ref));
          },
        ),
        const SizedBox(width: 12),
        IconButton(
          onPressed: (){
            unawaited(
            ref.read(mediaServiceProvider.notifier).fetchCloudData(courseDetails.uuid, ['jpg' , 'png'])
            );
          }, 
          icon: Icon(
            Icons.refresh,

          )
          ),
          const SizedBox(width: 12,)
      ],
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            decoration: BoxDecoration(
              color: scheme.surface.withValues(alpha: 0.25),
              border: Border(
                bottom: BorderSide(
                  color: scheme.onSurface.withValues(alpha: 0.08),
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}