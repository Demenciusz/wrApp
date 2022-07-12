import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wr/afterlogin/drawer.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_st;
import 'dart:io';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:wr/afterlogin/myprofile/photostorage.dart';
import 'package:wr/afterlogin/myprofile/profiledata.dart';

import '../../cubit/scaffoldcubit_cubit.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  Future<void> pickIMG() async {}
  //List<String> usersData = [];
  Future<String> displayData(String uid) async {
    String? conId;
    await FirebaseFirestore.instance.collection('Users').where('uid', isEqualTo: uid).get().then((snapshot) => snapshot.docs.forEach((element) {
          print('--------------------');
          print(element.reference.id.toString());
          print('-------------------');
          //usersData.add(element.reference.id);
          conId = element.reference.id.toString();
        }));
    return conId!;
  }

  @override
  Widget build(BuildContext context) {
    PhotoStorage photoStorage = PhotoStorage();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final String uid = user!.uid;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              FutureBuilder(
                  future: photoStorage.displayPhoto(uid),
                  builder: ((context, AsyncSnapshot<String> snapshot) {
                    if ((snapshot.connectionState == ConnectionState.done || snapshot.hasData) && snapshot.data != '1') {
                      return Image.network(
                        snapshot.data!,
                        width: 100,
                      );
                    } else if (snapshot.data == '1') {
                      return Image.asset(
                        'assets/photos/dice.png',
                        width: 100,
                      );
                    }
                    return const CircularProgressIndicator();
                  })),
              TextButton(
                child: Text('dd'),
                onPressed: () async {
                  final profilePhoto =
                      await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.custom, allowedExtensions: ['png', 'jpg']);
                  if (profilePhoto == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('nie ma')));
                  } else {
                    final path = profilePhoto.files.single.path;
                    photoStorage.uploadPhoto(path!, uid);
                    await Future.delayed(Duration(seconds: 2));
                    setState(() {});
                  }
                },
              ),
              FutureBuilder(
                  future: displayData(uid),
                  builder: (context, snapshot) {
                    return UserData(docId: snapshot.data.toString());
                  })
            ],
          ),
        ),
      ),
      drawer: appDrawer(),
    );
  }
}
