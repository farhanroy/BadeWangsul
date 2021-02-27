import 'dart:io';

import 'package:bade_wangsul/src/modules/pembina/santri/bloc/create_santri_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';

class CreateSantriForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateSantriCubit, CreateSantriState>(
      listener: (context, state){},
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 64,),
            _SelectImage(),
            SizedBox(height: 8.0,),
            _NameSantriInput(),
            SizedBox(height: 8.0,),
            _AgeSantriInput(),
            SizedBox(height: 8.0,),
            _AddressSantriInput(),
            SizedBox(height: 8.0,),
            _DormitorySantriInput(),
            SizedBox(height: 8.0,),
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
  File _image;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    if(_image == null) {
      return GestureDetector(
        onTap: (){
          _chooseFile();
        },
        child: Container(
          width: 100,
          height: 100,
          child: Center(
            child: Icon(Icons.camera_alt),
          ),
          decoration: BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle
          ),
        ),
      );
    } else {
      context.read<CreateSantriCubit>().imagePathChanged(_image.path);
      return Container(
        width: 100,
        height: 100,
        child: Image.file(
          _image
        )
      );
    }
  }

  void _chooseFile() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    if(image == null) return;
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
          onChanged: (name) => context.read<CreateSantriCubit>().nameChanged(name),
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
          onChanged: (address) => context.read<CreateSantriCubit>().addressChanged(address),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            labelText: 'alamat',
            helperText: '',
            errorText: state.address.invalid ? 'alamat tidak boleh kosong' : null,
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
        return TextField(
          onChanged: (dormitory) => context.read<CreateSantriCubit>().dormitoryChanged(dormitory),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            labelText: 'asrama',
            helperText: '',
            errorText: state.dormitory.invalid ? 'asrama tidak boleh kosong' : null,
          ),
        );
      },
    );
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
                onPressed: (){
                context.read<CreateSantriCubit>().createSantri();
                print(state.imagePath.value);
                },
            ),
          );
        }
    );
  }
}
