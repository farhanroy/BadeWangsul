import 'package:flutter/material.dart';

class CreateIzinForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [

        ],
      ),
    );
  }
}


class _IdSantriInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_userNameInput_textField'),
          onChanged: (username) => context.read<SignUpCubit>().usernameChanged(username),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            labelText: 'name',
            helperText: '',
            errorText: state.username.invalid ? 'nama tidak boleh kosong' : null,
          ),
        );
      },
    );
  }
}