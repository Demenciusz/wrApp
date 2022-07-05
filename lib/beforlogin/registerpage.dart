import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../myvariables.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegExp myRegex = RegExp(r'@');
  final nickNameController = TextEditingController();
  final emailController = TextEditingController();
  final birthDateController = TextEditingController();
  final passwordController1 = TextEditingController();
  final passwordController2 = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future signToApp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController1.text.trim());
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      final String myUid = user!.uid;
      userProfileData(
          profileNickName: nickNameController.text.trim(),
          profileBirthDate: birthDateController.text.trim(),
          profileEmail: emailController.text.trim(),
          uid: myUid);
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
    }
  }

  Future userProfileData({String? profileNickName, String? profileBirthDate, String? profileEmail, String? uid}) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .add({'name': profileNickName, 'birthdate': profileBirthDate, 'email': profileEmail, 'uid': uid});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeigth = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: screenWidth,
              height: screenHeigth * 0.15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                  width: screenWidth * 0.9,
                  child: TextField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple), borderRadius: BorderRadius.circular(20)),
                        hintText: nickName,
                        fillColor: Colors.grey[200],
                        filled: true,
                        hintStyle: TextStyle(color: Colors.black)),
                    controller: nickNameController,
                    style: TextStyle(fontFamily: 'Caslon', fontSize: screenWidth * 0.06, color: Colors.grey.shade800),
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                  width: screenWidth * 0.9,
                  child: TextField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple), borderRadius: BorderRadius.circular(20)),
                        hintText: birthDate,
                        fillColor: Colors.grey[200],
                        filled: true,
                        hintStyle: TextStyle(color: Colors.black)),
                    controller: birthDateController,
                    style: TextStyle(fontFamily: 'Caslon', fontSize: screenWidth * 0.06, color: Colors.grey.shade800),
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                  width: screenWidth * 0.9,
                  child: TextField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple), borderRadius: BorderRadius.circular(20)),
                        hintText: email,
                        fillColor: Colors.grey[200],
                        filled: true,
                        hintStyle: TextStyle(color: Colors.black)),
                    controller: emailController,
                    //obscureText: true,
                    style: TextStyle(fontFamily: 'Caslon', fontSize: screenWidth * 0.06, color: Colors.grey.shade800),
                  )),
            ),
            const SizedBox(
              height: 15,
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
                        filled: true,
                        hintStyle: TextStyle(color: Colors.black)),
                    controller: passwordController1,
                    obscureText: true,
                    style: TextStyle(fontFamily: 'Caslon', fontSize: screenWidth * 0.06, color: Colors.grey.shade800),
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                  width: screenWidth * 0.9,
                  child: TextField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple), borderRadius: BorderRadius.circular(20)),
                        hintText: repeatPassword,
                        fillColor: Colors.grey[200],
                        filled: true,
                        hintStyle: TextStyle(color: Colors.black)),
                    controller: passwordController2,
                    obscureText: true,
                    style: TextStyle(fontFamily: 'Caslon', fontSize: screenWidth * 0.06, color: Colors.grey.shade800),
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(color: Colors.deepPurple, borderRadius: BorderRadius.circular(20)),
                child: SizedBox(
                  width: screenWidth * 0.9,
                  child: TextButton(
                    onPressed: () async {
                      setState(() {
                        if (emailController.text.length != 0 &&
                            passwordController1.text.length != 0 &&
                            passwordController2.text.length != 0 &&
                            nickNameController.text.length != 0 &&
                            birthDateController.text.length != 0) {
                          if (passwordController1.text == passwordController2.text) {
                            if (myRegex.hasMatch(emailController.text)) {
                              signToApp();
                              Navigator.pop(context);
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text(alertDialogText),
                                        content: Text(alertDialogContentText3),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('OK'))
                                        ],
                                      ));
                            }
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text(alertDialogText),
                                      content: Text(alertDialogContentText2),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('OK'))
                                      ],
                                    ));
                          }
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text(alertDialogText),
                                    content: Text(alertDialogContentText1),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('OK'))
                                    ],
                                  ));
                        }
                      });
                    },
                    child: Text(
                      registerButtonText,
                      style: TextStyle(fontFamily: 'Caslon', fontSize: screenWidth * 0.08, color: textLoginColor),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(color: Colors.deepPurple, borderRadius: BorderRadius.circular(20)),
                child: SizedBox(
                  width: screenWidth * 0.9,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      loginButtonText,
                      style: TextStyle(fontFamily: 'Caslon', fontSize: screenWidth * 0.08, color: textLoginColor),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
