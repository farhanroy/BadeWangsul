import 'package:flutter/material.dart';

import '../../../../models/security.dart';
import '../../../../services/database/dao/users_dao.dart';
import '../../../../widgets/griddashboard.dart';

class DashboardSecurityPage extends StatefulWidget {
  @override
  _DashboardSecurityPageState createState() => _DashboardSecurityPageState();
}

class _DashboardSecurityPageState extends State<DashboardSecurityPage> {

  UsersDao _dao;

  @override
  void initState() {
    super.initState();
    _dao = UsersDao();
    _dao.updateOrInsertSecurity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: FutureBuilder(
          future: _dao.readPembina(),
          builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot){
            if (snapshot.hasError) {
              return Center(child: Text("Something went wrong"));
            }

            if (snapshot.connectionState == ConnectionState.done){

              return _content(Security.fromJson(snapshot.data));
            }

            return Center(child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }

  Widget _content(Security security) {
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
                      security.name,
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
                  Navigator.pushNamed(context, "/security/profile");
                },
              )
            ],
          ),
        ),
        SizedBox(
          height: 40,
        ),

        DashboardSecurityGrid()
      ],
    );
  }
}

class DashboardSecurityGrid extends StatelessWidget {
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
