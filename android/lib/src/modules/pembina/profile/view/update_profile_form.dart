import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../models/models.dart';
import '../../../../services/database/dao/users_dao.dart';
import '../bloc/update_profile_cubit.dart';

class UpdateProfileForm extends StatelessWidget {
  final TextEditingController _inputName = TextEditingController();
  final TextEditingController _inputAge = TextEditingController();
  final TextEditingController _inputAddress = TextEditingController();
  final TextEditingController _inputDormitory = TextEditingController();
  final TextEditingController _inputPhoneNumber = TextEditingController();
  final UsersDao _usersDao = UsersDao();
  @override
  Widget build(BuildContext context) {
    setInitialValue(context);
    return BlocListener<UpdateProfileCubit, UpdateProfileState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Sign Up Failure')),
            );
        }
        if (state.status.isSubmissionSuccess) {
          Navigator.pop(context);
        }
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20,),
                _SelectImage(),
                SizedBox(height: 10,),
                _UsernameInput(inputName: _inputName,),
                SizedBox(height: 10,),
                _AddressInput(inputAddress: _inputAddress,),
                SizedBox(height: 10,),
                _AgeInput(inputAge: _inputAge,),
                SizedBox(height: 10,),
                _DormitoryInput(inputDormitory: _inputDormitory,),
                SizedBox(height: 10,),
                _PhoneNumberInput(inputPhoneNumber: _inputPhoneNumber,),
                SizedBox(height: 10,),
                _UpdateButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  void setInitialValue(BuildContext context) async {
    final snapshot = await _usersDao.readPembina();
    final pembina = Pembina.fromJson(snapshot);

    _inputName.text = pembina.name!;
    _inputAge.text = pembina.age!;
    _inputAddress.text = pembina.address!;
    _inputDormitory.text = pembina.dormitory!;
    _inputPhoneNumber.text = pembina.phoneNumber!;
    context.read<UpdateProfileCubit>().setInitialImage(pembina.imageUrl);
  }
}

class _UsernameInput extends StatelessWidget {
  final TextEditingController? inputName;

  _UsernameInput({Key? key, this.inputName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          controller: inputName,
          onChanged: (username) => context.read<UpdateProfileCubit>().usernameChanged(username),
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
  final TextEditingController? inputAddress;

  const _AddressInput({Key? key, this.inputAddress}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
      buildWhen: (previous, current) => previous.address != current.address,
      builder: (context, state) {
        return TextField(
          controller: inputAddress,
          onChanged: (address) => context.read<UpdateProfileCubit>().addressChanged(address),
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
  final TextEditingController? inputAge;

  const _AgeInput({Key? key, this.inputAge}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
      buildWhen: (previous, current) => previous.age != current.age,
      builder: (context, state) {
        return TextField(
          controller: inputAge,
          onChanged: (age) => context.read<UpdateProfileCubit>().ageChanged(age),
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
  final TextEditingController? inputDormitory;

  const _DormitoryInput({Key? key, this.inputDormitory}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
      buildWhen: (previous, current) => previous.dormitory != current.dormitory,
      builder: (context, state) {
        return TextField(
          controller: inputDormitory,
          onChanged: (dormitory) => context.read<UpdateProfileCubit>().dormitoryChanged(dormitory),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            labelText: 'Asrama',
            helperText: '',
            errorText: state.address.invalid ? 'asrama tidak boleh kosong' : null,
          ),
        );
      },
    );
  }
}

class _PhoneNumberInput extends StatelessWidget {
  final TextEditingController? inputPhoneNumber;

  const _PhoneNumberInput({Key? key, this.inputPhoneNumber}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
      //buildWhen: (previous, current) => previous.phoneNumber != current.phoneNumber,
      builder: (context, state) {
        return TextField(
          controller: inputPhoneNumber,
          onChanged: (phoneNumber) => context.read<UpdateProfileCubit>().phoneNumberChanged(phoneNumber),
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
    return BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
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
      onTap: () => context.read<UpdateProfileCubit>().chooseFile(),
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

class _UpdateButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : MaterialButton(
          key: const Key('signUpForm_continue_raisedButton'),
          child: const Text('Update'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Colors.orangeAccent,
          onPressed: state.status.isValidated
              ? () => context.read<UpdateProfileCubit>().updateData()
              : null,
        );
      },
    );
  }
}
