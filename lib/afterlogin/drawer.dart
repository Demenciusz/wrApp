import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wr/myvariables.dart';

import '../cubit/scaffoldcubit_cubit.dart';

Drawer appDrawer() {
  return Drawer(
    child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [HeadOfDrawer(), BodyWidget()],
      ),
    ),
  );
}

class HeadOfDrawer extends StatefulWidget {
  const HeadOfDrawer({Key? key}) : super(key: key);

  @override
  State<HeadOfDrawer> createState() => _HeadOfDrawerState();
}

class _HeadOfDrawerState extends State<HeadOfDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/photos/dice.png',
              width: 128,
            ),
          ],
        ),
      ),
    );
  }
}

Widget BodyOfDrawer() {
  return BodyWidget();
}

class BodyWidget extends StatelessWidget {
  const BodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 70,
            child: TextButton(
              child: Text(
                drawerMainMenu,
                style: TextStyle(fontFamily: 'Caslon', fontSize: drawerFontSize),
              ),
              onPressed: () {
                BlocProvider.of<ScaffoldcubitCubit>(context, listen: false).mainMenuPage();
              },
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 70,
            child: TextButton(
              child: Text(
                drawerMyProfile,
                style: TextStyle(fontFamily: 'Caslon', fontSize: drawerFontSize),
              ),
              onPressed: () {
                BlocProvider.of<ScaffoldcubitCubit>(context, listen: false).myProfilePage();
                //Navigator.pushNamed(context, '/myprofile');
              },
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 70,
            child: TextButton(
              child: Text(
                drawerComments,
                style: TextStyle(fontFamily: 'Caslon', fontSize: drawerFontSize),
              ),
              onPressed: () {
                BlocProvider.of<ScaffoldcubitCubit>(context, listen: false).commentsPage();
              },
            ),
          ),
          SizedBox(
            height: 70,
            width: double.infinity,
            child: TextButton(
              child: Text(
                drawerIdeas,
                style: TextStyle(fontFamily: 'Caslon', fontSize: drawerFontSize),
              ),
              onPressed: () {
                BlocProvider.of<ScaffoldcubitCubit>(context, listen: false).ideasPage();
              },
            ),
          ),
          SizedBox(
            height: 70,
            width: double.infinity,
            child: TextButton(
              child: Text(
                drawerRollDice,
                style: TextStyle(fontFamily: 'Caslon', fontSize: drawerFontSize),
              ),
              onPressed: () {
                BlocProvider.of<ScaffoldcubitCubit>(context, listen: false).throwTheDicePage();
              },
            ),
          ),
          SizedBox(
            height: 70,
            width: double.infinity,
            child: TextButton(
              child: Text(
                drawerLogout,
                style: TextStyle(fontFamily: 'Caslon', fontSize: drawerFontSize),
              ),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
          ),
        ],
      ),
    );
  }
}
