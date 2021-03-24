import 'package:flutter/material.dart';

void showConfirmationDialog({
  required BuildContext context,
  required String? title,
  required String? content,
  required VoidCallback? onAccept,
}) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title!),
        content: Text(content!),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Kembali'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
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