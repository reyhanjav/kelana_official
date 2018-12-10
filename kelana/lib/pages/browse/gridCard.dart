import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:kelana/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kelana/pages/browse/deskripsi.dart';
import 'package:intl/intl.dart';



class RenderCards extends StatelessWidget {
  final formatter = new NumberFormat("Rp ###,###.###", "pt-br");
  final List<DocumentSnapshot> documents;

  RenderCards({this.documents});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
                    new SliverToBoxAdapter(
                    child:  new AspectRatio(
                          aspectRatio: 30 / 20,
                          child: new Container(
                            decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(30.0),
                            topRight: const Radius.circular(30.0)),
                            image: new DecorationImage(
                              fit: BoxFit.cover,
                              image: new AssetImage('assets/wakatobi1.jpg')
                              )
                             ),
                            child: new Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Row(
                  children: <Widget>[
                          new Padding(
                               padding: new EdgeInsets.only(left: 24.0,bottom:10.0),
                               child: new Text('Featured',style: new TextStyle(color: Colors.white,fontSize: 11.0,fontWeight: FontWeight.bold),),
                          )]),
                new Row(
                  children: <Widget>[
                          new Padding(
                               padding: new EdgeInsets.only(left: 24.0),
                               child: new Text('Explore the Blue ',style: new TextStyle(color: Colors.white,fontSize: 32.0,fontWeight: FontWeight.bold)),
                          )]),
                new Row(
                  children: <Widget>[                          
                          new Padding(
                               padding: new EdgeInsets.only(left: 24.0,top:6.0),
                               child: new Text('At wakatobi island ',style: new TextStyle(color: Colors.white,fontSize: 13.0)),
                          )]),
                             new Container(
                               padding: new EdgeInsets.all(10.0),
                               width: 150.0,
                               child: new FlatButton(
                                onPressed: () {
                                Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => new Home(

                                          )));
                            },
                                child: Text(
                                'Check Now',
                                style: TextStyle(fontSize: 12.0),
                                  ),
                                color: themeColor,
                                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                highlightColor: Color(0xffff7f7f),
                                splashColor: Colors.transparent,
                                textColor: primaryColor,
                                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0)),
                             ),
              
                      ]
            ),
                           ),
                         ),
          ),
          SliverToBoxAdapter(
            child: new Padding(
                               padding: new EdgeInsets.only(left:15.0,top: 24.0,bottom:10.0),
                               child: new Text('Categories',style: new TextStyle(color: Colors.black,fontSize: 16.0),),
                          )
          ),
          SliverToBoxAdapter(
            child: new Container(
              height: 120.0,
              child: ListView(
                padding: EdgeInsets.only(right: 25.0),
                scrollDirection: Axis.horizontal,
                children: <Widget>[
              new Padding(
              padding: new EdgeInsets.only(left: 15.0,right: 10.0),
              child: Container(
                width: 200.0,
                decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(15.0),
                            image: new DecorationImage(
                              fit: BoxFit.cover,
                              image: new AssetImage('assets/land.jpg'),
                              )
                             ),
                child: Center(
                  child: new Text('Land',style: new TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),),
                )
              ),
              ),
              new Padding(
              padding: new EdgeInsets.only(left:10.0,right: 10.0),
              child: Container(
                width: 200.0,
                decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(15.0),
                            image: new DecorationImage(
                              fit: BoxFit.cover,
                              image: new AssetImage('assets/water.jpg'),
                              )
                             ),
                child: Center(
                  child: new Text('Water',style: new TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),),
                )
              ),
              ),
              new Padding(
              padding: new EdgeInsets.only(left:10.0,right: 10.0),
              child: Container(
                width: 200.0,
                decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(15.0),
                            image: new DecorationImage(
                              fit: BoxFit.cover,
                              image: new AssetImage('assets/culture.jpg'),
                              )
                             ),
                child: Center(
                  child: new Text('Culture',style: new TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),),
                )
              ),
              ),
            ],
              ),
            ),
                          
          ),
          SliverToBoxAdapter(
            child: new Padding(
                               padding: new EdgeInsets.only(left:15.0,top: 24.0,bottom:10.0),
                               child: new Text('Recently',style: new TextStyle(color: Colors.black,fontSize: 16.0),),
                          )
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 0.0,
              childAspectRatio: 0.75,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            String idTempat = documents[index].data['idTempat'];
            String nama = documents[index].data['nama'].toString();
            int harga = documents[index].data['harga'];
            int countReview = documents[index].data['countReview'];
            int reviewStar = documents[index].data['reviewStar'];
            String fotoThumb = documents[index].data['fotoThumb'].toString();

              return  new Padding(
                padding: new EdgeInsets.only(left:12.0,right:12.0),
                child:new Card(
                    elevation: 0.0,
                    child: new Column(
                      children: <Widget>[
                        new AspectRatio(
                          aspectRatio: 300 / 200,
                          child: new Container(
                            decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(15.0),
                            image: new DecorationImage(
                              fit: BoxFit.cover,
                              alignment: FractionalOffset.topCenter,
                              image: new NetworkImage(fotoThumb),
                              )
                             ),
                           ),
                         ),
                        new Padding(
                          padding: new EdgeInsets.only(top:4.0),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                             new Padding(
                               padding: new EdgeInsets.only(top:4.0,bottom: 4.0),
                               child: new Text(nama,style: new TextStyle(fontSize: 15.0),),
                             ),
                             new Padding(
                               padding: new EdgeInsets.only(top:4.0,bottom:4.0),
                               child: new Text(formatter.format(harga),style: new TextStyle(fontSize: 14.0),),
                             ),
                              new Padding(
                               padding: new EdgeInsets.only(top:4.0,bottom: 4.0),
                               child: new Row(
                                 children: <Widget>[
                                 SmoothStarRating(
                                 rating: reviewStar.toDouble(),
                                 size: 12,
                                 starCount: 5,
                                 color: primaryColor,
                                 borderColor: themeColor,
                                  ),
                                new Padding(
                               padding: new EdgeInsets.all(3.0),
                               child: new Text(' $countReview reviews',style: new TextStyle(fontSize: 10.0),),
                             ),
                                 ]
                                  
                             ),
                              ),


                            ],
                          )
                        )
                      ],
                    ),
                  ),
              );
              },
              childCount: documents.length,
            ),
          ),
        ],
      ),
    );
  }
}



