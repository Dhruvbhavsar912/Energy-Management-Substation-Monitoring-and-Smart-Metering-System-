import 'package:energym/screens/houses/house1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:energym/screens/houses/house2.dart';

final _firestore = Firestore.instance;

FirebaseUser loggedInUser;

class HouseScreen extends StatefulWidget {
  static String id ="houses";
  @override
  _HouseScreenState createState() => _HouseScreenState();
}

class _HouseScreenState extends State<HouseScreen> {
  final _auth = FirebaseAuth.instance;

  bool isSwitched = false;
  bool isSwitched1 = false;
  bool isSwitched2 = false;
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
      body: ModalProgressHUD(
        inAsyncCall: showspinner,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, House1Screen.id);
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
                      child: Text("House 1", style: TextStyle(
                          fontSize: 18.0
                      ),),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, House2Screen.id);
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
                            child: Text("House 2", style: TextStyle(
                                fontSize: 18.0
                            ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Expanded(
                flex: 4,
                child: Container(
                  color: Colors.white,

                ),
              ),
            ],


          ),),
      ),
    );
  }
}