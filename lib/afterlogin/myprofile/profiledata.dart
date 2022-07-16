import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserData extends StatelessWidget {
  final String docId;
  UserData({required this.docId});

  @override
  Widget build(BuildContext context) {
    double sizedBoxHeight = 10;
    CollectionReference userData = FirebaseFirestore.instance.collection('Users');
    return FutureBuilder<DocumentSnapshot>(
        future: userData.doc(docId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            if (data['description'] == null) {
              return Column(
                children: [
                  Text(
                    'Nazwa: ${data['name']}',
                    style: TextStyle(fontFamily: 'Caslon', fontSize: 30),
                  ),
                  SizedBox(
                    height: sizedBoxHeight,
                  ),
                  Text(
                    'Urodziny: ${data['birthdate']}',
                    style: TextStyle(fontFamily: 'Caslon', fontSize: 30),
                  ),
                  SizedBox(
                    height: sizedBoxHeight,
                  ),
                  Text(
                    'Opis: ',
                    style: TextStyle(fontFamily: 'Caslon', fontSize: 30),
                  )
                ],
              );
            }
            return Column(
              children: [
                Text(
                  'Nazwa: ${data['name']}',
                  style: TextStyle(fontFamily: 'Caslon', fontSize: 30),
                ),
                SizedBox(
                  height: sizedBoxHeight,
                ),
                Text(
                  'Urodziny: ${data['birthdate']}',
                  style: TextStyle(fontFamily: 'Caslon', fontSize: 30),
                ),
                SizedBox(
                  height: sizedBoxHeight,
                ),
                Text('Opis: ${data['description']}', style: TextStyle(fontFamily: 'Caslon', fontSize: 30)),
              ],
            );
          }
          return Text('Ładowanie');
        });
  }
}
