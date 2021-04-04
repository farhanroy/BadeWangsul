import 'package:bade_wangsul/src/modules/pembina/santri/view/update_santri_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/update_santri_cubit.dart';
import '../../../../services/repository/santri_repository/santri_repository.dart';

class UpdateSantriPage extends StatelessWidget {
  final String? idSantri;

  const UpdateSantriPage({Key? key, this.idSantri}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocProvider<UpdateSantriCubit>(
        create: (_) => UpdateSantriCubit(
          SantriRepository(),
          idSantri,
        ),
        child: UpdateSantriForm(
          idSantri: idSantri,
        ),
      )),
    );
  }
}
