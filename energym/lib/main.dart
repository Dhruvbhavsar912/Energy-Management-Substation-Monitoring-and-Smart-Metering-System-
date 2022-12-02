import 'package:energym/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:energym/screens/welcome_screen.dart';
import 'package:energym/screens/login_screen.dart';
import 'package:energym/screens/registration_screen.dart';
import 'package:energym/screens/chat_screen.dart';
import 'package:energym/screens/industry.dart';
import 'package:energym/screens/input.dart';
import 'package:energym/screens/output.dart';
import 'screens/registration_screen.dart';
import 'screens/industries/no_of_industry.dart';
import 'screens/houses/no_of_houses.dart';
import 'screens/industries/Industry_circuit.dart';
import 'screens/houses/house_circuit.dart';
import 'package:energym/screens/houses/house1.dart';
import 'package:energym/screens/houses/house2.dart';
import 'package:energym/screens/industries/industry1.dart';
import 'package:energym/screens/industries/industry2.dart';
import 'package:energym/screens/industries/industry3.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id : (context) => LoginScreen(),
        RegistrationScreen.id : (context) => RegistrationScreen(),
		    ChatScreen.id : (context) => ChatScreen(),
        HomeScreen.id : (context) => HomeScreen(),
        IndusScreen.id : (context) => IndusScreen(),
        InputScreen.id :(context) => InputScreen(),
        OutputScreen.id :(context) => OutputScreen(),
        IndustryScreen.id : (context) => IndustryScreen(),
        IndustryCBScreen.id : (context) => IndustryCBScreen(),
        HouseScreen.id : (context) => HouseScreen(),
        HouseCBScreen.id : (context) => HouseCBScreen(),
        House1Screen.id : (context) => House1Screen(),
        House2Screen.id : (context) => House2Screen(),
        Industry1Screen.id : (context) => Industry1Screen(),
        Industry2Screen.id : (context) => Industry2Screen(),
        Industry3Screen.id : (context) => Industry3Screen(),

      },

    );
  }
}
