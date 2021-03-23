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
    return BlocBuilder<CreateIzinCubit, CreateIzinState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Flexible(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nama"),
                    Text(state.santri!.name!),
                    SizedBox(height: 8.0,),

                    Text("Alamat"),
                    Text(state.santri!.address!),
                    SizedBox(height: 8.0,),

                    Text("Tujuan pulang"),
                    Text(state.title.value!),
                    SizedBox(height: 8.0,),

                    Text("Detail kepulangan"),
                    Text(state.information.value!),
                    SizedBox(height: 8.0,),

                    Text("Dari tanggal"),
                    Text(state.fromDate.value.toString()),
                    SizedBox(height: 8.0,),

                    Text("Sampai tanggal"),
                    Text(state.toDate.value.toString()),
                    SizedBox(height: 8.0,),
                  ],
                ),
              )
            ),
          ),
        );
      }
    );
  }
}


