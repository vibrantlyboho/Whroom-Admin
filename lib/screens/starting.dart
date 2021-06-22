import 'package:flutter/material.dart';

import 'loginadmin.dart';
import 'loginconductor.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({Key? key}) : super(key: key);

  @override
  _StartingScreenState createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                'Login or Sign Up as',style: TextStyle(fontSize:25,fontWeight: FontWeight.bold, color: Colors.redAccent)
            ),
            SizedBox(height:50),
            Column(
              children: <Widget>[
                ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginConductorScreen()));
                  },
                  child: Text('Conductor',style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                  ),
                ),
                SizedBox(height:30),
                ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginAdminScreen()));
                    },
                    child: Text('Admin',style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
