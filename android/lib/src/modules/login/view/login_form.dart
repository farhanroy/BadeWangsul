import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import '../../signup/signup.dart';
import '../../../utils/usertype_manager.dart';
import '../login.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
        if (state.status.isSubmissionSuccess) {
          UsertypeManager.set(state.usertype);

          Navigator.pushNamedAndRemoveUntil(
              context, '/${state.usertype}', (route) => false);
        }
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 96.0),
            _HeaderContent(),
            const SizedBox(height: 56.0),
            _EmailInput(),
            const SizedBox(height: 8.0),
            _PasswordInput(),
            _ForgotPasswordButton(),
            const SizedBox(height: 8.0),
            _LoginButton(),
            const SizedBox(height: 72.0),
            _SignUpButton(),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sign in',
          style: theme.textTheme.headline4!.copyWith(
            color: theme.primaryColorLight
          ),
        ),
        const SizedBox(height: 8,),
        Text(
          'Masuk ke akun anda untuk dapat mengakses fitur - fitur yang telah tersedia',
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
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            prefixIcon: Icon(FontAwesomeIcons.envelope),
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

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: Icon(FontAwesomeIcons.key),
            labelText: 'password',
            helperText: '',
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : Container(
          width: double.infinity,
          child: ElevatedButton(
            key: const Key('loginForm_continue_raisedButton'),
            child: const Text('LOGIN'),
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
                ? () => context.read<LoginCubit>().logInWithCredentials()
                : null,
          ),
        );
      },
    );
  }
}

class _ForgotPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: Text(
          'Forgot password',
          style: TextStyle(color: Theme
              .of(context)
              .primaryColor),
        ),
        onPressed: () => Navigator.of(context).pushNamed('/forgot'),
      ),
    );
  }
}


class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Tidak punya akun ?',
          style: TextStyle(
              color: theme.primaryColor, fontWeight: FontWeight.w300),
        ),
        TextButton(
          child: Text(
            'Buat akun',
            style: TextStyle(
                color: theme.primaryColor, fontWeight: FontWeight.bold),
          ),
          onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
        ),
      ],
    );
  }
}
