import 'package:energym/constants.dart';
import 'package:flutter/material.dart';
import 'package:energym/components/buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:energym/screens/chat_screen.dart';
import 'package:energym/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;

class RegistrationScreen extends StatefulWidget {
  static String id ="reg";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool showspinner =false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  final messageTextController = TextEditingController();
  final messageTextController1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showspinner ,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag:'logo',
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
                  //Do something with the user input.
                  email=value;
                },
                decoration:  kdeco.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: messageTextController1,
                obscureText: true,
                onChanged: (value) {
                  password=value;
                  //Do something with the user input.
                },
                decoration: kdeco.copyWith(hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              Roundedbutton(colour: Colors.blueAccent,txt: 'Register',onpress: () async {
                setState(() {
                  showspinner =true;
                });
//                print(email);
//                print(password);
              try {
                final newuser = await _auth.createUserWithEmailAndPassword(
                    email: email, password: password);
                if (newuser !=null){
                  messageTextController.clear();
                  messageTextController1.clear();

                  _firestore.collection("Energy Readings").document(email).setData({
                    'Temperature': null,
                    'condition':  null,
                  });
                  _firestore.collection('Energy Readings').document(email)
                      .collection("parameters")
                      .document("input")
                      .setData({
                    'current': null,
                    'voltage': null,
                    'frequency': null,
                    'pf': null,
                  });
                  _firestore.collection('Energy Readings').document(
                      email)
                      .collection("parameters")
                      .document("output")
                      .setData({
                  'current': null,
                  'voltage': null,
                  'frequency': null,
                  'pf': null,

                  });
                  _firestore.collection('Energy Readings').document(
                      email)
                      .collection("Industries")
                      .document("Indutry1")
                      .setData({
                    'input_current': null,
                    'input_voltage': null,
                    'input_frequency': null,
                    'input_pf': null,
                    'output_current': null,
                    'output_voltage': null,
                    'output_frequency': null,
                    'output_pf': null,
                  });
                  _firestore.collection('Energy Readings').document(
                      email)
                      .collection("Industries")
                      .document("Indutry2")
                      .setData({
                    'input_current': null,
                    'input_voltage': null,
                    'input_frequency': null,
                    'input_pf': null,
                    'output_current': null,
                    'output_voltage': null,
                    'output_frequency': null,
                    'output_pf': null,

                  });
                  _firestore.collection('Energy Readings').document(
                      email)
                      .collection("Industries")
                      .document("Indutry3")
                      .setData({
                    'input_current': null,
                    'input_voltage': null,
                    'input_frequency': null,
                    'input_pf': null,
                    'output_current': null,
                    'output_voltage': null,
                    'output_frequency': null,
                    'output_pf': null,

                  });
                  _firestore.collection('Energy Readings').document(
                      email)
                      .collection("Houses")
                      .document("House1")
                      .setData({
                    'input_current': null,
                    'input_voltage': null,
                    'input_frequency': null,
                    'input_pf': null,
                    'output_current': null,
                    'output_voltage': null,
                    'output_frequency': null,
                    'output_pf': null,
                  });
                  _firestore.collection('Energy Readings').document(
                      email)
                      .collection("Houses")
                      .document("House2")
                      .setData({
                    'input_current': null,
                    'input_voltage': null,
                    'input_frequency': null,
                    'input_pf': null,
                    'output_current': null,
                    'output_voltage': null,
                    'output_frequency': null,
                    'output_pf': null,

                  });

                  Navigator.pushNamed(context, HomeScreen.id);
                }
                setState(() {
                  showspinner = false;
                });
              }
              catch(e){
                print(e);
              }
                },),
            ],
          ),
        ),
      ),
    );
  }
}
