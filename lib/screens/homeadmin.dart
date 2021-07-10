import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whroomadmin/screens/CreateNewBusScreen.dart';
import 'package:whroomadmin/screens/starting.dart';
import 'package:whroomadmin/screens/viewall.dart';
import 'package:whroomadmin/services/addBus.dart';

final auth= FirebaseAuth.instance;
class HomeAdminScreen extends StatefulWidget {
  const HomeAdminScreen({Key? key}) : super(key: key);

  @override
  _HomeAdminScreenState createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  late String bonnetid, from, to, stops;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Admin'),
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateNewBusScreen()));
                  },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                ),
                child: Text('Create New Bus')),

            ElevatedButton(
                onPressed: () {
                  final Bus bus=Bus('');
                  dynamic busDetails= bus.getAllBusdetails();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewAllBusScreen(busDetails: busDetails)));

                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                ),
                child: Text('View All Buses')),
          ],
        ),
      ),
    );
  }
}
