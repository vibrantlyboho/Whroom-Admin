import 'package:cloud_firestore/cloud_firestore.dart';

class Bus{
  FirebaseFirestore _db= FirebaseFirestore.instance;
  late String bonnetid;
  late String from;
  late String to;
  late String stops;
  late String docid;

  Bus(String bid){
    bonnetid= bid;
  }


  Future<void> addBusdetails(String bonnetid, String from, String to, String stops){
    print('in here');
    return _db
        .collection('bus')
        .add({
      'bonnetid': bonnetid,
      'from': from,
      'to': to,
      'stops': stops,
      'isRunning': true,
    })
        .then((value) => print("Bus Details Added"))
        .catchError((error) => print("Failed to add Bus details: $error"));
  }

  Future<void> updateBus(String bonnetid, String from, String to, String stops) async{
    String docid;

    var query = await FirebaseFirestore.instance.collection('bus')
        .where('bonnetid', isEqualTo: bonnetid)
        .get();

    docid= getdocid(query);

    return _db
        .collection('bus')
        .doc(docid)
        .update({'bonnetid': bonnetid, 'from': from, 'to': to, 'stops': stops})
        .then((value) => print("Updated Bus"))
        .catchError((error) => print("Failed to update Bus: $error"));
  }

  getdocid(QuerySnapshot query){
    query.docs.forEach((doc){
      docid= doc.id;
    }
    );
    return docid;
  }


  Future<QuerySnapshot> getAllBusdetails(){
    return _db
        .collection('bus')
        .get();
  }
}
