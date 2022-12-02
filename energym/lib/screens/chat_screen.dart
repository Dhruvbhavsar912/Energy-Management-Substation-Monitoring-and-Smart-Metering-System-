import 'package:energym/screens/input.dart';
import 'package:energym/screens/output.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class ChatScreen extends StatefulWidget {
  static String id ="chat";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
        inAsyncCall: showspinner,
        child: StreamBuilder(
          stream:  _firestore.collection("Energy Readings").document(loggedInUser.email).snapshots(),
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
                          Navigator.pushNamed(context, InputScreen.id);
                        },

                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(15.0)),
                              border: Border.all(
                                color: Colors.black,
                                width: 0.5,
                              )
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 35.0, horizontal: 20.0),
                            child: Text("Input Parameters", style: TextStyle(
                                fontSize: 18.0
                            ),),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, OutputScreen.id);
                        },
                        child: Container(
                          decoration: BoxDecoration(

                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(15.0)),
                              border: Border.all(
                                color: Colors.black,
                                width: 0.5,
                              )
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 35.0, horizontal: 20.0),
                            child: Text("Output Parameters", style: TextStyle(
                                fontSize: 18.0
                            ),),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(

                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(15.0)),
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
                                child: Text(
                                  "Transformer Condition", style: TextStyle(
                                    fontSize: 18.0
                                ),
                                ),
                              ),
                            ),
//                          SizedBox(
//                            width: 40.0,
//                          ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text("$condition", style: TextStyle(
                                  fontSize: 18.0,
                                  color: condition == 'Healthy' ? Colors
                                      .lightGreen : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(

                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(15.0)),
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
                                child: Text("Temperature", style: TextStyle(
                                    fontSize: 18.0
                                ),
                                ),
                              ),
                            ),
//                          SizedBox(
//                            width: 30.0,
//                          ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text("$temp°", style: TextStyle(
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(

                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(15.0)),
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
                                child: Text(
                                  "Input Circuit breaker", style: TextStyle(
                                    fontSize: 18.0
                                ),
                                ),
                              ),
                            ),
//                          SizedBox(
//                            width: 50.0,
//                          ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Switch(
                                  value: isSwitched1,
                                  onChanged: (value) {
                                    setState(() {
                                      isSwitched1 = value;
                                      _firestore.collection("Energy Readings")
                                          .document(loggedInUser.email)
                                          .updateData({
                                        'Input Circuit breaker': value,
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
                            borderRadius: BorderRadius.all(
                                Radius.circular(15.0)),
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
                                child: Text("Output Circuit breaker",
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
                                  value: isSwitched2,
                                  onChanged: (value) {
                                    setState(() {
                                      isSwitched2 = value;
                                      _firestore.collection("Energy Readings")
                                          .document(loggedInUser.email)
                                          .updateData({
                                        'Output Circuit breaker': value,
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

                  ],
                ),

              );

            }
            else{
              return Center(
                child: Text("You need to set profile"),
              );
            }
          },
        ),
      ),
    );
  }
}





