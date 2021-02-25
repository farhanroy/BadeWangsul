import 'package:bade_wangsul/src/bloc/authentication.dart';
import 'package:bade_wangsul/src/utils/usertype_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ProfilePembinaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Center(
              child: MaterialButton(
                onPressed: (){
                  context.read<AuthenticationBloc>()
                      .add(AuthenticationLogoutRequested());
                  UsertypeManager.delete();
                  Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
                },
                child: Text("Logout"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
