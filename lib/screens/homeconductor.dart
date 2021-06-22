import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whroomadmin/screens/updatebus.dart';

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
                onPressed: (){

                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                ),
                child: Text('Share Live Location')),
          ],
        ),
      ),
    );
  }
}
