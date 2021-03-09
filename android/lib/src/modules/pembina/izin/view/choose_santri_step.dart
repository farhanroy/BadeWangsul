import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/create_izin_cubit.dart';
import '../../../../utils/constants.dart';

class ChooseSantriStep extends StatefulWidget {
  final String dormitory;

  const ChooseSantriStep({Key key, this.dormitory}) : super(key: key);
  @override
  _ChooseSantriStepState createState() => _ChooseSantriStepState();
}

class _ChooseSantriStepState extends State<ChooseSantriStep> {

  String searchKey;
  Stream streamQuery;
  TextEditingController searchController;

  @override
  void initState() {
    super.initState();

    streamQuery = FirebaseFirestore.instance.collection(Constants.SANTRI_COLLECTION)
        .where('dormitory', isEqualTo: widget.dormitory)
        .snapshots();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateIzinCubit, CreateIzinState>(
      listener: (context, state) {

      },
      child: Column(
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

              return _content(snapshot.data);
            },
          ),
        ],
      ),
    );
  }

  Widget _content(QuerySnapshot querySnapshot) {
    return BlocBuilder<CreateIzinCubit, CreateIzinState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: querySnapshot.docs.map((DocumentSnapshot document) {
              return new ListTile(
                onTap: () {
                  if (state.idSantri != document.id) {
                    context.read<CreateIzinCubit>().idSantriChanged(document.id);
                  } else {
                    context.read<CreateIzinCubit>().idSantriChanged("");
                  }
                },
                selected: state.idSantri == document.id,
                selectedTileColor: Theme.of(context).primaryColor,
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
                .where('dormitory', isEqualTo: widget.dormitory)
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
