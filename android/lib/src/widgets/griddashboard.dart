import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridDashboard extends StatelessWidget {

  final String title;
  final String subtitle;
  final String img;
  final VoidCallback onTap;

  GridDashboard({Key key, this.onTap, this.title, this.subtitle, this.img}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
              color: Color(
                Theme.of(context).primaryColor.value
              ), borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(img, width: 42,),
              SizedBox(
                height: 14,
              ),
              Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                subtitle,
                style: TextStyle(
                    color: Colors.white38,
                    fontSize: 10,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 14,
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  Items({this.title, this.subtitle, this.event, this.img});
}
