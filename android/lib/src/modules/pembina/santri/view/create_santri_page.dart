import 'file:///C:/Users/farhanroy/Documents/project/Bade%20Wangsul/android/lib/src/modules/pembina/santri/view/create_santri_form.dart';
import 'package:bade_wangsul/src/modules/pembina/santri/bloc/create_santri_cubit.dart';
import 'package:bade_wangsul/src/repository/santri_repository/santri_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CreateSantriPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<CreateSantriCubit>(
        create: (_) => CreateSantriCubit(
          SantriRepository()
        ),
        child: SingleChildScrollView(
            child: CreateSantriForm()
        ),
      ),
    );
  }
}
