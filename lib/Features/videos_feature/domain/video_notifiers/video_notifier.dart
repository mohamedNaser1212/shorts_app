import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoProvider {
  final ValueNotifier<VideoPlayerController?> controllerNotifier =
      ValueNotifier(null);
  final ValueNotifier<Uint8List?> thumbnailNotifier = ValueNotifier(null);
  final ValueNotifier<bool> isLikedNotifier = ValueNotifier(false);
  final ValueNotifier<bool> showPlayPauseIconNotifier = ValueNotifier(false);
  final ValueNotifier<Duration> positionNotifier = ValueNotifier(Duration.zero);
  final ValueNotifier<Duration> durationNotifier = ValueNotifier(Duration.zero);
  final ValueNotifier<bool> isPausedNotifier = ValueNotifier(false);

  VideoProvider(String videoUrl) {
    _initializeController(videoUrl);
  }

  Future<void> _initializeController(String videoUrl) async {
    final VideoPlayerController controller =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl))..setLooping(true);

    await controller.initialize();
    controller.play();
    controllerNotifier.value = controller;

    durationNotifier.value = controller.value.duration;
    controller.addListener(() {
      positionNotifier.value = controller.value.position;
      isPausedNotifier.value = !controller.value.isPlaying;
    });

    await _loadThumbnail(videoUrl);
  }

  Future<void> _loadThumbnail(String videoUrl) async {
    final thumbnailData = await VideoThumbnail.thumbnailData(
      video: videoUrl,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 128,
      quality: 75,
    );

    thumbnailNotifier.value = thumbnailData;
  }

  void togglePlayPause() {
    final VideoPlayerController? controller = controllerNotifier.value;
    if (controller != null) {
      if (controller.value.isPlaying) {
        controller.pause();
      } else {
        controller.play();
      }
      showPlayPauseIconNotifier.value = true;
      isPausedNotifier.value = !controller.value.isPlaying;

      Future.delayed(const Duration(seconds: 1), () {
        showPlayPauseIconNotifier.value = false;
      });
    }
  }

  void toggleLike() {
    isLikedNotifier.value = !isLikedNotifier.value;
  }

  void seekTo(Duration position) {
    final VideoPlayerController? controller = controllerNotifier.value;
    if (controller != null) {
      controller.seekTo(position);
    }
  }

  void dispose() {
    controllerNotifier.value?.dispose();
    controllerNotifier.dispose();
    thumbnailNotifier.dispose();
    isLikedNotifier.dispose();
    showPlayPauseIconNotifier.dispose();
    positionNotifier.dispose();
    durationNotifier.dispose();
    isPausedNotifier.dispose();
  }
}
