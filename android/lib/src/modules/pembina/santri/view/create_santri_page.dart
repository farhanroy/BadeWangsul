import 'package:bade_wangsul/src/modules/pembina/santri/bloc/create_santri_cubit.dart';
import 'package:bade_wangsul/src/services/repository/santri_repository/santri_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'create_santri_form.dart';
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
