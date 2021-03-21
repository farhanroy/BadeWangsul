import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/detail_izin_cubit.dart';
import '../../../../services/repository/izin_repository/izin_repository.dart';

class DetailIzinPage extends StatelessWidget {
  final String idIzin;

  const DetailIzinPage({Key key, this.idIzin}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87,),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
      ),
      body: BlocProvider(
        create: (_) => DetailIzinCubit(IzinRepository(), idIzin: idIzin),
        child:  _DetailIzinComponent(),
      )
    );
  }
}

class _DetailIzinComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<DetailIzinCubit, DetailIzinState>(
        listener: (context, state) {
          if(state.status == DetailIzinStatus.success) {

          }
          if(state.status == DetailIzinStatus.loading) {
            //showLoadingDialog(context);
          }
          if(state.status == DetailIzinStatus.failure) {
            print("Error");
          }
        },
        child: _DetailIzinCard(),
    );
  }
}


class _DetailIzinCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<DetailIzinCubit, DetailIzinState>(
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
    return BlocBuilder<DetailIzinCubit, DetailIzinState>(
        builder: (context, state) {
          return Positioned(
              bottom: 0,
              child: Row(
                children: [
                  RaisedButton(
                    onPressed: (){
                      context.read<DetailIzinCubit>().verificationIzin();
                    },
                    child: Text("Izinkan"),
                  )
                ],
              )
          );
        }
    );
  }
}


