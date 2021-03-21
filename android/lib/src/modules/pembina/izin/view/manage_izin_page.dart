import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';
import '../../../../models/pembina.dart';
import 'detail_izin_page.dart';
import 'create_izin_page.dart';

class ManageIzinPage extends StatelessWidget {
  final Pembina pembina;

  const ManageIzinPage({Key key, this.pembina}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => CreateIzinPage(pembina: pembina,))
        ),
      ),
      body: SafeArea(
        child: _ListIzinSantri(),
      ),
    );
  }
}

class _ListIzinSantri extends StatelessWidget {
  final CollectionReference _ref =
  FirebaseFirestore.instance.collection(Constants.IZIN_COLLECTION);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
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
              return _ItemIzinSantri(idSantri: document.data()['idSantri'],);
            }).toList(),
          ),
        );
      }
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
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => DetailIzinPage()
              ));
            },
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


