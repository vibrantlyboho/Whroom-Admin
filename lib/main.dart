import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whroomadmin/screens/homeconductor.dart';
import 'package:whroomadmin/screens/loginadmin.dart';
import 'package:whroomadmin/screens/loginconductor.dart';
import 'package:whroomadmin/screens/starting.dart';
import 'package:whroomadmin/screens/updatebus.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => StartingScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/loginconductor': (context) => LoginConductorScreen(),
        '/third' : (context) => LoginAdminScreen(),
        '/homeconductor': (context) => HomeConductorScreen(),
        'updatebusroute': (context) => UpdateBusScreen(),



        }
    );
  }
}
