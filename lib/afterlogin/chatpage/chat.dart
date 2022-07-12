import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wr/afterlogin/chatpage/message.dart';
import 'package:wr/afterlogin/drawer.dart';
import 'package:wr/myvariables.dart';

import '../../cubit/scaffoldcubit_cubit.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String? messageContent;
  String? userUid;
  String? messageDate;
  Future sendMessage({required String messageContent, required String userUid, required String messageDate}) async {
    try {
      await FirebaseFirestore.instance.collection('Chat').add({'messageContent': messageContent, 'userUid': userUid, 'messageDate': messageDate});
    } catch (e) {
      print(e);
    }
  }

  List<String> messagesID = [];
  Future getMessages() async {
    messagesID.clear();
    await FirebaseFirestore.instance.collection('Chat').get().then((value) => value.docs.forEach((element) {
          messagesID.add(element.reference.id);
          print(element.reference.id.toString());
        }));
  }

  final messageContentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      drawer: appDrawer(),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            Text('tak'),
            TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
                child: Text('logout')),
            TextButton(
                onPressed: () {
                  BlocProvider.of<ScaffoldcubitCubit>(context, listen: false).mainMenuPage();
                },
                child: Text('strona 1')),
            SizedBox(
              height: height * 0.8,
              child: FutureBuilder(
                  future: getMessages(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                        itemCount: messagesID.length,
                        itemBuilder: ((context, index) {
                          return ChatMessage(messageID: messagesID[index]);
                        }));
                  }),
            )
          ],
        )),
      ),
    );
  }
}
