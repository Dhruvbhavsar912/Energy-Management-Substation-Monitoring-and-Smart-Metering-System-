import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

final _firestore = Firestore.instance;

FirebaseUser loggedInUser;

class HouseCBScreen extends StatefulWidget {
  static String id ="housecircuit";
  @override
  _HouseCBScreenState createState() => _HouseCBScreenState();
}

class _HouseCBScreenState extends State<HouseCBScreen> {
  final _auth = FirebaseAuth.instance;

  bool isSwitched = false;
  bool isSwitched1 = false;

  bool showspinner = false;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    setState(() {
      showspinner = true;
    });
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
      else {
        setState(() {
          showspinner = true;
        });
      }
      setState(() {
        showspinner = false;
      });
    } catch (e) {

    }
  }

//  void datastream() async{
//    await for(var snapshot in _firestore.collection("Energy Readings").snapshots())
//    {
//      for(var reading in snapshot.documents)
//      {
//        print(reading.data);
//      }
//    }
//  }

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
        title: Text('⚡️  Houses'),
        backgroundColor: Colors.lightBlueAccent,
      ),

      backgroundColor: Colors.blueGrey,
      body:  ModalProgressHUD(
        inAsyncCall: showspinner ,
        child: StreamBuilder(
          stream: _firestore.collection("Energy Readings").document(loggedInUser.email).snapshots(),
          builder: (context,snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
    if (snapshot.connectionState == ConnectionState.active ) {
      return SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            Expanded(
              child: Container(
                decoration: BoxDecoration(

                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    border: Border.all(
                      color: Colors.black,
                      width: 0.5,
                    )
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 35.0,
                            horizontal: 20.0),
                        child: Text("House 1", style: TextStyle(
                            fontSize: 18.0
                        ),
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Switch(
                          value: isSwitched1,
                          onChanged: (value) {
                            setState(() {
                              isSwitched1 = value;
                              _firestore.collection('Energy Readings').document(
                                  loggedInUser.email)
                                  .collection("Houses")
                                  .document("House1").updateData({
                                'House 1 Circuit breaker': value,
                              });
                            });
                          },
                          activeTrackColor: Colors.blue,
                          activeColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    border: Border.all(
                      color: Colors.black,
                      width: 0.5,
                    )
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 35.0,
                            horizontal: 20.0),
                        child: Text("House 2",
                          style: TextStyle(
                              fontSize: 18.0
                          ),
                        ),
                      ),
                    ),
//                          SizedBox(
//                            width: 35.0,
//                          ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Switch(
                          value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = value;
                              _firestore.collection('Energy Readings').document(
                                  loggedInUser.email)
                                  .collection("Houses")
                                  .document("House2").updateData({
                                'House2 Circuit breaker': value,
                              });
                            });
                          },
                          activeTrackColor: Colors.blue,
                          activeColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.white,

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