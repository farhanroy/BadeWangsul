import 'package:flutter/material.dart';

import '../../../../models/keamanan.dart';
import '../../../../services/database/dao/users_dao.dart';
import '../../../../widgets/griddashboard.dart';

class DashboardKeamananPage extends StatefulWidget {
  @override
  _DashboardKeamananPageState createState() => _DashboardKeamananPageState();
}

class _DashboardKeamananPageState extends State<DashboardKeamananPage> {

  late UsersDao _dao;

  @override
  void initState() {
    super.initState();
    _dao = UsersDao();
    _dao.updateOrInsertKeamanan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: FutureBuilder(
          future: _dao.readKeamanan(),
          builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot){
            if (snapshot.hasError) {
              return Center(child: Text("Something went wrong"));
            }

            if (snapshot.connectionState == ConnectionState.done){

              return _content(Keamanan.fromJson(snapshot.data!));
            }

            return Center(child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }

  Widget _content(Keamanan keamanan) {
    return Column(
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
                      keamanan.name!,
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
                  Navigator.pushNamed(context, "/keamanan/profile");
                },
              )
            ],
          ),
        ),
        SizedBox(
          height: 40,
        ),

        DashboardKeamananGrid()
      ],
    );
  }
}

class DashboardKeamananGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GridView.count(
        crossAxisCount: 2,
        children: [
          GridDashboard(
            title: "Monitor Santri",
            subtitle: "Siapa saja santri yang telat kembali",
            img: "",
            onTap: () => Navigator.pushNamed(context, "/keamanan/izin/monitor"),
          ),
        ],
      ),
    );
  }
}
