import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../utils/constants.dart';
import '../../../utils/usertype_manager.dart';
import '../../login/view/login_page.dart';
import '../cubit/signup_cubit.dart';

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Sign Up Failure')),
            );
        }
        if (state.status.isSubmissionSuccess) {
          UsertypeManager.set(state.usertype.value!);

          Navigator.pushNamedAndRemoveUntil(context,
              "/${state.usertype.value}/profile/complete", (route) => false);
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 56.0),
              _HeaderContent(),
              const SizedBox(height: 32.0),
              _EmailInput(),
              const SizedBox(height: 8.0),
              _PasswordInput(),
              const SizedBox(height: 8.0),
              _UsertypeInput(),
              const SizedBox(height: 32.0),
              _SignUpButton(),
              const SizedBox(
                height: 64,
              ),
              _LoginButton()
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
          'Sign Up',
          style: theme.textTheme.headline4!
              .copyWith(color: theme.primaryColorLight),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
            'Buat akun anda sendriri, untuk dapat mengakses fitur - fitur yang telah tersedia',
            style: theme.textTheme.subtitle1!.copyWith(color: Colors.grey)),
      ],
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
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

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<SignUpCubit>().passwordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
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

class _UsertypeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.usertype != current.usertype,
      builder: (context, state) {
        return DropdownButtonFormField(
          key: const Key('signUpForm_userNameInput_textField'),
          value:
              state.usertype.value!.isEmpty ? "pengasuh" : state.usertype.value,
          onChanged: (dynamic value) =>
              context.read<SignUpCubit>().usertypeChanged(value),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          ),
          items: Constants.USERTYPE.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Row(children: <Widget>[
                Text(item),
              ]),
            );
          }).toList(),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        final theme = Theme.of(context);
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text('SIGN UP'),
                  style: ElevatedButton.styleFrom(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      textStyle: TextStyle(fontSize: 16),
                      primary: theme.primaryColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12)),
                  onPressed: state.status.isValidated
                      ? () => context.read<SignUpCubit>().signUpFormSubmitted()
                      : null,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Sudah punya akun ?',
          style:
              TextStyle(color: theme.primaryColor, fontWeight: FontWeight.w300),
        ),
        TextButton(
          child: Text(
            'Masuk akun',
            style: TextStyle(
                color: theme.primaryColor, fontWeight: FontWeight.bold),
          ),
          onPressed: () => Navigator.of(context).push<void>(LoginPage.route()),
        ),
      ],
    );
  }
}
