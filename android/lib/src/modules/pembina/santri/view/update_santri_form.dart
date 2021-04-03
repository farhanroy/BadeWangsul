import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../models/models.dart';
import '../bloc/update_santri_cubit.dart';
import '../../../../services/repository/santri_repository/santri_repository.dart';
import '../../../../widgets/datetextfield.dart';

class UpdateSantriForm extends StatelessWidget {
  UpdateSantriForm({Key? key, this.idSantri}) : super(key: key);
  
  final String? idSantri;
  
  final TextEditingController _inputName = TextEditingController();
  final TextEditingController _inputAge = TextEditingController();
  final TextEditingController _inputAddress = TextEditingController();
  final TextEditingController _inputDormitory = TextEditingController();
  
  final _santriRepository = SantriRepository();
  @override
  Widget build(BuildContext context) {
    setInitialValue(context);
    return BlocListener<UpdateSantriCubit, UpdateSantriState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Update Failure')),
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
                _NameInput(inputName: _inputName,),
                SizedBox(height: 10,),
                _AddressInput(inputAddress: _inputAddress,),
                SizedBox(height: 10,),
                _AgeInput(inputAge: _inputAge,),
                SizedBox(height: 10,),
                _DormitoryInput(inputDormitory: _inputDormitory,),
                SizedBox(height: 10,),
                _BirthDateInput(),
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
    final snapshot = await _santriRepository.getSantriById(idSantri);
    final santri = Santri.fromJson(snapshot.data()!);

    _inputName.text = santri.name!;
    _inputAge.text = santri.age!;
    _inputAddress.text = santri.address!;
    _inputDormitory.text = santri.dormitory!;

    context.read<UpdateSantriCubit>().nameChanged(santri.name!);
    context.read<UpdateSantriCubit>().ageChanged(santri.age!);
    context.read<UpdateSantriCubit>().addressChanged(santri.address!);
    context.read<UpdateSantriCubit>().dormitoryChanged(santri.dormitory!);
    context.read<UpdateSantriCubit>().birthDateChanged(santri.birthDate);
    context.read<UpdateSantriCubit>().setInitialImage(santri.imageUrl);
  }
}

class _NameInput extends StatelessWidget {
  final TextEditingController? inputName;

  _NameInput({Key? key, this.inputName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateSantriCubit, UpdateSantriState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextField(
          controller: inputName,
          onChanged: (name) => context.read<UpdateSantriCubit>().nameChanged(name),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            labelText: 'Nama',
            helperText: '',
            errorText: state.name.invalid ? 'nama tidak boleh kosong' : null,
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
    return BlocBuilder<UpdateSantriCubit, UpdateSantriState>(
      buildWhen: (previous, current) => previous.address != current.address,
      builder: (context, state) {
        return TextField(
          controller: inputAddress,
          onChanged: (address) => context.read<UpdateSantriCubit>().addressChanged(address),
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
    return BlocBuilder<UpdateSantriCubit, UpdateSantriState>(
      buildWhen: (previous, current) => previous.age != current.age,
      builder: (context, state) {
        return TextField(
          controller: inputAge,
          onChanged: (age) => context.read<UpdateSantriCubit>().ageChanged(age),
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
    return BlocBuilder<UpdateSantriCubit, UpdateSantriState>(
      buildWhen: (previous, current) => previous.dormitory != current.dormitory,
      builder: (context, state) {
        return TextField(
          controller: inputDormitory,
          onChanged: (dormitory) => context.read<UpdateSantriCubit>().dormitoryChanged(dormitory),
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

class _BirthDateInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateSantriCubit, UpdateSantriState>(
      buildWhen: (previous, current) => previous.birthDate != current.birthDate,
        builder: (context, state) {
          return DateTextField(
            labelText: "Tanggal lahir",
            prefixIcon: Icon(Icons.date_range),
            suffixIcon: Icon(Icons.arrow_drop_down),
            lastDate: DateTime.now().add(Duration(days: 366)),
            firstDate: DateTime.now(),
            initialDate: DateTime.now(),
            onDateChanged: (selectedDate) =>
                context.read<UpdateSantriCubit>().birthDateChanged(selectedDate),
          );
        }
    );
  }
}

class _SelectImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateSantriCubit, UpdateSantriState>(
        builder: (context, state) {
          switch (state.storageStatus) {
            case ImageStorageStatus.unknown:
              return _unknown(context);
              
            case ImageStorageStatus.loading:
              return _loading();
              
            case ImageStorageStatus.success:
              return _success(state.imagePath.value!);
              
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
      onTap: () => context.read<UpdateSantriCubit>().chooseFile(),
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
    return BlocBuilder<UpdateSantriCubit, UpdateSantriState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : RaisedButton(
          key: const Key('signUpForm_continue_raisedButton'),
          child: const Text('Update'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Colors.orangeAccent,
          onPressed: state.status.isValidated
              ? () => context.read<UpdateSantriCubit>().updateSantri()
              : null,
        );
      },
    );
  }
}