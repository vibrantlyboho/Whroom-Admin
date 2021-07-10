import 'package:flutter/material.dart';
import 'package:whroomadmin/services/addBus.dart';

class AdminUpdateBusScreen extends StatefulWidget {
  const AdminUpdateBusScreen({Key? key}) : super(key: key);

  @override
  _AdminUpdateBusScreenState createState() => _AdminUpdateBusScreenState();
}

class _AdminUpdateBusScreenState extends State<AdminUpdateBusScreen> {
  late String bonnetid, from, to, stops;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Bus Route(Admin)'),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  padding:EdgeInsets.all(10),
                  child: TextField(
                    onChanged: (value){
                      setState(() {
                        bonnetid = value.trim();
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Bonnet ID',
                      focusedBorder:OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding:EdgeInsets.all(10),
                  child: TextField(
                    onChanged: (value){
                      setState(() {
                        from = value.trim();
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'From',
                      focusedBorder:OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding:EdgeInsets.all(10),
                  child: TextField(
                    onChanged: (value){
                      setState(() {
                        to = value.trim();
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'To',
                      focusedBorder:OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding:EdgeInsets.all(10),
                  child: TextField(
                    onChanged: (value){
                      setState(() {
                        stops = value.trim();
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Stops',
                      focusedBorder:OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height:20),
            ElevatedButton(
                onPressed: (){
                  print('$bonnetid, $from, $to, $stops');
                  Bus bus= Bus(bonnetid);
                  //print(bus);
                  bus.updateBus(bonnetid, from, to, stops);
                  Navigator.of(context).popAndPushNamed('/homeadmin');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent),),
                child: Text('Submit',style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)),

          ],
        ),
      ),
    );
  }
}
