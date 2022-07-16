import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wr/afterlogin/myprofile/photostorage.dart';
import 'package:wr/myvariables.dart';

import '../../cubit/scaffoldcubit_cubit.dart';

class EditMyProfile extends StatefulWidget {
  const EditMyProfile({Key? key}) : super(key: key);

  @override
  State<EditMyProfile> createState() => _EditMyProfileState();
}

class _EditMyProfileState extends State<EditMyProfile> {
  Future editProfilBirth({required String uid, required String birthDate}) async {
    await FirebaseFirestore.instance.collection('Users').doc(uid).update({'birthdate': birthDate});
  }

  Future editProfilNickName({required String uid, required String nickName}) async {
    await FirebaseFirestore.instance.collection('Users').doc(uid).update({'name': nickName});
  }

  Future editProfilDescription({required String uid, required String description}) async {
    await FirebaseFirestore.instance.collection('Users').doc(uid).update({'description': description});
  }

  Future editProfilPhoto({required String uid, required PhotoStorage photoStorage}) async {
    final profilePhoto = await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.custom, allowedExtensions: ['png', 'jpg']);
    if (profilePhoto == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('nie ma')));
    } else {
      final path = profilePhoto.files.single.path;
      photoStorage.uploadPhoto(path!, uid);
    }
  }

  final nameController = TextEditingController();
  final birthDateController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    birthDateController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PhotoStorage photoStorage = PhotoStorage();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final String myUid = user!.uid;
    double sizedBoxHeight = 10;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 2 * sizedBoxHeight,
            ),
            Container(
              width: screenWidth * 0.9,
              decoration: BoxDecoration(color: Colors.grey.shade800, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                  onPressed: () {
                    editProfilPhoto(uid: myUid, photoStorage: photoStorage);
                  },
                  child: Text(
                    editPhotoButton,
                    style: TextStyle(fontFamily: 'Caslon', fontSize: 2.5 * sizedBoxHeight, color: textLoginColor),
                  )),
            ),
            SizedBox(
              height: 2 * sizedBoxHeight,
            ),
            Text(
              nickName + ':',
              style: TextStyle(fontFamily: 'Caslon', fontSize: 2 * sizedBoxHeight, color: textLoginColor),
            ),
            SizedBox(
              height: sizedBoxHeight,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                  width: screenWidth * 0.9,
                  child: TextField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple), borderRadius: BorderRadius.circular(20)),
                        hintText: password,
                        fillColor: Colors.grey[200],
                        filled: true),
                    controller: nameController,
                    style: TextStyle(fontFamily: 'Caslon', fontSize: 2 * sizedBoxHeight, color: Colors.grey.shade800),
                  )),
            ),
            SizedBox(
              height: sizedBoxHeight,
            ),
            Text(
              '$birthDate:',
              style: TextStyle(fontFamily: 'Caslon', fontSize: 2 * sizedBoxHeight, color: textLoginColor),
            ),
            SizedBox(
              height: sizedBoxHeight,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                  width: screenWidth * 0.9,
                  child: TextField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple), borderRadius: BorderRadius.circular(20)),
                        hintText: password,
                        fillColor: Colors.grey[200],
                        filled: true),
                    controller: birthDateController,
                    style: TextStyle(fontFamily: 'Caslon', fontSize: 2 * sizedBoxHeight, color: Colors.grey.shade800),
                  )),
            ),
            SizedBox(
              height: sizedBoxHeight,
            ),
            Text(
              'Opis:',
              style: TextStyle(fontFamily: 'Caslon', fontSize: 2 * sizedBoxHeight, color: textLoginColor),
            ),
            SizedBox(
              height: sizedBoxHeight,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                  width: screenWidth * 0.9,
                  child: TextField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple), borderRadius: BorderRadius.circular(20)),
                        hintText: password,
                        fillColor: Colors.grey[200],
                        filled: true),
                    controller: descriptionController,
                    style: TextStyle(fontFamily: 'Caslon', fontSize: 2 * sizedBoxHeight, color: Colors.grey.shade800),
                  )),
            ),
            SizedBox(
              height: 2 * sizedBoxHeight,
            ),
            Container(
              width: screenWidth * 0.9,
              decoration: BoxDecoration(color: Colors.grey.shade800, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (alterContext) => AlertDialog(
                            title: Text(alertDialogEdit),
                            content: Text(alertDialogContentEdit),
                            actions: [
                              TextButton(
                                  onPressed: () async {
                                    print(nameController.text);
                                    Navigator.pop(alterContext);
                                    if (nameController.text != '') {
                                      await editProfilNickName(uid: myUid, nickName: nameController.text.trim());
                                    }
                                    if (birthDateController.text != '') {
                                      await editProfilBirth(uid: myUid, birthDate: birthDateController.text.trim());
                                    }
                                    if (descriptionController.text != '') {
                                      await editProfilDescription(uid: myUid, description: descriptionController.text.trim());
                                    }
                                    await Future.delayed(Duration(seconds: 1));
                                    BlocProvider.of<ScaffoldcubitCubit>(context, listen: false).myProfilePage();
                                  },
                                  child: Text('OK')),
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.pop(alterContext);
                                },
                              )
                            ],
                          ));
                  //BlocProvider.of<ScaffoldcubitCubit>(context, listen: false).myProfilePage();
                },
                child: Text(saveChanges, style: TextStyle(fontFamily: 'Caslon', fontSize: 2.5 * sizedBoxHeight, color: textLoginColor)),
              ),
            ),
            SizedBox(
              height: 2 * sizedBoxHeight,
            ),
            Container(
              width: screenWidth * 0.9,
              decoration: BoxDecoration(color: Colors.grey.shade800, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                  onPressed: () {
                    BlocProvider.of<ScaffoldcubitCubit>(context, listen: false).myProfilePage();
                  },
                  child: Text(editBackButton, style: TextStyle(fontFamily: 'Caslon', fontSize: 2.5 * sizedBoxHeight, color: textLoginColor))),
            )
          ],
        ),
      )),
    );
  }
}
