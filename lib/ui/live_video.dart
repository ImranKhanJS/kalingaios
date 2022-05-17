import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kalingatv4/live_tv/default_player/default_player.dart';
import 'package:kalingatv4/live_tv/landscape_player/landscape_player.dart';
// import 'package:odisha/default_player/default_player.dart';
// import 'package:odisha/landscape_player/landscape_player.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({Key key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  Color kalinga_color_code = const Color(0xff9b2219);
  @override
  // void initState() {
  //   _controller = VideoPlayerController.network(
  //       'https://live.mycast.in/kalingatv/d0dbe915091d400bd8ee7f27f0791303.sdp/playlist.m3u8',
  //     );
  //   // Initialize the controller and store the Future for later use.
  //   _initializeVideoPlayerFuture = _controller.initialize();
  //
  //   // Use the controller to loop the video.
  //   _controller.setLooping(true);
  //
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   // Ensure disposing of the VideoPlayerController to free up resources.
  //   _controller.dispose();
  //
  //   super.dispose();
  // }
  final List<Map<String, dynamic>> samples = [
    {'name': 'Default player', 'widget': DefaultPlayer()},
  ];

  int selectedIndex = 0;
  changeSample(int index) {
    if (samples[index]['widget'] is LandscapePlayer) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LandscapePlayer(),
      ));
    } else {
      setState(() {
        selectedIndex = index;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
          leading: IconButton(
            // icon: Icon(Icons.arrow_back, color: Colors.white),
            // onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          backgroundColor: Colors.black,
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: samples[selectedIndex]['widget'],
          ),
        ],
      ),
      );


    // return Scaffold(
    //   backgroundColor:Colors.black ,
    //   // appBar: AppBar(
    //   //   title: Text('Kalinga TV Live'),
    //   //   backgroundColor: kalinga_color_code,
    //   // ),
    //   // Use a FutureBuilder to display a loading spinner while waiting for the
    //   // VideoPlayerController to finish initializing.
    //   body: Center(
    //     child:FutureBuilder(
    //     future: _initializeVideoPlayerFuture,
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.done) {
    //         // If the VideoPlayerController has finished initialization, use
    //         // the data it provides to limit the aspect ratio of the video.
    //         return AspectRatio(
    //           aspectRatio: _controller.value.aspectRatio,
    //           // Use the VideoPlayer widget to display the video.
    //           child: VideoPlayer(_controller),
    //         );
    //       } else {
    //         // If the VideoPlayerController is still initializing, show a
    //         // loading spinner.
    //         return Center(child: CircularProgressIndicator());
    //       }
    //     },
    //   ),),
    //   floatingActionButton: FloatingActionButton(
    //     //child: Icon(Icons.circle),
    //     backgroundColor: Colors.transparent,
    //     onPressed: () {
    //       // Wrap the play or pause in a call to `setState`. This ensures the
    //       // correct icon is shown.
    //       setState(() {
    //         // If the video is playing, pause it.
    //         if (_controller.value.isPlaying) {
    //           _controller.pause();
    //         }
    //         else {
    //           // If the video is paused, play it.
    //           _controller.play();
    //         }
    //       });
    //     },
    //   //   // Display the correct icon depending on the state of the player.
    //     child: Icon(
    //       _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
    //       color: Colors.grey
    //     ),
    //    ),
    //   floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,// This trailing comma makes auto-formatting nicer for build methods.
    // );
  }
}
