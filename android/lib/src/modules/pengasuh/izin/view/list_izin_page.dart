import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';
import 'detail_izin_page.dart';

class ListIzinPage extends StatefulWidget {
  @override
  _ListIzinPageState createState() => _ListIzinPageState();
}

class _ListIzinPageState extends State<ListIzinPage> {

  String? searchKey;
  Stream? streamQuery;
  TextEditingController? searchController;

  @override
  void initState() {
    super.initState();
    streamQuery = FirebaseFirestore.instance
        .collection(Constants.IZIN_COLLECTION)
        .where("isPermissioned",isEqualTo: false)
        .snapshots();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: streamQuery as Stream<QuerySnapshot>?,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    _searchInput(searchController),
                    SizedBox(height: 8,),
                    Column(
                      children: snapshot.data!.docs.map((DocumentSnapshot document) {
                        return GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) =>
                                      DetailIzinPage(idIzin: document.id,))
                              );
                            },
                            child: _ItemIzinSantri(idSantri: document.data()!['idSantri'],)
                        );
                      }).toList(),
                    )
                  ],
                ),
              );
            }
        ),
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
            streamQuery = FirebaseFirestore.instance.collection(Constants.IZIN_COLLECTION)
                .where('name', isGreaterThanOrEqualTo: searchKey)
                .where('name', isLessThan: searchKey! +'z')
                .where("isPermissioned",isEqualTo: true)
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

class _ItemIzinSantri extends StatelessWidget {
  _ItemIzinSantri({Key? key, this.idSantri}) : super(key: key);

  final String? idSantri;
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
            NetworkImage("${snapshot.data!.data()!["imageUrl"]}"),
            backgroundColor: Colors.transparent,
          ),
          title: new Text(snapshot.data!.data()!['name']),
          subtitle: new Text(snapshot.data!.data()!['dormitory']),
        );
      },
    );
  }
}

