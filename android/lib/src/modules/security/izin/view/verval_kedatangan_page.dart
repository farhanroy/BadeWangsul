import 'package:bade_wangsul/src/services/repository/santri_repository/santri_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/verval_izin_cubit.dart';
import '../../../../services/repository/izin_repository/izin_repository.dart';
import 'detail_izin_view.dart';

class VervalKedatanganPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VervalIzinCubit(
          IzinRepository(),
        SantriRepository()
      ),
      child: VervalKedatanganComponent(),
    );
  }
}

class VervalKedatanganComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                _InputIdSantri(),
                _SubmitButton(),
              ],
            ),
            DetailIzinView()
          ],
        ),
      ),
    );
  }
}


class _InputIdSantri extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VervalIzinCubit, VervalIzinState>(
      buildWhen: (previous, current) => previous.idSantri != current.idSantri,
      builder: (context, state) {
        return TextField(
          onChanged: (id) => context.read<VervalIzinCubit>().idSantriChanged(id),
          decoration: InputDecoration(
            labelText: 'ID Santri',
            helperText: '',
            errorText: state.idSantri.invalid ? 'id tidak boleh kosong' : null,
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VervalIzinCubit, VervalIzinState>(
      builder: (context, state) {
        return RaisedButton(
          onPressed: () => context.read<VervalIzinCubit>().searchIzinById(),
          child: Text("Cari"),
        );
      },
    );
  }
}