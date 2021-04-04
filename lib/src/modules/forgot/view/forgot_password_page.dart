import 'package:bade_wangsul/src/modules/forgot/view/email_sent_view.dart';
import 'package:bade_wangsul/src/modules/forgot/view/forgot_password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../services/repository/authentication_repository/authentication_repository.dart';
import '../cubit/forgot_password_cubit.dart';

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocProvider(
        create: (_) => ForgotPasswordCubit(
          context.read<AuthenticationRepository>(),
        ),
        child: ForgotPasswordPage(),
      )),
    );
  }
}

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      builder: (context, state) {
        return state.status.isSubmissionSuccess
            ? EmailSentView()
            : ForgotPasswordForm();
      },
    );
  }
}
