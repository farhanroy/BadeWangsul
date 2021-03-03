import 'package:bade_wangsul/src/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChooseSantriStep extends StatefulWidget {
  @override
  _ChooseSantriStepState createState() => _ChooseSantriStepState();
}

class _ChooseSantriStepState extends State<ChooseSantriStep> {

  String searchKey;
  Stream streamQuery;
  TextEditingController searchController;
  String dormitory;

  @override
  void initState() {
    super.initState();
    streamQuery =
        FirebaseFirestore.instance.collection(Constants.SANTRI_COLLECTION).snapshots();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _searchInput(searchController),
        SizedBox(height: 16,),
        StreamBuilder<QuerySnapshot>(
          stream: streamQuery,
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
      ],
    );
  }

  Widget _content(BuildContext context, QuerySnapshot snapshot) {
    return SingleChildScrollView(
      child: Column(
        children: snapshot.docs.map((DocumentSnapshot document) {
          print(document.data()["name"]);
          return new ListTile(
            leading: CircleAvatar(
              backgroundImage:
              NetworkImage("${document.data()["imageUrl"]}"),
              backgroundColor: Colors.transparent,
            ),
            title: new Text(document.data()['name']),
            subtitle: new Text(document.data()['dormitory']),
          );
        }).toList(),
      ),
    );
  }

  Widget _searchInput(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        onChanged: (value) {
          setState(() {
            searchKey = value;
            streamQuery = FirebaseFirestore.instance.collection(Constants.SANTRI_COLLECTION)
                .where('name', isGreaterThanOrEqualTo: searchKey)
                .where('name', isLessThan: searchKey +'z')
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
