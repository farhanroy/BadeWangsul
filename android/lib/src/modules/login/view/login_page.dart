import 'package:bade_wangsul/src/services/repository/authentication_repository/authentication_repository.dart';
import 'package:bade_wangsul/src/services/repository/user_repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../login.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider(
          create: (_) => LoginCubit(
              context.read<AuthenticationRepository>(),
              UserRepository()
          ),
          child: LoginForm(),
        ),
      ),
    );
  }
}
