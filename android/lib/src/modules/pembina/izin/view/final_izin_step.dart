import 'package:bade_wangsul/src/modules/pembina/izin/bloc/create_izin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinalIzinStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateIzinCubit, CreateIzinState>(
        listener: (context, state){},
        child: ConfirmationIzin(),
    );
  }
}

class ConfirmationIzin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text("Santri"),
          SizedBox(height: 32,),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(),
            ),
          )
        ],
      ),
    );
  }
}


