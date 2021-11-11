import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerFullScreen extends StatefulWidget {
  final String url;
  VideoPlayerFullScreen({required this.url});
  @override
  _VideoPlayerFullScreenState createState() => _VideoPlayerFullScreenState();
}

class _VideoPlayerFullScreenState extends State<VideoPlayerFullScreen> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  bool _isPlayerReady = false;
  late String videoId;
  bool _showCloseButton = false;
  @override
  void initState() {
    super.initState();
    videoId = YoutubePlayer.convertUrlToId(widget.url)!;
    print(videoId);
    _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
            mute: true,
            autoPlay: true,
            disableDragSeek: false,
            loop: false,
            isLive: false,
            forceHD: false,
            enableCaption: true))
      ..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
    _showCloseButton = _controller.value.isControlsVisible;
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
        shortcuts: <LogicalKeySet, Intent>{
          LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
        },
        manager: ShortcutManager(),
        child: WillPopScope(
          onWillPop: () async {
            //Navigator.pop(context);
            setState(() {
              SystemChrome.setPreferredOrientations(
                  [DeviceOrientation.portraitUp]);
            });
            return true;
          },
          child: Scaffold(
              backgroundColor: Colors.blueGrey,
              body: SafeArea(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    InkWell(
                      focusColor: Colors.white,
                      onTap: () async {
                        print('Opa.... ADADASDASDASDASDASDASDASD');

                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();

                        _showCloseButton = !_controller.value.isPlaying;
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 250,
                          child: YoutubePlayerBuilder(
                            onExitFullScreen: () {
                              // SystemChrome.setPreferredOrientations(
                              //     DeviceOrientation.values);
                            },
                            player: YoutubePlayer(
                                controller: _controller,
                                showVideoProgressIndicator: true,
                                progressIndicatorColor: Colors.blueAccent,
                                topActions: <Widget>[
                                  const SizedBox(width: 8.0),
                                  Text(_controller.metadata.title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1)
                                ],
                                onReady: () {
                                  _isPlayerReady = true;
                                },
                                onEnded: (data) {}),
                            builder: (context, player) => Scaffold(body: player

                                // Stack(
                                //   children: [
                                //     Container(
                                //       height: MediaQuery.of(context).size.height,
                                //       color: Colors.red,
                                //       child: player,
                                //     ),
                                //     _showCloseButton
                                //         ? SafeArea(
                                //             child: GestureDetector(
                                //               onTap: () {
                                //                 Navigator.pop(context);
                                //               },
                                //               child: const SizedBox(
                                //                 width: 50,
                                //                 height: 50,
                                //                 child: Icon(
                                //                   Icons.close,
                                //                   size: 25,
                                //                   color: Colors.white,
                                //                 ),
                                //               ),
                                //             ),
                                //           )
                                //         : Container(),
                                //   ],
                                // ),
                                ),
                          ),
                        ),
                      ),
                    ),
                  ]))),
        ));

    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
      },
      manager: ShortcutManager(),
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: InkWell(
          focusColor: Colors.white,
          child: Column(
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      print('Opa....');
                    },
                    child: Container(
                      height: 200,
                      width: 200,
                      color: Colors.yellow,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('Opa.... 2');
                    },
                    child: Container(
                      height: 200,
                      width: 200,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              // YoutubePlayerBuilder(
              //   onExitFullScreen: () {
              //     SystemChrome.setPreferredOrientations(
              //         [DeviceOrientation.portraitDown]);
              //   },
              //   player: YoutubePlayer(
              //       controller: _controller,
              //       showVideoProgressIndicator: true,
              //       progressIndicatorColor: Colors.blueAccent,
              //       topActions: <Widget>[
              //         const SizedBox(width: 8.0),
              //         Text(_controller.metadata.title,
              //             style: const TextStyle(
              //               color: Colors.white,
              //               fontSize: 18.0,
              //             ),
              //             overflow: TextOverflow.ellipsis,
              //             maxLines: 1)
              //       ],
              //       onReady: () {
              //         _isPlayerReady = true;
              //       },
              //       onEnded: (data) {}),
              //   builder: (context, player) => Scaffold(body: player

              //       // Stack(
              //       //   children: [
              //       //     Container(
              //       //       height: MediaQuery.of(context).size.height,
              //       //       color: Colors.red,
              //       //       child: player,
              //       //     ),
              //       //     _showCloseButton
              //       //         ? SafeArea(
              //       //             child: GestureDetector(
              //       //               onTap: () {
              //       //                 Navigator.pop(context);
              //       //               },
              //       //               child: const SizedBox(
              //       //                 width: 50,
              //       //                 height: 50,
              //       //                 child: Icon(
              //       //                   Icons.close,
              //       //                   size: 25,
              //       //                   color: Colors.white,
              //       //                 ),
              //       //               ),
              //       //             ),
              //       //           )
              //       //         : Container(),
              //       //   ],
              //       // ),
              //       ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
