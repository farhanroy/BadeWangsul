import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/create_izin_cubit.dart';
import '../../../../widgets/datetextfield.dart';

class IzinFormStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -1 / 3),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16.0),
            _TitleInput(),
            const SizedBox(height: 8.0),
            _SantriNameInput(),
            const SizedBox(height: 8.0),
            _InformationInput(),
            const SizedBox(height: 8.0),
            _FromDateInput(),
            const SizedBox(height: 8.0),
            _ToDateInput(),
          ],
        ),
      ),
    );
  }
}

class _TitleInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateIzinCubit, CreateIzinState>(
      builder: (context, state){
        return TextField(
          //onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Tujuan pulang',
            helperText: '',
            //errorText: state.email.invalid ? 'invalid email' : null,
          ),
        );
      },
    );
  }
}

class _SantriNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateIzinCubit, CreateIzinState>(
        builder: (context, state){
          return TextField(
            //onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Nama santri',
              helperText: '',
              //errorText: state.email.invalid ? 'invalid email' : null,
            ),
          );
        },
    );
  }
}

class _InformationInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateIzinCubit, CreateIzinState>(
      builder: (context, state){
        return TextField(
          //onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Detail kepulangan',
            helperText: '',
            //errorText: state.email.invalid ? 'invalid email' : null,
          ),
        );
      },
    );
  }
}

class _FromDateInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DateTextField(
      labelText: "Dari tanggal",
      prefixIcon: Icon(Icons.date_range),
      suffixIcon: Icon(Icons.arrow_drop_down),
      lastDate: DateTime.now().add(Duration(days: 366)),
      firstDate: DateTime.now(),
      initialDate: DateTime.now().add(Duration(days: 1)),
      onDateChanged: (selectedDate) {
        // Do something with the selected date
      },
    );
  }
}

class _ToDateInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DateTextField(
      labelText: "Sampai tanggal",
      prefixIcon: Icon(Icons.date_range),
      suffixIcon: Icon(Icons.arrow_drop_down),
      lastDate: DateTime.now().add(Duration(days: 366)),
      firstDate: DateTime.now(),
      initialDate: DateTime.now().add(Duration(days: 1)),
      onDateChanged: (selectedDate) {
        // Do something with the selected date
      },
    );
  }
}




