import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/video_cubit.dart';
import 'package:shorts/core/service_locator/service_locator.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'Features/videos_feature/domain/videos_use_cases/get_videos_use_case/get_videos_use_case.dart';
import 'Features/videos_feature/domain/videos_use_cases/upload_video_use_case/upload_video_use_case.dart';
import 'core/utils/widgets/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<VideoCubit>()..getVideos(),
        ),
      ],
      child: MaterialApp(
        title: 'TikTok Clone',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => context.read<VideoCubit>().uploadVideo(),
              child: const Text('Select and Upload Video'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const VideoPage()),
                );
              },
              child: const Text('View Videos'),
            ),
          ],
        ),
      ),
    );
  }
}

// VideoPage displays a list of videos in a vertical scrolling manner
class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TikTok Videos')),
      body: BlocProvider(
        create: (context) => VideoCubit(
          getVideosUseCase: getIt.get<GetVideosUseCase>(),
          uploadVideoUseCase: getIt.get<UploadVideoUseCase>(),
        )..getVideos(),
        child: BlocBuilder<VideoCubit, VideoState>(
          builder: (context, state) {
            if (state is GetVideoLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetVideoSuccess) {
              // Display videos in a vertical scroll view similar to TikTok
              return PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: state.videos.length,
                itemBuilder: (context, index) {
                  final video = state.videos[index];
                  return VideoListItem(videoUrl: video.videoUrl);
                },
              );
            } else if (state is VideoError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('No data available'));
          },
        ),
      ),
    );
  }
}

// VideoListItem displays each video in a TikTok-like style with play, like, and comment options
class VideoListItem extends StatefulWidget {
  final String videoUrl;

  const VideoListItem({super.key, required this.videoUrl});

  @override
  _VideoListItemState createState() => _VideoListItemState();
}

class _VideoListItemState extends State<VideoListItem> {
  VideoPlayerController? _controller;
  Uint8List? _thumbnailData;
  bool isLiked = false; // State to manage like functionality

  @override
  void initState() {
    super.initState();
    _loadThumbnail();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
      })
      ..setLooping(true)
      ..play(); // Automatically play videos on load
  }

  // Generate video thumbnail
  Future<void> _loadThumbnail() async {
    final thumbnailData = await VideoThumbnail.thumbnailData(
      video: widget.videoUrl,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 128,
      quality: 75,
    );

    setState(() {
      _thumbnailData = thumbnailData;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Toggle play/pause on tap
        if (_controller!.value.isPlaying) {
          _controller!.pause();
        } else {
          _controller!.play();
        }
        setState(() {});
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Display video player or loading thumbnail
          if (_controller?.value.isInitialized ?? false)
            VideoPlayer(_controller!)
          else if (_thumbnailData != null)
            Image.memory(
              _thumbnailData!,
              fit: BoxFit.cover,
            )
          else
            const Center(child: CircularProgressIndicator()),

          // Overlay with likes and comments similar to TikTok
          Positioned(
            right: 20,
            bottom: 100,
            child: Column(
              children: [
                // Like button
                IconButton(
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                  },
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 10),
                // Placeholder for comment button
                IconButton(
                  onPressed: () {
                    // Add comment functionality here
                  },
                  icon: const Icon(
                    Icons.comment,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
                const SizedBox(height: 10),
                // Placeholder for share button
                IconButton(
                  onPressed: () {
                    // Add share functionality here
                  },
                  icon: const Icon(
                    Icons.share,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
