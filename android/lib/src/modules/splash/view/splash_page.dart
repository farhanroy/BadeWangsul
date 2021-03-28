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
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        switch (state.status) {
          case AuthenticationStatus.authenticated:
            UsertypeManager.get().then((usertype) {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/$usertype", (route) => false);
            });
            break;
          case AuthenticationStatus.unauthenticated:
            Navigator.pushAndRemoveUntil(
                context, LoginPage.route(), (route) => false);
            break;
          default:
            break;
        }
      },
      child: Scaffold(
          body: Center(
        child: Column(
          children: [
            Image.asset('assets/img/app_logo.png'),
            const SizedBox(
              height: 10,
            ),
            Text("Bade Wangsul")
          ],
        ),
      )),
    );
  }
}
