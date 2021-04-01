import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../cubit/forgot_password_cubit.dart';

class ForgotPasswordForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -1 / 3),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _HeaderContent(),
              const SizedBox(height: 16.0),
              _EmailInput(),
              const SizedBox(height: 8.0),
              _SendEmailButton()
            ],
          ),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reset Password',
          style: theme.textTheme.headline4!.copyWith(
              color: theme.primaryColorLight
          ),
        ),
        const SizedBox(height: 8,),
        Text(
            'Masukan email yang terhubung dengan akun anda untuk mengatur ulang sandi anda',
            style: theme.textTheme.subtitle1!.copyWith(
                color: Colors.grey
            )
        ),
      ],
    );
  }
}


class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (email) => context.read<ForgotPasswordCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'email',
            helperText: '',
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            errorText: state.email.invalid ? 'invalid email' : null,
          ),
        );
      },
    );
  }
}

class _SendEmailButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        final theme = Theme.of(context);
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : Container(
          width: double.infinity,
          child: ElevatedButton(
          child: const Text('SEND EMAIL'),
          style: ElevatedButton.styleFrom(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                textStyle: TextStyle(fontSize: 16),
                primary: theme.primaryColor,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 12)
          ),
          onPressed: state.status.isValidated
                ? () => context.read<ForgotPasswordCubit>().resetPassword()
                : null,
        ),
            );
      },
    );
  }
}