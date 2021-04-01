import 'package:flutter/material.dart';

class EmailSentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            _HeaderContent(),
            const SizedBox(height: 32,),
            _LoginButton()
          ],
        ),
      ),
    );
  }
}

class _HeaderContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 108,),
        Text(
          'Well done!',
          style: theme.textTheme.headline4!.copyWith(
              color: theme.primaryColorLight
          ),
        ),
        const SizedBox(height: 16,),
        Text(
            'Silahkan cek email anda, kami telah mengirimkan kepada anda untuk mengubah password',
            textAlign: TextAlign.center,
            style: theme.textTheme.subtitle1!.copyWith(
                color: Colors.grey
            )
        ),
      ],
    );
  }
}


class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        child: const Text('Kembali Login'),
        style: ElevatedButton.styleFrom(
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
            textStyle: TextStyle(fontSize: 16),
            primary: theme.primaryColor,
            padding: const EdgeInsets.symmetric(
                horizontal: 24, vertical: 12)
        ),
        onPressed: (){
          Navigator.of(context).pushNamed("/login");
        },
      ),
    );
  }
}

