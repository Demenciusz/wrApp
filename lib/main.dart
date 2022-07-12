// ignore_for_file: use_key_in_widget_constructors, avoid_print, prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wr/afterlogin/chatpage/chat.dart';
import 'package:wr/afterlogin/ideas.dart';
import 'package:wr/beforlogin/loginpage.dart';
import 'package:wr/afterlogin/mainpage.dart';
import 'package:wr/afterlogin/myprofile/myprofile.dart';
import 'package:wr/myvariables.dart';
import 'package:wr/beforlogin/registerpage.dart';
import 'package:wr/routing.dart';
import 'package:wr/afterlogin/throwdice.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bloc/bloc.dart';
import 'package:wr/cubit/scaffoldcubit_cubit.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  RouteGenerator router = RouteGenerator();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
          buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.accent,
      )),
      onGenerateRoute: router.generateRoute,
      initialRoute: '/',
    );
  }
}

class BuilderWidget extends StatelessWidget {
  const BuilderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return BlocBuilder<ScaffoldcubitCubit, ScaffoldcubitState>(builder: ((context, state) {
            if (state is routerMainMenuPage) {
              return MainMenuPage();
            }
            if (state is routerCommentsPage) {
              return ChatPage();
            }
            if (state is routerThrowTheDicePage) {
              return ThrowDicePage();
            }
            if (state is routerMyProfilePage) {
              return MyProfile();
            }
            if (state is routerIdeasPage) {
              return IdeasPage();
            }
            return MainMenuPage();
          }));
        } else {
          return LoginPage();
        }
      },
      stream: FirebaseAuth.instance.authStateChanges(),
    );
  }
}
