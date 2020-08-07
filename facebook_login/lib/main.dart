import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

void main()=> runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;
  FacebookLogin fb = FacebookLogin();
  Future<FacebookLogin> signInFB() async{
    final FacebookLoginResult result = await fb.logIn(['email']);
    final token = result.accessToken.token;
    final graph = await http.get('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
    final Map<String, dynamic> profile = jsonDecode(graph.body);
    print(profile);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Center(
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Text("Facebook Login",style: TextStyle(
                    color: Colors.black,
                    fontSize: 50,
                    fontWeight: FontWeight.bold
                  ),),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: double.maxFinite,
                child: Center(
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text("FaceBook Login",style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)
                    ),
                    onPressed: () {
                      signInFB().then((value) => print("logged  in"));
                    },

                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}

