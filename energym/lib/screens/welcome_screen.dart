import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:energym/components/buttons.dart';

class WelcomeScreen extends StatefulWidget {
  static String id="wel";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{

  AnimationController controller;
  Animation animation;
  Animation animation1;


  @override
  void initState() {

    super.initState();
    controller= AnimationController(
      duration: Duration(seconds: 1),

      vsync: this,
    );
    animation =CurvedAnimation(parent: controller,curve: Curves.decelerate);
    animation1 = ColorTween (begin: Colors.blueGrey,end: Colors.white).animate(controller);
    controller.forward();
    controller.addListener((){
      setState(() {

      });
      print(animation.value);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation1.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag:'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: animation.value*60,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  text: ['Energy Management'],
                  textStyle: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Roundedbutton(colour: Colors.lightBlueAccent,txt: 'Log In',onpress: () {
              //Go to registration screen.
              Navigator.pushNamed(context,LoginScreen.id);
            },),
            Roundedbutton(colour: Colors.lightBlueAccent,txt: 'Register',onpress: () {
              //Go to registration screen.
              Navigator.pushNamed(context,RegistrationScreen.id);
            },),
          ],
        ),
      ),
    );
  }
}
