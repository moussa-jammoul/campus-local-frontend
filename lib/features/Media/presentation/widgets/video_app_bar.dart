import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/courses/form.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/presentation/widgets/add_video_sheet.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/VideoService/media_video_service.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/media_services.dart';
import 'package:flutterfrontenduniprojectmanager/router/router.dart';
import 'package:go_router/go_router.dart';



class VideoAppBar extends ConsumerWidget {
  VideoAppBar({super.key, required this.courseDetails});

 

  final Course courseDetails;
  final allowedFormat = ['mp4', 'mov', 'mkv', 'avi'];
  final Completer<void> _isAddingVideo = Completer<void>();

  
  Future<void> showAddingVideo(BuildContext context) async{
    final navigator = Navigator.of(context, rootNavigator: true);
    showDialog<void>(
    context: context,
    barrierDismissible: false,         
    builder: (_) => PopScope(
      canPop: false,                    
      child: const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(strokeWidth: 2.5),
            SizedBox(width: 16),
            Expanded(child: Text('Saving video...')),
          ],
        ),
      ),
    ),
  );  
  await _isAddingVideo.future;
  if(_isAddingVideo.isCompleted){
  navigator.pop();
  }
  }

  Future<void> addVideo(BuildContext context, WidgetRef ref) async {
    final data = await showModalBottomSheet<
        ({String? sourcePath, String? description, String? videoName, String? type})?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      builder: (context) {
        return const AddVideoBottomSheetContent();
      },
    );
    
    if (data != null &&
        data.sourcePath != null &&
        data.videoName != null &&
        FirebaseAuth.instance.currentUser != null &&
        data.type != null) {
         
          if(context.mounted){
            showAddingVideo(context);
          }
      await ref.read(mediaVideopServiceProvider.notifier).addMedia(
            sourcePath: data.sourcePath!,
            userUid: FirebaseAuth.instance.currentUser!.uid,
            courseUuid: courseDetails.uuid!,
            filename: data.videoName!,
            fileDescription: data.description,
            fileExtension: data.type!,
            isFavorite: false,
          );
    _isAddingVideo.complete();
          
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
      leading: BackButton(
        onPressed: () {
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
            unawaited(addVideo(context, ref));
          },
        ),
        const SizedBox(width: 12),
        IconButton(
          onPressed: () {
            unawaited(
              ref
                  .read(mediaServiceProvider.notifier)
                  .fetchCloudData(courseDetails.uuid, allowedFormat),
            );
          },
          icon: const Icon(Icons.refresh),
        ),
        const SizedBox(width: 12),
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