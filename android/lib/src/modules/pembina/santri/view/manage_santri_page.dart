import 'package:bade_wangsul/src/modules/pembina/izin/izin.dart';
import 'package:bade_wangsul/src/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ManageSantriPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection(Constants.SANTRI_COLLECTION);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, "/pembina/santri/create");
        },
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: users.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return _content(context, snapshot.data);
        },
      ),
    );
  }

  Widget _content(BuildContext context, QuerySnapshot snapshot) {
    return ListView(
        children: snapshot.docs.map((DocumentSnapshot document) {
          return new ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => DetailSantriPage(documentID: document.id,)
              ));
            },
            leading: CircleAvatar(
              backgroundImage:
              NetworkImage("${document.data()["imageUrl"]}"),
              backgroundColor: Colors.transparent,
            ),
            title: new Text(document.data()['name']),
            subtitle: new Text(document.data()['dormitory']),
          );
        }).toList(),

    );
  }
}
