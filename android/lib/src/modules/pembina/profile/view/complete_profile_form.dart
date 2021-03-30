import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../utils/constants.dart';
import '../bloc/complete_profile_cubit.dart';

class CompleteProfileForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CompleteProfileCubit, CompleteProfileState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Sign Up Failure')),
              );
          }
          if (state.status.isSubmissionSuccess) {

            Navigator.pushNamedAndRemoveUntil(
                context,
                "/pembina",(route) => false
            );
          }
        },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20,),
                _SelectImage(),
                const SizedBox(height: 10,),
                _UsernameInput(),
                const SizedBox(height: 10,),
                _AddressInput(),
                const SizedBox(height: 10,),
                _AgeInput(),
                const SizedBox(height: 10,),
                _DormitoryInput(),
                const SizedBox(height: 10,),
                _PhoneNumberInput(),
                const SizedBox(height: 10,),
                _SubmitButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          onChanged: (username) => context.read<CompleteProfileCubit>().usernameChanged(username),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            labelText: 'Nama',
            helperText: '',
            errorText: state.username.invalid ? 'nama tidak boleh kosong' : null,
          ),
        );
      },
    );
  }
}

class _AddressInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
      buildWhen: (previous, current) => previous.address != current.address,
      builder: (context, state) {
        return TextField(
          onChanged: (address) => context.read<CompleteProfileCubit>().addressChanged(address),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            labelText: 'Alamat',
            helperText: '',
            errorText: state.address.invalid ? 'alamat tidak boleh kosong' : null,
          ),
        );
      },
    );
  }
}

class _AgeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
      buildWhen: (previous, current) => previous.age != current.age,
      builder: (context, state) {
        return TextField(
          onChanged: (age) => context.read<CompleteProfileCubit>().ageChanged(age),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Umur',
            helperText: '',
            errorText: state.age.invalid ? 'umur tidak boleh kosong' : null,
          ),
        );
      },
    );
  }
}

class _DormitoryInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
      buildWhen: (previous, current) => previous.dormitory != current.dormitory,
      builder: (context, state) {
        return DropdownButtonFormField(
          value: state.dormitory.value!.isEmpty ? "Asrama Al-Faraby Cordova" : state.dormitory.value ,
          onChanged: (dynamic value) => context.read<CompleteProfileCubit>().dormitoryChanged(value),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
          items: Constants.DORMITORIES.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Row(children: <Widget>[Text(item),]),
            );
          }).toList(),
        );
      },
    );
  }
}

class _PhoneNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
      buildWhen: (previous, current) => previous.phoneNumber != current.phoneNumber,
      builder: (context, state) {
        return TextField(
          onChanged: (phoneNumber) => context.read<CompleteProfileCubit>().phoneNumberChanged(phoneNumber),
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: 'Nomor telpon',
            helperText: '',
            errorText: state.phoneNumber.invalid ? 'nomor telp tidak boleh kosong' : null,
          ),
        );
      },
    );
  }
}

class _SelectImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
        builder: (context, state) {
          switch (state.storageStatus) {
            case ImageStorageStatus.unknown:
              return _unknown(context);
              
            case ImageStorageStatus.loading:
              return _loading();
              
            case ImageStorageStatus.success:
              return _success(state.imageUrl.value!);
              
            case ImageStorageStatus.failed:
              return _failed();
            default:
              return _unknown(context);
              
          }
        }
    );
  }

  Widget _unknown(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<CompleteProfileCubit>().chooseFile(),
      child: Container(
        width: 100,
        height: 100,
        child: Center(child: Icon(Icons.camera_alt),),
        decoration: BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.circle
        ),
      ),
    );
  }

  Widget _success(String url) {
    return Container(
        width: 100,
        height: 100,
        child: Image.network(url)
    );
  }

  Widget _failed() {
    return Container(
        width: 100,
        height: 100,
        child: Icon(Icons.warning_sharp)
    );
  }

  Widget _loading() {
    return Container(
        width: 100,
        height: 100,
        color: Colors.grey,
        child: Center(child: CircularProgressIndicator(),)
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : MaterialButton(
          key: const Key('signUpForm_continue_raisedButton'),
          child: const Text('Kirim'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Colors.orangeAccent,
          onPressed: state.status.isValidated
              ? () => context.read<CompleteProfileCubit>().submitForm()
              : null,
        );
      },
    );
  }
}
