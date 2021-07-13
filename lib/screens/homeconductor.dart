import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  final LocationClass locationClass= LocationClass.user(uid);

  @override
  Widget build(BuildContext context) {
    dynamic LocDetails= locationClass.getLocdetails(uid);
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
        child: ListView(
            padding: EdgeInsets.fromLTRB(10, 40, 10, 20),
            children: <Widget>[
              Column(
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
                  Text('Tap to stop sharing location', style: TextStyle(fontSize: 15, color: Colors.grey[700]),),
                  SizedBox(height: 10,),
                  //displaying Live Location
                  GetLiveLocation(),
                ],
              ),

            ],
        ),
      ),
    );
  }
}


class GetLiveLocation extends StatefulWidget {
  const GetLiveLocation({Key? key}) : super(key: key);

  @override
  _GetLiveLocationState createState() => _GetLiveLocationState();
}

class _GetLiveLocationState extends State<GetLiveLocation> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('location').where("uid", isEqualTo: uid).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container(
          height: 600,
            child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context,index){
                  return Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            primary: Colors.redAccent
                        ),
                        child: Container(
                          width: 200,
                          height: 200,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Text(
                            snapshot.data!.docs[index].get('bonnetid'),
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        onPressed: () {
                          String id= snapshot.data!.docs[index].id;
                          FirebaseFirestore.instance.collection('location').doc(id).delete().then((value) => print("Stopped Sharing Location"))
                              .catchError((error) => print("Failed to stop sharing: $error"));
                        },
                      ),
                    ),
                  );
                }),
        );
      }
    );
   }
}

