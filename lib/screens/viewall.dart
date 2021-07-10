import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whroomadmin/screens/adminupdatebus.dart';
import 'package:whroomadmin/screens/starting.dart';
import 'package:whroomadmin/screens/updatebus.dart';

final auth= FirebaseAuth.instance;

class ViewAllBusScreen extends StatefulWidget {
  Future<QuerySnapshot> busDetails;

  ViewAllBusScreen({Key? key, required this.busDetails}) : super(key: key);

  @override
  _ViewAllBusScreenState createState() => _ViewAllBusScreenState();
}

class _ViewAllBusScreenState extends State<ViewAllBusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View all Buses'),
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
      body: FutureBuilder(
        future: widget.busDetails,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasData){

            return Container(
              height: 600,
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,index){
                    return Container(
                      height: 100,
                      child: Card(
                        child: new InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminUpdateBusScreen()));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Icon(Icons.directions_bus),
                                  Text(snapshot.data!.docs[index].get('bonnetid'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.redAccent),),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.flag),
                                  Text(snapshot.data!.docs[index].get('from'), style: TextStyle(fontSize: 20, color: Colors.grey[700]),),
                                  SizedBox(width: 20,),
                                  Icon(Icons.pin_drop),
                                  Text(snapshot.data!.docs[index].get('to'), style: TextStyle(fontSize: 20, color: Colors.grey[700]),),
                                  //Text(snapshot.data!.docs[index].get('stops'), style: TextStyle(fontSize: 20, color: Colors.grey[700]),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            );
          }
          else if(snapshot.hasError){
            return Text(snapshot.error.toString());
          }
          else{
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
