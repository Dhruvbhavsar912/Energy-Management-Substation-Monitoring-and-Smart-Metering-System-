import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';



final _firestore = Firestore.instance;

FirebaseUser loggedInUser;

class House1Screen extends StatefulWidget {
  static String id ="house1";
  @override
  _House1ScreenState createState() => _House1ScreenState();
}

class _House1ScreenState extends State<House1Screen> {
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
        title: Text('House1 Parameters'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      backgroundColor: Colors.blueGrey,
      body : ModalProgressHUD(
        inAsyncCall: showspinner,
        child: StreamBuilder(
          stream:  _firestore.collection('Energy Readings').document(
              loggedInUser.email)
              .collection("Houses")
              .document("House1").snapshots(),
          builder: (context,snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
    if (snapshot.connectionState == ConnectionState.active ) {
      final curr = snapshot.data['input_current'];
      final vol = snapshot.data['input_voltage'];
      final freq = snapshot.data['input_frequency'];
      final pf = snapshot.data['input_pf'];
      final curr1 = snapshot.data['output_current'];
      final vol1 = snapshot.data['output_voltage'];
      final freq1 = snapshot.data['output_frequency'];
      final pf1 = snapshot.data['output_pf'];
      return SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(

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
                    Center(child: Text("Input Parameters", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),)),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Text("Current: $curr mA", style: TextStyle(
                          fontSize: 20.0
                      ),),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Text("Voltage: $vol V", style: TextStyle(
                          fontSize: 20.0
                      ),),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Text("Frequency: $freq Hz", style: TextStyle(
                          fontSize: 20.0
                      ),),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Text("PF: $pf°", style: TextStyle(
                          fontSize: 20.0
                      ),),
                    ),
                  ],

                ),

              ),
            ),
            Expanded(
              child: Container(
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
                    Center(child: Text("Output Parameters", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),)),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Text("Current: $curr1 mA", style: TextStyle(
                          fontSize: 20.0
                      ),),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Text("Voltage: $vol1 V", style: TextStyle(
                          fontSize: 20.0
                      ),),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Text("Frequency: $freq1 Hz", style: TextStyle(
                          fontSize: 20.0
                      ),),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Text("PF: $pf1°", style: TextStyle(
                          fontSize: 20.0
                      ),),
                    ),
                  ],

                ),

              ),
            ),
          ],
        ),

      );
    }
          },
        ),
      ),
    );

  }
}