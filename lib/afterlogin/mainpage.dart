//import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wr/cubit/scaffoldcubit_cubit.dart';
import 'package:wr/afterlogin/drawer.dart';
import 'package:wr/beforlogin/loginpage.dart';
import 'package:wr/data/video.dart';
import 'package:wr/myvariables.dart';
import '../beforlogin/registerpage.dart';
import 'package:wr/data/video.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({Key? key}) : super(key: key);

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  Future<List<Video>> makeList() async {
    String ytUrl = 'https://www.youtube.com/feeds/videos.xml?channel_id=UCXnI7wpHJ-x8bafp1BK3DUQ';
    Uri url = Uri.parse(ytUrl);
    http.Response response = await http.get(url);
    List<Video> videos = [];
    if (response.statusCode == 200) {
      final xmlData = XmlDocument.parse(response.body);
      for (var entry in xmlData.findAllElements('entry')) {
        String title = entry.getElement('title')!.innerText;
        String link = entry.getElement('yt:videoId')!.innerText;
        String? thumnbailUrl = entry.getElement('media:group')!.getElement('media:thumbnail')!.getAttribute('url');
        Video video = Video(
          link: link,
          title: title,
          thumnbailUrl: thumnbailUrl!,
        );
        videos.add(video);
      }
    }
    return videos;
  }

  Widget min(String link, String thumnbailUrl, String title, double size) {
    return SizedBox(
      width: size * 0.93,
      height: 100,
      child: Column(
        children: [
          GestureDetector(
            onTap: () => openVideo(link),
            child: Image.network(
              thumnbailUrl,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(title),
          SizedBox(
            height: 35,
          ),
        ],
      ),
    );
  }

  void openVideo(String link) async {
    Uri uri = Uri.parse('https://www.youtube.com/watch?v=' + link);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $link';
    }
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: size * 0.9,
                  child: FutureBuilder<List<Video>>(
                      future: makeList(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Video> video = snapshot.data!;
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: SizedBox(
                              child: ListView.separated(
                                separatorBuilder: (context, index) => SizedBox(
                                  width: 20,
                                ),
                                scrollDirection: Axis.horizontal,
                                itemCount: video.length,
                                itemBuilder: (co, index) {
                                  return min(video[index].getLink(), video[index].getThumnbailUrl(), video[index].getTitle(), size);
                                },
                              ),
                            ),
                          );
                        } else
                          return const CircularProgressIndicator();
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Text(
                    des,
                    style: TextStyle(fontSize: 20, fontFamily: 'Caslon'),
                  ),
                )
              ],
            ),
          ),
        ),
        drawer: appDrawer());
  }
}
