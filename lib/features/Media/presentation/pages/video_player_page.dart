import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/media_provider.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/presentation/widgets/media_detail_sheet.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/presentation/widgets/video_player_box.dart';

const double ktoolbarheightAppbar = 40;

class VideoPlayerPage extends ConsumerWidget {
  const VideoPlayerPage({
    super.key,
    required this.videoPath,
    required this.videoDetail,
  });

  final MediaForm videoDetail;
  final String? videoPath;  

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
              ///reading the last state of a media , because the passed videoDetail could hold
              ///ghost data if the user updated the media and didn't exit the video , so he
              ///will never see that the update really did anything , instead we rely here on always
              ///reading the new media
              final live = ref
                      .read(mediaProvider)
                      ?.firstWhereOrNull((m) => m.uuid == videoDetail.uuid) ??
                  videoDetail;
              MediaDetailSheet.show(context: context, media: live , thumbnail: videoPath);
            },
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: videoPath == null
          ? Center(child: _brokenVideo(scheme))
          : RepaintBoundary(
              
              child: SizedBox.expand(
               
                child: ColoredBox(
                  color: scheme.surfaceContainerHighest,
                  child: Center(    
                    child: VideoPlayerBox(path:videoPath!)
                  ),
                ),
              ),
            ),
    );
  }

  Widget _brokenVideo(ColorScheme scheme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.videocam_off_outlined, size: 64, color: scheme.outline),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            'Video could not be loaded or it does not exist in the current device , please make sure to run "Fetch Unavailable Media" inside the setting to get any missing media',
            style: TextStyle(color: scheme.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

