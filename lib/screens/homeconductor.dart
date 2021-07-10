import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whroomadmin/screens/sharelivelocation.dart';
import 'package:whroomadmin/screens/starting.dart';
import 'package:whroomadmin/screens/updatebus.dart';
import 'package:whroomadmin/screens/viewall.dart';
import 'package:whroomadmin/services/addBus.dart';
import 'package:whroomadmin/services/addLocation.dart';

final auth= FirebaseAuth.instance;
final currentuser= FirebaseAuth.instance.currentUser;
final uid= currentuser!.uid;

class HomeConductorScreen extends StatefulWidget {
  const HomeConductorScreen({Key? key}) : super(key: key);

  @override
  _HomeConductorScreenState createState() => _HomeConductorScreenState();
}

class _HomeConductorScreenState extends State<HomeConductorScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Conductor'),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    StartingScreen()), (Route<dynamic> route) => false);
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => UpdateBusScreen()));

                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                ),
                child: Text('Update Bus Route')),

            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShareLiveLocationScreen()));
                  },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                ),
                child: Text('Share Live Location')),

            SizedBox(height: 30,),
            Text('LIVE LOCATION SHARING', style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 25, color: Colors.redAccent)),
            SizedBox(height: 10,),
            GetLiveLocation(),




          ],
        ),
      ),
    );
  }
}


GetLiveLocation(){

 final LocationClass locationClass= LocationClass.user(uid);
 dynamic LocDetails= locationClass.getLocdetails(uid);
 print(LocDetails.toString());
 return Text('$LocDetails');

}