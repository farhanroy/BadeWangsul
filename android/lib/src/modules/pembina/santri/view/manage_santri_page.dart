import 'package:flutter/material.dart';

class ManageSantriPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, "/pembina/santri/create");
        },
      ),
    );
  }
}
