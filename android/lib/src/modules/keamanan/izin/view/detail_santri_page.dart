import 'package:bade_wangsul/src/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailSantriPage extends StatelessWidget {

  final String? idSantri;

  const DetailSantriPage({Key? key, this.idSantri}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference santri = FirebaseFirestore
        .instance.collection(Constants.SANTRI_COLLECTION);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.arrowLeft),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.edit),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<DocumentSnapshot>(
            future: santri.doc(idSantri).get(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                return _content(snapshot.data!);
              }

              return Center(child: CircularProgressIndicator(),);
            }
        ),
      ),
    );
  }

  Widget _content(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data()!;
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 42,),
          Center(
            child: CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage("${data["imageUrl"]}"),
            ),
          ),
          SizedBox(height: 32,),

          Text("Name"),
          Text(data['name']),
          SizedBox(height: 16,),

          Text("Umur"),
          Text(data['age']),
          SizedBox(height: 16,),

          Text("Alamat"),
          Text(data['address']),
          SizedBox(height: 16,),

          Text("Asrama"),
          Text(data['dormitory']),
          SizedBox(height: 16,),

          Text("Tanggal lahir"),
          Text(data['birthDate'].toString()),
          SizedBox(height: 16,),
        ],
      ),
    );
  }

}

