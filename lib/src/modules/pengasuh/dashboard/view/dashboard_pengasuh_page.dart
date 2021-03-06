import 'package:flutter/material.dart';

import '../../../../models/models.dart';
import '../../../../services/database/dao/users_dao.dart';
import '../../../../widgets/griddashboard.dart';

class DashboardPengasuhPage extends StatefulWidget {
  @override
  _DashboardPengasuhPageState createState() => _DashboardPengasuhPageState();
}

class _DashboardPengasuhPageState extends State<DashboardPengasuhPage> {

  late UsersDao _dao;

  @override
  void initState() {
    super.initState();
    _dao = UsersDao();
    _dao.updateOrInsertPengasuh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: FutureBuilder(
          future: _dao.readPengasuh(),
          builder: (context, AsyncSnapshot<Map<String, Object?>?> snapshot){
            if (snapshot.hasError) {
              print(snapshot.error);
              return Center(child: Text("Something went wrong"));
            }

            if (snapshot.connectionState == ConnectionState.done){

              return _content(Pengasuh.fromJson(snapshot.data!));
            }

            return Center(child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }

  Widget _content(Pengasuh pengasuh) {
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
                      pengasuh.name!,
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
                  Navigator.pushNamed(context, "/pengasuh/profile");
                },
              )
            ],
          ),
        ),
        SizedBox(
          height: 40,
        ),

        DashboardPengasuhGrid()
      ],
    );
  }
}

class DashboardPengasuhGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GridView.count(
        crossAxisCount: 2,
        children: [
          GridDashboard(
            title: "Daftar perizinan",
            subtitle: "Surat izin santri",
            img: "",
            onTap: () => Navigator.pushNamed(context, "/pengasuh/izin/manage"),
          ),
        ],
      ),
    );
  }
}
