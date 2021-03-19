import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/verval_izin_cubit.dart';

class DetailIzinView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<VervalIzinCubit, VervalIzinState>(
        listener: (context, state) {
          if(state.izinStatus == IzinStatus.success) {

          }
          if(state.izinStatus == IzinStatus.loading) {

          }
          if(state.izinStatus == IzinStatus.failure) {
            print("Error");
          }
        },
        child: _VervalIzinCard(),
    );
  }
}


class _VervalIzinCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<VervalIzinCubit, VervalIzinState>(
      builder: (context, state) {
        if(state.santri == null || state.izin == null) {
          return Center(child: CircularProgressIndicator(),);
        }
        else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: width,
                      child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Nama"),
                                Text(state.santri.name),
                                SizedBox(height: 8.0,),

                                Text("Alamat"),
                                Text(state.santri.address),
                                SizedBox(height: 8.0,),

                                Text("Tujuan pulang"),
                                Text(state.izin.title),
                                SizedBox(height: 8.0,),

                                Text("Detail kepulangan"),
                                Text(state.izin.information),
                                SizedBox(height: 8.0,),

                                Text("Dari tanggal"),
                                Text(state.izin.fromDate.toString()),
                                SizedBox(height: 8.0,),

                                Text("Sampai tanggal"),
                                Text(state.izin.toDate.toString()),
                                SizedBox(height: 8.0,),
                              ],
                            ),
                          )
                      ),
                    ),
                  ],
                ),
                _ButtonVerification()
              ],
            ),
          );
        }
      },
    );
  }
}

class _ButtonVerification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VervalIzinCubit, VervalIzinState>(
        builder: (context, state) {
          return Positioned(
              bottom: 0,
              child: Row(
                children: [
                  RaisedButton(
                    onPressed: (){
                      //context.read<VervalIzinCubit>().verificationKeluar();
                    },
                    child: Text("Verval Keluar"),
                  )
                ],
              )
          );
        }
    );
  }
}


