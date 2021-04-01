import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/constants.dart';
import '../../../../models/security.dart';
import '../cubit/update_profile_cubit.dart';
import '../../../../services/database/dao/users_dao.dart';

class UpdateProfileForm extends StatelessWidget {
  final TextEditingController _inputName = TextEditingController();
  final TextEditingController _inputAge = TextEditingController();
  final TextEditingController _inputAddress = TextEditingController();
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
              const SnackBar(content: Text('Update data failure')),
            );
        }
        if (state.status.isSubmissionSuccess) {
          Navigator.pop(context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _SelectImage(),
              SizedBox(height: 30,),
              _UsernameInput(inputName: _inputName,),
              SizedBox(height: 10,),
              _AddressInput(inputAddress: _inputAddress,),
              SizedBox(height: 10,),
              _AgeInput(inputAge: _inputAge,),
              _PosInput(),
              SizedBox(height: 20,),
              _PhoneNumberInput(inputPhoneNumber: _inputPhoneNumber,),
              SizedBox(height: 10,),
              _UpdateButton()
            ],
          ),
        ),
      ),
    );
  }

  void setInitialValue(BuildContext context) async {
    final snapshot = await _usersDao.readSecurity();
    final security = Security.fromJson(snapshot!);

    _inputName.text = security.name!;
    _inputAge.text = security.age!.toString();
    _inputAddress.text = security.address!;
    _inputPhoneNumber.text = security.phoneNumber!;
    context.read<UpdateProfileCubit>().setInitialImage(security.imageUrl!);
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
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            errorText: state.age.invalid ? 'umur tidak boleh kosong' : null,
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
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            errorText: state.phoneNumber.invalid ? 'nomor telp tidak boleh kosong' : null,
          ),
        );
      },
    );
  }
}

class _PosInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
      buildWhen: (previous, current) => previous.pos != current.pos,
      builder: (context, state) {

        return DropdownButtonFormField(
          key: const Key('signUpForm_userNameInput_textField'),
          value: "1",
          onChanged: (dynamic pos) => context.read<UpdateProfileCubit>().posChanged(pos),
          decoration: InputDecoration(
              border: OutlineInputBorder()
          ),
          items: Constants.POS.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Row(children: <Widget>[Text(item.toString()),]),
            );
          }).toList(),
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
              return _success(context, state.imageUrl.value!);

            case ImageStorageStatus.failed:
              return _failed(context);
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

  Widget _success(BuildContext context, String? url) {
    return GestureDetector(
      onTap: () => context.read<UpdateProfileCubit>().chooseFile(),
      child: Center(
        child: url != null ? CircleAvatar(
          radius: 60,
          backgroundImage: NetworkImage(url),
        ) : CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('assets/img/default-profile.png')),
      ),
    );
  }

  Widget _failed(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<UpdateProfileCubit>().chooseFile(),
      child: Container(
          width: 100,
          height: 100,
          child: Icon(Icons.warning_sharp)
      ),
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
    final theme = Theme.of(context);
    return BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
          child: const Text('UPDATE'),
          style: ElevatedButton.styleFrom(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
              ),
              textStyle: TextStyle(fontSize: 16),
              primary: theme.accentColor,
              padding: const EdgeInsets.symmetric(
                  horizontal: 24, vertical: 12)
          ),
          onPressed: () => context.read<UpdateProfileCubit>().updateData(),
        );
      },
    );
  }
}
