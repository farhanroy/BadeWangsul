import 'package:bade_wangsul/src/modules/keamanan/izin/view/detail_santri_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';

class MonitorSantriPage extends StatefulWidget {
  @override
  _MonitorSantriPageState createState() => _MonitorSantriPageState();
}

class _MonitorSantriPageState extends State<MonitorSantriPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: _ListIzinSantri()
      ),
    );
  }
}

class _ListIzinSantri extends StatelessWidget {
  final ref = FirebaseFirestore.instance
      .collection(Constants.IZIN_COLLECTION)
      .where("isKembali", isEqualTo: true);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: ref.snapshots(),
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
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => DetailSantriPage(idSantri: snapshot.data.data()["id"],)
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
