import 'package:energym/screens/houses/no_of_houses.dart';
import 'package:energym/screens/industries/no_of_industry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:energym/screens/industries/Industry_circuit.dart';
import 'package:energym/screens/houses/house_circuit.dart';

final _firestore = Firestore.instance;

FirebaseUser loggedInUser;

class IndusScreen extends StatefulWidget {
  static String id ="industry";
  @override
  _IndusScreenState createState() => _IndusScreenState();
}

class _IndusScreenState extends State<IndusScreen> {
  final _auth = FirebaseAuth.instance;

  bool isSwitched =false;
  bool isSwitched1 =false;
  bool isSwitched2 =false;
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
        title: Text('⚡️  Energy Readings'),
        backgroundColor: Colors.lightBlueAccent,
      ),

      backgroundColor: Colors.blueGrey,
      body: ModalProgressHUD(
        inAsyncCall: showspinner ,
        child: StreamBuilder(
          stream: _firestore.collection("Energy Readings").document(loggedInUser.email).snapshots(),
          builder: (context,snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
    if (snapshot.connectionState == ConnectionState.active ) {
      final condition = snapshot.data['condition'];
      final temp = snapshot.data['Temperature'];
      return SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, IndustryScreen.id);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      border: Border.all(
                        color: Colors.black,
                        width: 0.5,
                      )
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 35.0, horizontal: 20.0),
                    child: Text(
                      "Energy parameters of Each Industry", style: TextStyle(
                        fontSize: 18.0
                    ),),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, IndustryCBScreen.id);
                },
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
                          child: Text("Circuit breaker", style: TextStyle(
                              fontSize: 18.0
                          ),
                          ),
                        ),
                      ),
//                          SizedBox(
//                            width: 50.0,
//                          ),

                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, HouseScreen.id);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      border: Border.all(
                        color: Colors.black,
                        width: 0.5,
                      )
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 35.0, horizontal: 20.0),
                    child: Text("Energy parameters of House", style: TextStyle(
                        fontSize: 18.0
                    ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, HouseCBScreen.id);
                },
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
                          child: Text("Circuit breaker",
                            style: TextStyle(
                                fontSize: 18.0
                            ),
                          ),
                        ),
                      ),
//                          SizedBox(
//                            width: 35.0,
//                          ),

                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
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





