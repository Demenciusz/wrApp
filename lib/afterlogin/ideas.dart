import 'package:flutter/material.dart';
import 'package:wr/afterlogin/drawer.dart';

class IdeasPage extends StatefulWidget {
  const IdeasPage({Key? key}) : super(key: key);

  @override
  State<IdeasPage> createState() => _IdeasPageState();
}

class _IdeasPageState extends State<IdeasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: appDrawer(),
    );
  }
}
