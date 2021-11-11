import 'package:androidtv/video_player_full_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TestUp extends Intent {
  const TestUp();
}

class TestDown extends Intent {
  const TestDown();
}

class TestReturn extends Intent {
  const TestReturn();
}

class VideoPlayer extends StatefulWidget {
  final String url;
  VideoPlayer({required this.url});
  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  bool _isPlayerReady = false;
  late String videoId;
  bool _showCloseButton = false;
  bool _showCustonControls = false;

  late VideoPlayerController _controller2;

  @override
  void initState() {
    super.initState();
    _controller2 = VideoPlayerController.network(widget.url);
    videoId = YoutubePlayer.convertUrlToId(widget.url)!;
    print(videoId);
    _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
            mute: true,
            autoPlay: false,
            disableDragSeek: false,
            loop: false,
            isLive: false,
            forceHD: false,
            hideControls: true,
            controlsVisibleAtStart: false,
            enableCaption: true))
      ..addListener(listener);
    _idController = TextEditingController(text: 'AAAAAA');
    _seekToController = TextEditingController(text: 'BBBBB');
    _videoMetaData = const YoutubeMetaData(title: 'CCCCCC');
    _playerState = PlayerState.paused;
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

  void test() {
    print('asdjhaskdaskdg');
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
    print('asdfasdfasdfasdfasdfasdfasdf');
    return Shortcuts(
        shortcuts: <LogicalKeySet, Intent>{
          LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
          // LogicalKeySet(LogicalKeyboardKey.arrowUp): const TestUp(),
          // LogicalKeySet(LogicalKeyboardKey.arrowDown): const TestDown(),
          LogicalKeySet(LogicalKeyboardKey.goBack): const TestReturn(),
        },
        manager: ShortcutManager(),
        child: Actions(
          actions: <Type, Action<Intent>>{
            // TestUp: CallbackAction<TestUp>(
            //   onInvoke: (TestUp intent) {
            //     print('Opa.... cheguei aqui - Up!');

            //     setState(() {
            //       _showCustonControls = true;
            //       const ActivateIntent();
            //       print('ShowCustonControls: $_showCustonControls');
            //     });
            //   },
            // ),
            // TestDown: CallbackAction<TestDown>(
            //   onInvoke: (TestDown intent) {
            //     print('Opa.... cheguei aqui - Down!');

            //     setState(() {
            //       _showCustonControls = false;
            //       const ActivateIntent();
            //       print('ShowCustonControls: $_showCustonControls');
            //     });
            //   },
            // ),
            TestReturn: CallbackAction<TestReturn>(
              onInvoke: (TestReturn intent) {
                print('Opa.... cheguei aqui - Return!');

                _showCustonControls = false;

                setState(() {
                  print('ShowCustonControls: $_showCustonControls');
                });
              },
            ),
          },
          child: WillPopScope(
            onWillPop: () async {
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
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Action Movies',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                focusColor: Colors.white,
                                onTap: () async {
                                  print('Opa.... $index');
                                },
                                child: SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: Card(
                                    color: Colors.black12,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text('Item $index'),
                                        ),
                                        const Divider(
                                          color: Colors.white,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('Movie $index',
                                              style: const TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //  Align(
                                //   child: Container(
                                //     height: 150,
                                //     width: 150,
                                //     color: Colors.yellow,
                                //     child: Center(child: Text('$index')),
                                //   ),
                                // ),
                              ),
                            );
                          }),
                    ),
                    // InkWell(
                    //   focusColor: Colors.white,
                    //   onTap: () async {
                    //     print('Opa.... ADADASDASDASDASDASDASDASD');

                    //     // await Navigator.push(
                    //     //     context,
                    //     //     MaterialPageRoute(
                    //     //         builder: (builder) => VideoPlayerFullScreen(
                    //     //               url: widget.url,
                    //     //             )));

                    //     // SystemChrome.setPreferredOrientations(
                    //     //     DeviceOrientation.values);

                    //     //setState(() {});

                    //     // _controller.value.isPlaying
                    //     //     ? _controller.pause()
                    //     //     : _controller.play();

                    //     //_controller.toggleFullScreenMode();

                    //     // _controller.updateValue(YoutubePlayerValue(
                    //     //   isControlsVisible: true,
                    //     //   isFullScreen: false,
                    //     //   hasPlayed: false,
                    //     //   isDragging: true,
                    //     //   isReady: false,
                    //     // ));

                    //     // _showCloseButton = !_controller.value.isPlaying;
                    //   },
                    //   child:
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 250,
                        child: Stack(
                          children: [
                            // YoutubePlayerBuilder(
                            //   onExitFullScreen: () {
                            //     // SystemChrome.setPreferredOrientations(
                            //     //     DeviceOrientation.values);

                            //     //Navigator.pop(context);
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

                            Positioned(
                              left: 16,
                              bottom: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width - 50,
                                  color: Colors.black.withOpacity(0.5),
                                  //child: ,
                                ),
                              ),
                            ),

                            // Positioned(
                            //     left: 16,
                            //     bottom: -1,
                            //     child: InkWell(
                            //       focusColor: Colors.red,
                            //       onTap: () {
                            //         print('222222222222222');
                            //       },
                            //       child: Padding(
                            //         padding: const EdgeInsets.all(8.0),
                            //         child: Container(
                            //           height: 50,
                            //           width: MediaQuery.of(context).size.width -
                            //               50,
                            //           color: Colors.black.withOpacity(0.2),
                            //         ),
                            //       ),
                            //     )),
                            // Positioned(
                            //   left: 16,
                            //   bottom: 0,
                            //   child: Padding(
                            //       padding: const EdgeInsets.all(8.0),
                            //       child: InkWell(
                            //         focusColor: Colors.green,
                            //         onTap: () {
                            //           print('111111111111111');
                            //         },
                            //         child: Container(
                            //           height: 200,
                            //           width: MediaQuery.of(context).size.width -
                            //               50,
                            //           color: Colors.black.withOpacity(0.5),
                            //         ),
                            //       )),
                            // ),

                            // Positioned(
                            //   left: 16,
                            //   bottom: -1,
                            //   child: _showCustonControls
                            //       ? InkWell(
                            //           focusColor: Colors.red,
                            //           onTap: () {
                            //             print('222222222222222');
                            //           },
                            //           child: Padding(
                            //             padding: const EdgeInsets.all(8.0),
                            //             child: Container(
                            //               height: 50,
                            //               width: MediaQuery.of(context)
                            //                       .size
                            //                       .width -
                            //                   50,
                            //               color: Colors.black.withOpacity(0.2),
                            //             ),
                            //           ),
                            //         )
                            //       : Padding(
                            //           padding: const EdgeInsets.all(8.0),
                            //           child: Container(
                            //             height: 50,
                            //             width:
                            //                 MediaQuery.of(context).size.width -
                            //                     50,
                            //             color: Colors.black.withOpacity(0.2),
                            //           ),
                            //         ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
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
