import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whroomadmin/screens/homeconductor.dart';
import 'package:whroomadmin/services/addLocation.dart';

late String bonnetid;
bool isLiveEnabled= false;
final currentuser= FirebaseAuth.instance.currentUser;
final uid= currentuser!.uid;

class ShareLiveLocationScreen extends StatefulWidget {
  const ShareLiveLocationScreen({Key? key}) : super(key: key);

  @override
  _ShareLiveLocationScreenState createState() => _ShareLiveLocationScreenState();
}

class _ShareLiveLocationScreenState extends State<ShareLiveLocationScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Bus Route'),
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
                SwitchListTile(
                    title: const Text('Share Live Location'),
                    value: isLiveEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        isLiveEnabled = value;
                      });
                    },
                  activeColor: Colors.redAccent,
                    secondary: const Icon(Icons.share_location_outlined),
                  ),
              ],
            ),
            SizedBox(height:20),
            ElevatedButton(
                onPressed: () async{
                  if(isLiveEnabled)
                  {
                    Location location = new Location();

                    bool _serviceEnabled;
                    PermissionStatus _permissionGranted;
                    LocationData _locationData;

                    _serviceEnabled = await location.serviceEnabled();
                    if (!_serviceEnabled) {
                      _serviceEnabled = await location.requestService();
                      if (!_serviceEnabled) {
                        return;
                      }
                    }

                    _permissionGranted = await location.hasPermission();
                    if (_permissionGranted == PermissionStatus.denied) {
                      _permissionGranted = await location.requestPermission();
                      if (_permissionGranted != PermissionStatus.granted) {
                        return;
                      }
                    }
                    _locationData = await location.getLocation();
                    print(_locationData);

                    double latitude= _locationData.latitude!.toDouble();
                    double? longitude= _locationData.longitude!.toDouble();
                    GeoPoint geopoint= GeoPoint(latitude, longitude);

                    LocationClass _location= LocationClass(bonnetid);
                    _location.addLocdetails(bonnetid, uid, geopoint);

                    Navigator.of(context).popAndPushNamed('/homeconductor');


                  }
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

