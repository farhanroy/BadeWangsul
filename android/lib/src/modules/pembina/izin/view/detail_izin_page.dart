import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../models/izin.dart';
import '../../../../utils/constants.dart';

class DetailIzinPage extends StatelessWidget {
  const DetailIzinPage({Key key, this.idIzin}) : super(key: key);
  
  final String idIzin;
  
  @override
  Widget build(BuildContext context) {
    final ref = FirebaseFirestore.instance.collection(Constants.IZIN_COLLECTION);
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
          future: ref.doc(idIzin).get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              print(snapshot.data.data());
              return _DetailIzinCard(snapshot: snapshot.data);
            }

            return Center(child: CircularProgressIndicator(),);
          }
      ),
    );
  }
}

class _DetailIzinCard extends StatelessWidget {
  const _DetailIzinCard({Key key, this.snapshot}) : super(key: key);
  final DocumentSnapshot snapshot;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final izin = Izin.fromJson(snapshot.data());
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: width,
        child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Tujuan pulang"),
                  Text(izin.title),
                  SizedBox(height: 8.0,),

                  Text("Detail kepulangan"),
                  Text(izin.information),
                  SizedBox(height: 8.0,),

                  Text("Dari tanggal"),
                  Text(izin.fromDate.toString()),
                  SizedBox(height: 8.0,),

                  Text("Sampai tanggal"),
                  Text(izin.toDate.toString()),
                  SizedBox(height: 8.0,),
                ],
              ),
            )
        ),
      ),
    );
  }
}

