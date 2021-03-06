import 'package:bade_wangsul/src/models/models.dart';
import 'package:bade_wangsul/src/services/database/dao/pembina_dao.dart';
import 'package:bade_wangsul/src/utils/constants.dart';
import 'package:bade_wangsul/src/widgets/griddashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashboardPembinaPage extends StatefulWidget {
  @override
  _DashboardPembinaPageState createState() => _DashboardPembinaPageState();
}

class _DashboardPembinaPageState extends State<DashboardPembinaPage> {
  CollectionReference collection;
  String userId;
  UsersDao _dao;

  @override
  void initState() {
    super.initState();
    collection = FirebaseFirestore.instance.collection(Constants.USER_COLLECTION);
    userId = FirebaseAuth.instance.currentUser.uid;
    _dao = UsersDao();
    collection.doc(userId).get().then((DocumentSnapshot documentSnapshot) {
      _dao.insertPembina(Pembina(
        id: userId,
        name: documentSnapshot.data()["name"],
        age: documentSnapshot.data()["age"],
        address: documentSnapshot.data()["address"],
        dormitory: documentSnapshot.data()["dormitory"],
        phoneNumber: documentSnapshot.data()["phoneNumber"],
        imageUrl: documentSnapshot.data()["imageUrl"]
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        children: <Widget>[
          SizedBox(
            height: 72,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      ".",
                      style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Dashboard",
                      style: TextStyle(
                              color: Color(0xffa29aac),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                IconButton(
                  alignment: Alignment.topCenter,
                  icon: Icon(Icons.person_outline_outlined, size: 32,),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil
                      (context, "/pembina/profile", (route) => false);
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),

          DashboardPembinaGrid()
        ],
      ),
    );
  }
}

class DashboardPembinaGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GridView.count(
        crossAxisCount: 2,
        children: [
          GridDashboard(
            title: "Buat izin",
            subtitle: "Surat izin santri",
            img: "",
            onTap: () => Navigator.pushNamed(context, "/pembina/izin/manage"),
          ),

          GridDashboard(
            title: "Manage Santri",
            subtitle: "Manage data santri",
            img: "",
            onTap: () => Navigator.pushNamed(context, "/pembina/santri/manage"),
          ),
        ],
      ),
    );
  }
}
