import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FourthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cloud FireStore Example'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Firestore.instance
                  .runTransaction((Transaction transaction) async {
                CollectionReference reference =
                    Firestore.instance.collection('tempatWisata');

                await reference
                    .add({"nama": "", "editing": false, "harga": 0});
              });
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('tempatWisata').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return FirestoreListView(documents: snapshot.data.documents);
        },
      ),
    );
  }
}

class FirestoreListView extends StatelessWidget {
  final List<DocumentSnapshot> documents;

  FirestoreListView({this.documents});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: documents.length,
      itemExtent: 110.0,
      itemBuilder: (BuildContext context, int index) {
        String nama = documents[index].data['nama'].toString();
        int harga = documents[index].data['harga'];
        return ListTile(
            title: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: Colors.white),
              ),
              padding: EdgeInsets.all(5.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: !documents[index].data['editing']
                        ? Text(nama)
                        : TextFormField(
                            initialValue: nama,
                            onFieldSubmitted: (String item) {
                              Firestore.instance
                                  .runTransaction((transaction) async {
                                DocumentSnapshot snapshot = await transaction
                                    .get(documents[index].reference);

                                await transaction.update(
                                    snapshot.reference, {'nama': item});

                                await transaction.update(snapshot.reference,
                                    {"editing": !snapshot['editing']});
                              });
                            },
                          ),
                  ),
                  Text("$harga"),
                  Column(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Firestore.instance
                              .runTransaction((Transaction transaction) async {
                            DocumentSnapshot snapshot = await transaction
                                .get(documents[index].reference);
                            await transaction.update(snapshot.reference,
                                {'harga': snapshot['harga'] + 1});
                          });
                        },
                        icon: Icon(Icons.arrow_upward),
                      ),
                      IconButton(
                        onPressed: () {
                          Firestore.instance
                              .runTransaction((Transaction transaction) async {
                            DocumentSnapshot snapshot = await transaction
                                .get(documents[index].reference);
                            await transaction.update(snapshot.reference,
                                {'harga': snapshot['harga'] - 1});
                          });
                        },
                        icon: Icon(Icons.arrow_downward),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      Firestore.instance.runTransaction((transaction) async {
                        DocumentSnapshot snapshot =
                            await transaction.get(documents[index].reference);
                        await transaction.delete(snapshot.reference);
                      });
                    },
                  )
                ],
              ),
            ),
            onTap: () => Firestore.instance
                    .runTransaction((Transaction transaction) async {
                  DocumentSnapshot snapshot =
                      await transaction.get(documents[index].reference);

                  await transaction.update(
                      snapshot.reference, {"editing": !snapshot["editing"]});
                }));
      },
    );
  }
}