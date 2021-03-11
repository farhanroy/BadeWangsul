import 'package:bade_wangsul/src/models/izin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';
import 'detail_izin_page.dart';

class ListIzinPage extends StatelessWidget {
  final CollectionReference _ref =
  FirebaseFirestore.instance.collection(Constants.IZIN_COLLECTION);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: _ref.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                child: Column(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) =>
                                  DetailIzinPage(izin: Izin.fromJson(document.data()),))
                          );
                        },
                        child: _ItemIzinSantri(idSantri: document.data()['idSantri'],)
                    );
                  }).toList(),
                ),
              );
            }
        ),
      ),
    );
  }
}

class _ItemIzinSantri extends StatelessWidget {
  _ItemIzinSantri({Key key, this.idSantri}) : super(key: key);

  final String idSantri;
  final CollectionReference ref = FirebaseFirestore.instance
      .collection(Constants.SANTRI_COLLECTION);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: ref.doc(idSantri).get(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        return new ListTile(
          leading: CircleAvatar(
            backgroundImage:
            NetworkImage("${snapshot.data.data()["imageUrl"]}"),
            backgroundColor: Colors.transparent,
          ),
          title: new Text(snapshot.data.data()['name']),
          subtitle: new Text(snapshot.data.data()['dormitory']),
        );
      },
    );
  }
}
