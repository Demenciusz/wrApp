import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChatMessage extends StatelessWidget {
  final String messageID;
  ChatMessage({required this.messageID});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final String myUid = user!.uid;
    CollectionReference messageData = FirebaseFirestore.instance.collection('Chat');
    return FutureBuilder<DocumentSnapshot>(
        future: messageData.doc(messageID).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            if (data['userUid'] == myUid) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Text(data['messageContent'])],
              );
            } else
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Text(data['messageContent']))
                ],
              );
          } else {
            return Text('Ładowanie');
          }
        });
  }
}
