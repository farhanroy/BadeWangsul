import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../services/repository/santri_repository/santri_repository.dart';
import '../bloc/create_santri_cubit.dart';
import 'create_santri_form.dart';

class CreateSantriPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<CreateSantriCubit>(
        create: (_) => CreateSantriCubit(SantriRepository()),
        child: SingleChildScrollView(child: CreateSantriForm()),
      ),
    );
  }
}
