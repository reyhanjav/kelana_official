import 'package:flutter/material.dart';
import 'package:kelana/pages/browse/gridCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kelana/const.dart';

class BrowsePages extends StatefulWidget {
  @override
  _BrowsePagesState createState() => _BrowsePagesState();
}

class _BrowsePagesState extends State<BrowsePages> {
  

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        backgroundColor: Colors.white,
        body: new NestedScrollView(
    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        new SliverAppBar(
          title: new Text('Browse',style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
          backgroundColor: themeColor,
          snap: true,
          floating: true,
          forceElevated: innerBoxIsScrolled,
          actions: <Widget>[
          IconButton(
              color: primaryColor,
              icon: Icon(Icons.filter_list),
              onPressed: () {
              },
            ),
          IconButton(
            color: primaryColor,
              icon: Icon(Icons.bookmark),
              onPressed: () {
              },
            ),  
        ],
        ),
      ];
    },
    body: new StreamBuilder(
        stream: Firestore.instance.collection('tempatWisata').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator(backgroundColor: Colors.white,);
          return RenderCards(documents: snapshot.data.documents);
        },
      ),
  ),
      ),
    );
  }
}



