import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';

class LocationClass{
  FirebaseFirestore _db= FirebaseFirestore.instance;
  late String bonnetid;
  late String uid;
  late GeoPoint geopoint;

  LocationClass(String bid){
    bonnetid= bid;
  }

  LocationClass.user(String uid){
    uid= uid;
  }

  Future<void> addLocdetails(String bonnetid, String uid, GeoPoint geopoint){
    print('in here');
    return _db
        .collection('location')
        .add({
      'bonnetid': bonnetid,
      'uid': uid,
      'geopoint': geopoint,

    })
        .then((value) => print("Location Details Added"))
        .catchError((error) => print("Failed to add Location details: $error"));
  }


  Future<QuerySnapshot> getLocdetails(String uid){
    return _db
        .collection('location')
        .where("uid", isEqualTo: uid)
        .get();
  }

}