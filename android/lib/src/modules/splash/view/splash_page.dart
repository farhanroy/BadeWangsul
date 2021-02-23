import 'package:bade_wangsul/src/bloc/authentication.dart';
import 'package:bade_wangsul/src/modules/login/login.dart';
import 'package:bade_wangsul/src/modules/pengasuh/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        switch (state.status) {
          case AuthenticationStatus.authenticated:
            print("Langs  ung");
            break;
          case AuthenticationStatus.unauthenticated:
            Navigator.pushAndRemoveUntil(context, LoginPage.route(), (route) => false);
            break;
          default:
            break;
        }
      },
      child: Scaffold(
        body: Center(
          child: Text("Bade Wangsul"),
        )
      ),
    );
  }
}


