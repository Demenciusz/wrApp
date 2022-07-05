import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wr/afterlogin/drawer.dart';
import 'package:wr/myvariables.dart';

import '../cubit/scaffoldcubit_cubit.dart';

class CommentsPage extends StatelessWidget {
  const CommentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: appDrawer(),
      body: Center(
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
              child: Text('strona 1'))
        ],
      )),
    );
  }
}
