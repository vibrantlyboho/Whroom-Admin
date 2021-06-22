import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whroomadmin/screens/homeconductor.dart';
import 'package:whroomadmin/services/addUser.dart';

class LoginConductorScreen extends StatefulWidget {
  const LoginConductorScreen({Key? key}) : super(key: key);

  @override
  _LoginConductorScreenState createState() => _LoginConductorScreenState();
}

class _LoginConductorScreenState extends State<LoginConductorScreen> {
  String _email='', _password='';
  bool isConductor= true;
  final auth= FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conductor Login'),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: 'Email'
              ),
              onChanged: (value){
                setState(() {
                  _email = value.trim();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                  hintText: 'Password'
              ),
              onChanged: (value){
                setState(() {
                  _password = value.trim();
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //Sign In Button
              ElevatedButton(
                  onPressed: () async{
                    try{
                      UserCredential currentuser= await auth.signInWithEmailAndPassword(email: _email, password: _password);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeConductorScreen()));
                    } on FirebaseAuthException catch(e){
                      print('FAILED with error code: ${e.code}');
                      print(e.message);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                  ),
                  child: Text('Sign in')),
              //Sign Up Button
              ElevatedButton(
                  onPressed: () async{
                    try{
                      UserCredential currentuser= await auth.createUserWithEmailAndPassword(email: _email, password: _password);
                      //getting user uid from firebaseauth, storing it in uid and creating a new user in user collection
                      String _uid= currentuser.user!.uid;
                      AddUser user= new AddUser(_email, _password, _uid, isConductor, false);
                      user.addUser();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeConductorScreen()));

                    } on FirebaseAuthException catch(e){
                      print('FAILED with error code: ${e.code}');
                      print(e.message);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                  ),
                  child: Text('Sign Up')),
            ],
          )
        ],
      ),
    );
  }
}
