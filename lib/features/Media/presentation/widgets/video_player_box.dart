import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_filex/open_filex.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerBox extends ConsumerStatefulWidget{
  const VideoPlayerBox({super.key , required this.path});

  final String path;

  @override
  ConsumerState<VideoPlayerBox> createState() {
    return _VideoPlayerBoxState();
  }

}

class _VideoPlayerBoxState extends ConsumerState<VideoPlayerBox>{
  
  late final VideoPlayerController _controller;
  bool _videoNotSupported = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.path));

    _controller.initialize()
    .then((_){
      
      if (mounted){ setState(() {
        _videoNotSupported =false;
      });     
      }
    _controller.play();
    
    })
    .catchError((_){
      if(mounted) {
      setState(() {
        _videoNotSupported = true;
      });
      }
    });

  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  if (!_controller.value.isInitialized) {
    return const Center(child: CircularProgressIndicator());
  }
  else if(_videoNotSupported){
    return videoNotSupportedWidget(context, 
    onOpenExternally: ()async {
      final result = await OpenFilex.open(widget.path);

if (result.type != ResultType.done && context.mounted) {
  final message = switch (result.type) {
    ResultType.noAppToOpen => 'No app found that can open this video',
    ResultType.fileNotFound => 'The video file was not found on this device',
    ResultType.permissionDenied => 'Permission denied while opening the video',
    _ => 'Could not open the video',
  };
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
    },
    );
  }
  return Center(
    child: AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: Stack(
        fit: StackFit.expand,       
        children: [
          VideoPlayer(_controller),
          VideoControls(controller: _controller),
        ],
      ),
    ),
  );
}

///if the video is not supported on the platform , we redner this widget
///asking the user to open the video with another platform
Widget videoNotSupportedWidget(
  BuildContext context, {
  required VoidCallback onOpenExternally,
}) {
  final scheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 360),
      child: Card(
        margin: const EdgeInsets.all(20),
        elevation: 0,
        color: scheme.surfaceContainerHigh.withValues(alpha: 0.9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: scheme.outlineVariant.withValues(alpha: 0.4),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.videocam_off_outlined, size: 48, color: scheme.outline),
              const SizedBox(height: 16),
              Text(
                'Video not supported',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: scheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'This device cannot play this video format inside the app. '
                'You can open it with another app instead.',
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: onOpenExternally,
                  icon: const Icon(Icons.open_in_new_rounded, size: 18),
                  label: const Text('Open with another app'),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

}


class VideoControls extends StatefulWidget {
  const VideoControls({super.key, required this.controller});

  
  final VideoPlayerController controller;

  @override
  State<VideoControls> createState() => _VideoControlsState();
}

class _VideoControlsState extends State<VideoControls> {
  static const _skip = Duration(seconds: 5);
  static const _hideAfter = Duration(seconds: 3);

  bool _visible = true;
  Timer? _hideTimer;
  double? _dragValue;   

  @override
  void initState() {
    super.initState();
    _startHideTimer();
  }

  @override
  void dispose() {
    _hideTimer?.cancel();    
    super.dispose();
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(_hideAfter, () {
      if (mounted && _dragValue == null) setState(() => _visible = false);
    });
  }

  void _show() {
    setState(() => _visible = true);
    _startHideTimer();
  }

  void _hide() {
    _hideTimer?.cancel();
    setState(() => _visible = false);
  }

  Future<void> _skipBy(Duration offset) async {
    final value = widget.controller.value;
    var target = value.position + offset;
    if (target < Duration.zero) target = Duration.zero;
    if (target > value.duration) target = value.duration;
    await widget.controller.seekTo(target);
    _startHideTimer();
  }

  Future<void> _togglePlay() async {
    final c = widget.controller;
    if (c.value.isPlaying) {
      await c.pause();
    } else {
      final ended = c.value.duration > Duration.zero &&
          c.value.position >= c.value.duration;
      if (ended) await c.seekTo(Duration.zero);   
      await c.play();
    }
    _startHideTimer();
  }

  String _format(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    final s = d.inSeconds.remainder(60);
    return h > 0 ? '$h:${two(m)}:${two(s)}' : '${two(m)}:${two(s)}';
  }

  Widget _tapArea({required VoidCallback onDoubleTap}) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,   
        onTap: _hide,
        onDoubleTap: onDoubleTap,
        child: const SizedBox.expand(),
      ),
    );
  }

  Widget _playButton() {
    return ValueListenableBuilder<VideoPlayerValue>(
      valueListenable: widget.controller,
      builder: (context, value, _) {
        final ended = value.duration > Duration.zero &&
            value.position >= value.duration;
        final icon = ended
            ? Icons.replay_rounded
            : value.isPlaying
                ? Icons.pause_rounded
                : Icons.play_arrow_rounded;

        return IconButton(
          iconSize: 56,
          color: Colors.white,
          onPressed: _togglePlay,
          icon: Icon(icon),
        );
      },
    );
  }

  Widget _seekBar() {
    return ValueListenableBuilder<VideoPlayerValue>(
      valueListenable: widget.controller,
      builder: (context, value, _) {
        final maxMs = value.duration.inMilliseconds.toDouble();
        final shownMs = (_dragValue ?? value.position.inMilliseconds.toDouble())
            .clamp(0.0, maxMs > 0 ? maxMs : 1.0)
            .toDouble();

        return Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
          child: Row(
            children: [
              Text(_format(Duration(milliseconds: shownMs.round())),
                  style: const TextStyle(color: Colors.white, fontSize: 12)),
              Expanded(
                child: Slider(
                  min: 0,
                  max: maxMs > 0 ? maxMs : 1.0,
                  value: shownMs,
                  onChangeStart: (v) {
                    _hideTimer?.cancel();           
                    setState(() => _dragValue = v);
                  },
                  onChanged: (v) {
                    setState(() => _dragValue = v); 
                  },
                  onChangeEnd: (v) async {
                    await widget.controller
                        .seekTo(Duration(milliseconds: v.round()));   
                    if (!mounted) return;
                    setState(() => _dragValue = null);  
                    _startHideTimer();
                  },
                ),
              ),
              Text(_format(value.duration),
                  style: const TextStyle(color: Colors.white, fontSize: 12)),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
       
        if (!_visible)
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _show,
          ),

       
        AnimatedOpacity(
          opacity: _visible ? 1 : 0,
          duration: const Duration(milliseconds: 250),
          child: IgnorePointer(
            ignoring: !_visible,
            child: ColoredBox(
              color: Colors.black38,  
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Row(
                          children: [
                            _tapArea(onDoubleTap: () => _skipBy(-_skip)),
                            _tapArea(onDoubleTap: () => _skipBy(_skip)),
                          ],
                        ),
                        _playButton(),    
                      ],
                    ),
                  ),
                  _seekBar(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}