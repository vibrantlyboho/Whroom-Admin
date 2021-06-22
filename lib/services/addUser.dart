import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUser {
  final String email;
  final String password;
  final String uid;
  final bool isConductor;
  final bool isAdmin;

  AddUser(this.email, this.password, this.uid, this.isConductor, this.isAdmin);

  CollectionReference users = FirebaseFirestore.instance.collection('user');

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
      'uid': uid,
      'email': email,
      'isConductor': isConductor,
      'isAdmin': isAdmin,
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }


}