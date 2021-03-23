import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../izin/izin.dart';
import '../../../../utils/constants.dart';

class ManageSantriPage extends StatefulWidget {
  @override
  _ManageSantriPageState createState() => _ManageSantriPageState();
}

class _ManageSantriPageState extends State<ManageSantriPage> {

  String? searchKey;
  Stream? streamQuery;
  TextEditingController? searchController;

  @override
  void initState() {
    super.initState();
    streamQuery =
        FirebaseFirestore.instance.collection(Constants.SANTRI_COLLECTION).snapshots();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, "/pembina/santri/create");
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20,),
            _searchInput(searchController),
            SizedBox(height: 10,),
            StreamBuilder<QuerySnapshot>(
              stream: streamQuery as Stream<QuerySnapshot>?,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                return _content(context, snapshot.data!);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _content(BuildContext context, QuerySnapshot snapshot) {
    return SingleChildScrollView(
      child: Column(
        children: snapshot.docs.map((DocumentSnapshot document) {
          print(document.data()!["name"]);
          return new ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => DetailSantriPage(documentID: document.id,)
              ));
            },
            leading: CircleAvatar(
              backgroundImage:
              NetworkImage("${document.data()!["imageUrl"]}"),
              backgroundColor: Colors.transparent,
            ),
            title: new Text(document.data()!['name']),
            subtitle: new Text(document.data()!['dormitory']),
          );
        }).toList(),
      ),
    );
  }

  Widget _searchInput(TextEditingController? controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        onChanged: (value) {
          setState(() {
            searchKey = value;
            streamQuery = FirebaseFirestore.instance.collection(Constants.SANTRI_COLLECTION)
                .where('name', isGreaterThanOrEqualTo: searchKey)
                .where('name', isLessThan: searchKey! +'z')
                .snapshots();
          });
        },
        controller: controller,
        decoration: InputDecoration(
            labelText: "Search",
            prefixIcon: Icon(Icons.search),
            contentPadding: EdgeInsets.all(8),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)))),
      ),
    );
  }
}
