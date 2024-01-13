import 'dart:async';
import 'package:test1/learn_screen/quiz_screen.dart';
import 'package:test1/learn_screen/vocabulary_screen.dart';

import 'video_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'package:video_player/video_player.dart';
import 'package:flutter/cupertino.dart';

class PlayVideoPage extends StatefulWidget {
  PlayVideoPage({
    Key? key,
    required this.info,
    required this.title,
  }) : super(key: key);

  final Map info;
  final String title;

  @override
  _PlayVideoPageState createState() => _PlayVideoPageState();
}

class _PlayVideoPageState extends State<PlayVideoPage> {
  VideoPlayerController? _controller;

  bool _showTranscript = false;

  @override
  void initState() {
    super.initState();
    _setVideoController();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  Future<void> _setVideoController() async {
    VideoPlayerController controller;
    // print('play video ');
    controller = VideoPlayerController.network(widget.info['url']);
    // print('network:' + widget.info['url']);

    setState(() {
      _controller = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(70, 130, 169, 1),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50.0),
            bottomRight: Radius.circular(50.0),
          ),
        ),
        toolbarHeight: 60,
        flexibleSpace: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 50,
                width: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/logo.png"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: _controller != null
      // able to change after you choose both videos
          ? Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: height * 0.5,
                  color: const Color(0xFF232222),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: VideoItems(
                          videoPlayerController: _controller!,
                          autoplay: false,
                          looping: false,
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _showTranscript =
                                          !_showTranscript;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.transcribe,
                                        color: Colors.white,
                                        size: 40,
                                      )),
                                  const Text(
                                    'Transcript',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    VocabularyPage(
                                                        words: widget
                                                            .info[
                                                        'words'])));
                                      },
                                      icon: const Icon(
                                        Icons.text_snippet_outlined,
                                        color: Colors.white,
                                        size: 40,
                                      )),
                                  const Text(
                                    'Vocabulary',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    QuizPage(
                                                      questions: widget
                                                          .info['quiz'],
                                                    )));
                                      },
                                      icon: const Icon(
                                        Icons.question_mark,
                                        color: Colors.white,
                                        size: 40,
                                      )),
                                  const Text(
                                    'Quiz',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                      maxLines: 3,
                    ),
                  ),
                ),
                _showTranscript
                    ? Text(
                  widget.info['transcript'],
                  style: TextStyle(fontSize: 20),
                )
                    : const SizedBox(
                  height: 300,
                )
              ],
            ),
          ),
        ),
      )
          : Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'There was an error playing the video',
                  style: TextStyle(fontSize: 50),
                  selectionColor: Colors.red,
                ),
              ])),
    );
  }
}

