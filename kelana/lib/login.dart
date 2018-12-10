import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kelana/const.dart';
import 'package:kelana/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: new ThemeData(
        primaryColor: themeColor,
      ),
      home: LoginScreen(title: 'Login'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  LoginScreenState createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences prefs;

  bool isLoading = false;
  bool isLoggedIn = false;
  FirebaseUser currentUser;

  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    this.setState(() {
      isLoading = true;
    });

    prefs = await SharedPreferences.getInstance();

    isLoggedIn = await googleSignIn.isSignedIn();
    if (isLoggedIn) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MainScreen(currentUserId: prefs.getString('id'))),
      );
    }

    this.setState(() {
      isLoading = false;
    });
  }

  Future<Null> handleSignIn() async {
    prefs = await SharedPreferences.getInstance();

    this.setState(() {
      isLoading = true;
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    FirebaseUser firebaseUser = await firebaseAuth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    if (firebaseUser != null) {
      // Check is already sign up
      final QuerySnapshot result = await Firestore.instance
          .collection('tourist')
          .where('id', isEqualTo: firebaseUser.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
        // Update data to server if new user
        Firestore.instance
            .collection('tourist')
            .document(firebaseUser.uid)
            .setData({
          'nickname': firebaseUser.displayName,
          'photoUrl': firebaseUser.photoUrl,
          'id': firebaseUser.uid
        });

        // Write data to local
        currentUser = firebaseUser;
        await prefs.setString('id', currentUser.uid);
        await prefs.setString('nickname', currentUser.displayName);
        await prefs.setString('photoUrl', currentUser.photoUrl);
      } else {
        // Write data to local
        await prefs.setString('id', documents[0]['id']);
        await prefs.setString('nickname', documents[0]['nickname']);
        await prefs.setString('photoUrl', documents[0]['photoUrl']);
        await prefs.setString('aboutMe', documents[0]['aboutMe']);
      }
      Fluttertoast.showToast(msg: "Sign in success");
      this.setState(() {
        isLoading = false;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MainScreen(
                  currentUserId: firebaseUser.uid,
                )),
      );
    } else {
      Fluttertoast.showToast(msg: "Sign in fail");
      this.setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            new Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage('assets/bali.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    ),
            new Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                          new Padding(
                               padding: new EdgeInsets.only(left: 24.0),
                               child: new RichText(
                                textAlign: TextAlign.left,
                                text: new TextSpan(
                                  style: new TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor:primaryColor,
                                  fontSize: 50.0,
                                  color: Colors.white,
                                  ),
                                  children: <TextSpan>[
                                  new TextSpan(text: 'BALI', style: new TextStyle(fontWeight: FontWeight.bold)),
                                  new TextSpan(text: '.', style: new TextStyle(color:primaryColor,fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                          ),
                          new Padding(
                               padding: new EdgeInsets.only(left: 24.0),
                               child: new Text('Bali is one of favorite place in indonesia',style: new TextStyle(color: Colors.white,fontSize: 11.0,fontWeight: FontWeight.bold),),
                          ),
                          new Padding(
                               padding: new EdgeInsets.only(left: 24.0),
                               child: new Text('Have you going here before?',style: new TextStyle(color: Colors.white,fontSize: 11.0,fontWeight: FontWeight.bold),),
                          ),
                new Card(
                    margin: EdgeInsets.all(24.0),
                    elevation: 8.0,
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(24.0)),
                    child: new Column(
                      children: <Widget>[
                        new Padding(
                          padding: new EdgeInsets.all(16.0),
                          child: new Column(
                            children: <Widget>[
                              new AspectRatio(
                          aspectRatio: 20 / 1,
                          child: new Container(
                            decoration: new BoxDecoration(
                            image: new DecorationImage(
                              fit: BoxFit.fitHeight,
                              alignment: FractionalOffset.topCenter,
                              image: new AssetImage('assets/kelana.png'),
                              )
                             ),
                           ),
                         ),
                             new Padding(
                               padding: new EdgeInsets.all(16.0),
                               child: new FlatButton(
                                onPressed: handleSignIn,
                                child: Text(
                                'SIGN IN WITH GOOGLE',
                                style: TextStyle(fontSize: 12.0),
                                  ),
                                color: primaryColor,
                                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                highlightColor: Color(0xffff7f7f),
                                splashColor: Colors.transparent,
                                textColor: Colors.white,
                                padding: EdgeInsets.fromLTRB(40.0, 15.0, 40.0, 15.0)),
                             ),
                              new Padding(
                               padding: new EdgeInsets.all(4.0),
                               child: new RichText(
                                textAlign: TextAlign.center,
                                text: new TextSpan(
                                  style: new TextStyle(
                                  fontSize: 11.0,
                                  color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                  new TextSpan(text: 'By using Kelana, you are agree to our '),
                                  new TextSpan(text: 'Terms of Service ', style: new TextStyle(fontWeight: FontWeight.bold)),
                                  new TextSpan(text: 'and '),
                                  new TextSpan(text: 'Privacy Policy', style: new TextStyle(fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                             ),

                            ],
                          )
                        )
                      ],
                    ),
                  ),
              
                      ]
            ),

            // Loading
            Positioned(
              child: isLoading
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                        ),
                      ),
                      color: Colors.white.withOpacity(0.8),
                    )
                  : Container(),
            ),
          ],
        ));
  }
}
