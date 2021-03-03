import 'package:bade_wangsul/src/widgets/griddashboard.dart';
import 'package:flutter/material.dart';

class DashboardPembinaPage extends StatelessWidget {
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
                      "Johny s Family",
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
