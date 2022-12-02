import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:energym/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat_screen.dart';
import 'package:energym/screens/industry.dart';

final _firestore = Firestore.instance;

FirebaseUser loggedInUser;

class HomeScreen extends StatefulWidget {
  static String id ="home";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;

  bool isSwitched = false;
  bool isSwitched1 = false;
  bool isSwitched2 = false;


  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void datastream() async {
    await for (var snapshot in _firestore.collection("Energy Readings")
        .snapshots()) {
      for (var reading in snapshot.documents) {
        print(reading.data);
      }
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
                _auth.signOut();
                Navigator.pop(context);
                //Implement logout functionality
              }),
        ],
        title: Text('⚡️  Energy '),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body:SafeArea(
        child: Column(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: (){
                      Navigator.pushNamed(context, ChatScreen.id);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        borderRadius: BorderRadius.all(Radius.circular(1.0)),
                        border: Border.all(
                          color: Colors.white,
                          width: 0.5,
                        )
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 35.0, horizontal: 20.0),
                      child: Center(
                        child: Text("Substation to Transformer", style: TextStyle(
                            fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, IndusScreen.id);
                  },
                  child: Container(
                    decoration: BoxDecoration(

                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(1.0)),
                        border: Border.all(
                          color: Colors.white,
                          width: 0.5,
                        )
                    ),


                          padding: EdgeInsets.symmetric(vertical: 35.0,
                              horizontal: 20.0),
                          child: Center(

                            child: Text("Transformer to Industry & Home", style: TextStyle(
                                fontSize: 19.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
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