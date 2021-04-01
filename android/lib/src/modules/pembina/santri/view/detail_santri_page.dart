import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'update_santri_page.dart';
import '../../../../widgets/appdialog.dart';
import '../../../../models/santri.dart';
import '../../../../utils/constants.dart';

class DetailSantriPage extends StatelessWidget {

  final String? documentID;

  const DetailSantriPage({Key? key, this.documentID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference santri = FirebaseFirestore
        .instance.collection(Constants.SANTRI_COLLECTION);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.arrowLeft, color: theme.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.edit, color: theme.primaryColor),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => UpdateSantriPage(idSantri: documentID,)
              ));
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete, color: theme.scaffoldBackgroundColor,),
        backgroundColor: Theme.of(context).errorColor,
        onPressed: () => showConfirmationDialog(
            context: context,
            title: "Hapus santri",
            content: "Apakah anda ingin menghapus data santri ?",
            onAccept: () => deleteSantri(santri)
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<DocumentSnapshot>(
          future: santri.doc(documentID).get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return _content(snapshot.data!, theme);
            }

            return Center(child: CircularProgressIndicator(),);
          }
        ),
      ),
    );
  }

  Widget _content(DocumentSnapshot snapshot, ThemeData theme) {
    Santri? santri = Santri.fromJson(snapshot.data()!);
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage("${santri.imageUrl}"),
            ),
          ),
          SizedBox(height: 32,),

          Text("Name", style: theme.textTheme.subtitle2,),
          Text(santri.name ?? "", style: theme.textTheme.subtitle1,),
          SizedBox(height: 16,),

          Text("Umur", style: theme.textTheme.subtitle2,),
          Text(santri.age ?? "", style: theme.textTheme.subtitle1,),
          SizedBox(height: 16,),

          Text("Alamat", style: theme.textTheme.subtitle2,),
          Text(santri.age ?? "", style: theme.textTheme.subtitle1,),
          SizedBox(height: 16,),

          Text("Asrama", style: theme.textTheme.subtitle2,),
          Text(santri.dormitory ?? "", style: theme.textTheme.subtitle1,),
          SizedBox(height: 16,),

          Text("Tanggal lahir", style: theme.textTheme.subtitle2,),
          Text(formatDate(santri.birthDate!), style: theme.textTheme.subtitle1,),
          SizedBox(height: 16,),
        ],
      ),
    );
  }

  String formatDate(DateTime birthDate) {
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(birthDate);
    return formattedDate;
  }

  Future<void> deleteSantri(CollectionReference santri) {
    return santri
        .doc(documentID)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
}
