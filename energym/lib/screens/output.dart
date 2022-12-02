import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:energym/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'chat_screen.dart';


final _firestore = Firestore.instance;

FirebaseUser loggedInUser;

class OutputScreen extends StatefulWidget {
  static String id ="output";
  @override
  _OutputScreenState createState() => _OutputScreenState();
}

class _OutputScreenState extends State<OutputScreen> {
  final _auth = FirebaseAuth.instance;
  bool showspinner =false;



  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    setState(() {
      showspinner =true;
    });
    try {
      final user = await _auth.currentUser();
      if (user != null) {

        loggedInUser = user;
      }
      else {

        setState(() {
          showspinner =true;
        });
      }
      setState(() {
        showspinner = false;
      });
    } catch (e) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
              }),
        ],
        title: Text('Output Parameters'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      backgroundColor: Colors.blueGrey,
      body : ModalProgressHUD(
        inAsyncCall: showspinner,
        child: StreamBuilder(
          stream:  _firestore.collection("Energy Readings").document(loggedInUser.email).collection('parameters').document('output').snapshots(),
          builder: (context,snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
    if (snapshot.connectionState == ConnectionState.active ) {
      final curr = snapshot.data['current'];
      final vol = snapshot.data['voltage'];
      final freq = snapshot.data['frequency'];
      final pf = snapshot.data['pf'];
      return SafeArea(
        child: Container(
          height: 250,
          margin: EdgeInsets.all(20.0),
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              border: Border.all(
                color: Colors.black,
                width: 0.5,
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Text("Current: $curr mA", style: TextStyle(
                    fontSize: 22.0
                ),),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Text("Voltage: $vol V", style: TextStyle(
                    fontSize: 22.0
                ),),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Text("Frequency: $freq Hz", style: TextStyle(
                    fontSize: 22.0
                ),),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Text("PF: $pf°", style: TextStyle(
                    fontSize: 22.0
                ),),
              ),
            ],

          ),

        ),
      );
    }
          },
        ),
      ),
    );

  }
}