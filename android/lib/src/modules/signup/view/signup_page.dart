
import 'package:bade_wangsul/src/modules/signup/cubit/signup_cubit.dart';
import 'package:bade_wangsul/src/modules/signup/view/signup_form.dart';
import 'file:///C:/Users/farhanroy/Documents/project/Bade%20Wangsul/android/lib/src/services/repository/authentication_repository/authentication_repository.dart';
import 'file:///C:/Users/farhanroy/Documents/project/Bade%20Wangsul/android/lib/src/services/repository/user_repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider<SignUpCubit>(
          create: (_) => SignUpCubit(
              context.read<AuthenticationRepository>()
          ),
          child: SignUpForm(),
        ),
      ),
    );
  }
}
