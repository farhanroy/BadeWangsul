import 'package:flutter/material.dart';

void showConfirmationDialog({
  BuildContext context,
  String title,
  String content,
  VoidCallback onAccept,
}) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          FlatButton(
            textColor: Theme.of(context).primaryColor,
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Kembali'),
          ),
          FlatButton(
            textColor: Theme.of(context).primaryColor,
            onPressed: onAccept,
            child: Text('Setuju'),
          ),
        ],
      ));
}

void showLoadingDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 10,),
            Text("Loading please waiting...")
          ],
        ),
      ));
}