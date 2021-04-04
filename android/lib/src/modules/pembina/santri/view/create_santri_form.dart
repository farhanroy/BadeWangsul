import 'dart:io';

import 'package:bade_wangsul/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../widgets/datetextfield.dart';
import '../bloc/create_santri_cubit.dart';

class CreateSantriForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateSantriCubit, CreateSantriState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
        if (state.status.isSubmissionSuccess) {
          Navigator.pop(context);
        }
        if (state.status.isSubmissionInProgress) {
          Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 64,
            ),
            _SelectImage(),
            const SizedBox(
              height: 8.0,
            ),
            _NameSantriInput(),
            const SizedBox(
              height: 8.0,
            ),
            _AgeSantriInput(),
            const SizedBox(
              height: 8.0,
            ),
            _AddressSantriInput(),
            const SizedBox(
              height: 8.0,
            ),
            _DormitorySantriInput(),
            const SizedBox(
              height: 8.0,
            ),
            _BirthDateInput(),
            const SizedBox(
              height: 8.0,
            ),
            _CreateSantriButton()
          ],
        ),
      ),
    );
  }
}

class _SelectImage extends StatefulWidget {
  @override
  __SelectImageState createState() => __SelectImageState();
}

class __SelectImageState extends State<_SelectImage> {
  File? _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    if (_image == null) {
      return GestureDetector(
        onTap: () {
          _chooseFile();
        },
        child: Container(
          width: 100,
          height: 100,
          child: Center(
            child: Icon(Icons.camera_alt),
          ),
          decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
        ),
      );
    } else {
      context.read<CreateSantriCubit>().imagePathChanged(_image!.path);
      return Container(width: 100, height: 100, child: Image.file(_image!));
    }
  }

  void _chooseFile() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      _image = File(image.path);
    });
  }
}

class _NameSantriInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateSantriCubit, CreateSantriState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextField(
          onChanged: (name) =>
              context.read<CreateSantriCubit>().nameChanged(name),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            labelText: 'nama',
            helperText: '',
            errorText: state.name.invalid ? 'nama tidak boleh kosong' : null,
          ),
        );
      },
    );
  }
}

class _AgeSantriInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateSantriCubit, CreateSantriState>(
      buildWhen: (previous, current) => previous.age != current.age,
      builder: (context, state) {
        return TextField(
          onChanged: (age) => context.read<CreateSantriCubit>().ageChanged(age),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            labelText: 'umur',
            helperText: '',
            errorText: state.age.invalid ? 'umur tidak boleh kosong' : null,
          ),
        );
      },
    );
  }
}

class _AddressSantriInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateSantriCubit, CreateSantriState>(
      buildWhen: (previous, current) => previous.address != current.address,
      builder: (context, state) {
        return TextField(
          onChanged: (address) =>
              context.read<CreateSantriCubit>().addressChanged(address),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            labelText: 'alamat',
            helperText: '',
            errorText:
                state.address.invalid ? 'alamat tidak boleh kosong' : null,
          ),
        );
      },
    );
  }
}

class _DormitorySantriInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateSantriCubit, CreateSantriState>(
      buildWhen: (previous, current) => previous.dormitory != current.dormitory,
      builder: (context, state) {
        return DropdownButtonFormField(
          value: state.dormitory.value!.isEmpty
              ? "Asrama Al-Faraby Cordova"
              : state.dormitory.value,
          onChanged: (dynamic value) =>
              context.read<CreateSantriCubit>().dormitoryChanged(value),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
          items: Constants.DORMITORIES.map((item) {
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

class _BirthDateInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateSantriCubit, CreateSantriState>(
        builder: (context, state) {
      return DateTextField(
        labelText: "Tanggal lahir",
        prefixIcon: Icon(Icons.date_range),
        suffixIcon: Icon(Icons.arrow_drop_down),
        lastDate: DateTime.now().add(Duration(days: 366)),
        firstDate: DateTime.now(),
        initialDate: DateTime.now().add(Duration(days: 1)),
        onDateChanged: (selectedDate) =>
            context.read<CreateSantriCubit>().birthDateChanged(selectedDate!),
      );
    });
  }
}

class _CreateSantriButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateSantriCubit, CreateSantriState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return Center(
            child: RaisedButton(
              child: Text("Tambah"),
              onPressed: () {
                context.read<CreateSantriCubit>().createSantri();
                print(state.imagePath.value);
              },
            ),
          );
        });
  }
}
