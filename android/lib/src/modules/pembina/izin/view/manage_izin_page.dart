import 'package:flutter/material.dart';

class ManageIzinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, "/pembina/izin/create"),
      ),
    );
  }
}
