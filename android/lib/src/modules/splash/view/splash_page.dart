import 'package:bade_wangsul/src/bloc/authentication.dart';
import 'package:bade_wangsul/src/modules/login/login.dart';
import 'package:bade_wangsul/src/utils/usertype_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        switch (state.status) {
          case AuthenticationStatus.authenticated:
            loggedIn(context);
            break;
          case AuthenticationStatus.unauthenticated:
            logIn(context);
            break;
          default:
            break;
        }
      },
      child: Scaffold(
          backgroundColor: theme.primaryColor,
          body: Center(
            child: Container(
              width: 108,
              height: 108,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/img/app_logo.png'))),
            ),
          )),
    );
  }

  Future loggedIn(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2));
    await UsertypeManager.get().then((usertype) {
      UsertypeManager.getIsComplete().then((isComplete) {
        print(isComplete);
        if (isComplete == true || isComplete == null) {
          Navigator.pushNamedAndRemoveUntil(
              context, "/$usertype", (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, "/$usertype/profile/complete", (route) => false);
        }
      });
    });
  }

  Future logIn(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushAndRemoveUntil(context, LoginPage.route(), (route) => false);
  }
}
