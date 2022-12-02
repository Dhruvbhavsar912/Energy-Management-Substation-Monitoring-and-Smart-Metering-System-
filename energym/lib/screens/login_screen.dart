import 'package:flutter/material.dart';
import 'package:energym/components/buttons.dart';
import 'package:energym/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:energym/screens/chat_screen.dart';
import 'package:energym/screens/home_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static String id ="log";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showspinner=false;
  final messageTextController = TextEditingController();
  final messageTextController1 = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String email;
  String password;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showspinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                controller: messageTextController,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email=value;
                  //Do something with the user input.
                },
                decoration: kdeco.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: messageTextController1,
                obscureText: true,
                onChanged: (value) {
                  //Do something with the user input.
                  password=value;
                },
                decoration: kdeco.copyWith(hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              Roundedbutton(colour: Colors.lightBlueAccent,txt: 'Log In',onpress: () async{


                setState(() {
                  showspinner = true;
                });

                try {
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (user !=null){
                    messageTextController.clear();
                    messageTextController1.clear();
                    Navigator.pushNamed(context, HomeScreen.id);
                  }
                  setState(() {

                    showspinner = false;
                  });
                }
                catch(e){
                  print(e);
                  setState(() {
                    showspinner = false;
                  });
                }

              },),
            ],
          ),
        ),
      ),
    );
  }
}

