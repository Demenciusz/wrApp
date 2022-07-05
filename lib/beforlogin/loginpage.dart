import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stream_listener/flutter_stream_listener.dart';
import '../myvariables.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
    } catch (e) {
      print(e.runtimeType);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeigth = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: screenHeigth * 0.1,
              ),
              Image.asset(
                'assets/photos/dice.png',
                width: screenHeigth * 0.3,
              ),
              SizedBox(
                height: screenHeigth * 0.1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                    width: screenWidth * 0.9,
                    child: TextField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(20)),
                          focusedBorder:
                              OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple), borderRadius: BorderRadius.circular(20)),
                          hintText: email,
                          fillColor: Colors.grey[200],
                          filled: true),
                      controller: emailController,
                      style: TextStyle(fontFamily: 'Caslon', fontSize: screenWidth * 0.08, color: Colors.grey.shade800),
                    )),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                    width: screenWidth * 0.9,
                    child: TextField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(20)),
                          focusedBorder:
                              OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple), borderRadius: BorderRadius.circular(20)),
                          hintText: password,
                          fillColor: Colors.grey[200],
                          filled: true),
                      controller: passwordController,
                      obscureText: true,
                      style: TextStyle(fontFamily: 'Caslon', fontSize: screenWidth * 0.08, color: Colors.grey.shade800),
                    )),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(color: Colors.deepPurple, borderRadius: BorderRadius.circular(20)),
                  child: SizedBox(
                    width: screenWidth * 0.9,
                    child: TextButton(
                      child: Text(
                        loginButtonText,
                        style: TextStyle(fontFamily: 'Caslon', fontSize: screenWidth * 0.08, color: textLoginColor),
                      ),
                      onPressed: signIn,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(color: Colors.deepPurple, borderRadius: BorderRadius.circular(20)),
                  child: SizedBox(
                    width: screenWidth * 0.9,
                    child: TextButton(
                      child: Text(
                        goToRegister,
                        style: TextStyle(fontFamily: 'Caslon', fontSize: screenWidth * 0.08, color: textLoginColor),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
