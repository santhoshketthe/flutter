import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerPage({super.key, required this.videoUrl});

  @override
  State<StatefulWidget> createState() => VideoPlayerScreen();
}

class VideoPlayerScreen extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  void showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: const Text("Failed to load video."),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    // if (widget.videoUrl.startsWith('http')) {
    //   _controller = VideoPlayerController.network(widget.videoUrl);
    // } else {
      _controller = VideoPlayerController.asset(widget.videoUrl);
  //  }
    _initializeVideoPlayerFuture = _controller.initialize().catchError((error) {
      print("Error initializing video: $error"); // Log the error for debugging
      showErrorDialog(); // Show an error message or fallback UI
    });

    // _initializeVideoPlayerFuture = _controller.initialize().then((_) {
    //   setState(() {
    //     _controller.play();
    //   });
    // });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("VideoPlayer")),
      body: Center(
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // Use the video's actual aspect ratio
              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              );
            } else {
              // Show a loading spinner while the video is initializing
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying ? _controller.pause() : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow_sharp,
        ),
      ),
    );
  }
}
