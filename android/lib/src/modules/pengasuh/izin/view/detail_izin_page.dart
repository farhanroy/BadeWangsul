import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../utils/constants.dart';
import '../../../../models/izin.dart';

class DetailIzinPage extends StatelessWidget {
  final Izin izin;

  const DetailIzinPage({Key key, this.izin}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ref = FirebaseFirestore.instance.collection(Constants.SANTRI_COLLECTION);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87,),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: ref.doc(izin.idSantri).get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: Column(
                children: [
                  Flexible(
                    child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Nama"),
                              Text(snapshot.data.data()["name"]),
                              SizedBox(height: 8.0,),

                              Text("Alamat"),
                              Text(snapshot.data.data()["address"]),
                              SizedBox(height: 8.0,),

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
                  Positioned(
                      bottom: 0,
                      child: Row(
                        children: [
                          RaisedButton(

                              onPressed: (){},
                          )
                        ],
                      )
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
