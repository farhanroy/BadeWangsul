import 'package:flutter/material.dart';

class EmailSentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Kembali ke halaman Login")
      ),
    );
  }
}
