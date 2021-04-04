import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/database/dao/users_dao.dart';
import '../../../services/repository/authentication_repository/authentication_repository.dart';
import '../../../services/repository/user_repository/user_repository.dart';
import '../login.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocProvider(
          create: (_) => LoginCubit(context.read<AuthenticationRepository>(),
              UserRepository(), UsersDao()),
          child: LoginForm(),
        ),
      ),
    );
  }
}
