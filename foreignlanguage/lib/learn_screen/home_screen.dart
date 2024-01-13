import 'play_video_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../firebase/db.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Map links = {
  //   '10 MIN BEGINNER AB WORKOUT':
  //       'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  // };
  Map info = {};
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVideos();
  }

  getVideos() async {
    getVideoFiles().then((value) => setState(() {
          print(value);
          if (value != null) info = value;
        }));
    Future.delayed(const Duration(seconds: 5)).then((value) {
      setState(() {
        loading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
        toolbarHeight: 100,
        flexibleSpace: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 85,
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
      body: loading
          ? info.isNotEmpty
              ? Center(
                  child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: info.length,
                    itemBuilder: (BuildContext context, int index) {
                      String title = info.keys.elementAt(index);
                      return Card(
                          child: ListTile(
                        title: Text(title),
                        trailing: IconButton(
                          icon: const Icon(Icons.play_circle),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PlayVideoPage(
                                          info: info[title],
                                          title: title,
                                        )));
                          },
                        ),
                      ));
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                ))
              : Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('No videos found'),
                    )
                  ],
                ))
          : Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Loading Videos ...'),
                )
              ],
            )),
    );
  }
}

