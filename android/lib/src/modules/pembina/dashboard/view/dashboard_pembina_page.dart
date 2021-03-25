import 'package:flutter/material.dart';

import '../../izin/view/manage_izin_page.dart';
import '../../../../models/models.dart';
import '../../../../services/database/dao/users_dao.dart';
import '../../../../widgets/griddashboard.dart';

class DashboardPembinaPage extends StatefulWidget {
  @override
  _DashboardPembinaPageState createState() => _DashboardPembinaPageState();
}

class _DashboardPembinaPageState extends State<DashboardPembinaPage> {

  late UsersDao _dao;
  @override
  void initState() {
    super.initState();
    _dao = UsersDao();
    _dao.updateOrInsertPembina();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: FutureBuilder(
          future: _dao.readPembina(),
          builder: (context, AsyncSnapshot<Map<String, dynamic>?> snapshot){
            if (snapshot.hasError) {
              print(snapshot.error);
              return Center(child: Text("Something went wrong"));
            }

            if (snapshot.connectionState == ConnectionState.done){

              return _content(Pembina.fromJson(snapshot.data!));
            }

            return Center(child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }

  Widget _content(Pembina pembina) {
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
                      pembina.name!,
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
                  Navigator.pushNamed(context, "/pembina/profile");
                },
              )
            ],
          ),
        ),
        SizedBox(
          height: 40,
        ),

        DashboardPembinaGrid(pembina: pembina,)
      ],
    );
  }
}

class DashboardPembinaGrid extends StatelessWidget {
  final Pembina? pembina;

  const DashboardPembinaGrid({Key? key, this.pembina}) : super(key: key);
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
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ManageIzinPage(pembina: pembina,))
            ),
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
