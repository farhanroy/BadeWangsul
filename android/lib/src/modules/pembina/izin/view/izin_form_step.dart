import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/create_izin_cubit.dart';
import '../../../../widgets/datetextfield.dart';

class IzinFormStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateIzinCubit, CreateIzinState>(
      listener: (context, state){
        //context.read<CreateIzinCubit>().santriChanged();
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16.0),
              _TitleInput(),
              const SizedBox(height: 8.0),
              _InformationInput(),
              const SizedBox(height: 8.0),
              _FromDateInput(),
              const SizedBox(height: 8.0),
              _ToDateInput(),
            ],
          ),
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
          onChanged: (title) => context.read<CreateIzinCubit>().titleChanged(title),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Tujuan pulang',
            helperText: '',
            errorText: state.title.invalid ? 'invalid title' : null,
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
          onChanged: (information) =>
              context.read<CreateIzinCubit>().informationChanged(information),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Detail kepulangan',
            helperText: '',
            errorText: state.information.invalid ? 'invalid information' : null,
          ),
        );
      },
    );
  }
}

class _FromDateInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateIzinCubit, CreateIzinState>(
        builder: (context, state){
          return DateTextField(
            labelText: "Dari tanggal",
            prefixIcon: Icon(Icons.date_range),
            suffixIcon: Icon(Icons.arrow_drop_down),
            lastDate: DateTime.now().add(Duration(days: 366)),
            firstDate: DateTime.now(),
            initialDate: DateTime.now().add(Duration(days: 1)),
            onDateChanged: (selectedDate) =>
                context.read<CreateIzinCubit>().fromDateChanged(selectedDate!),
          );
        }
    );
  }
}

class _ToDateInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateIzinCubit, CreateIzinState>(
        builder: (context, state) {
          return DateTextField(
            labelText: "Sampai tanggal",
            prefixIcon: Icon(Icons.date_range),
            suffixIcon: Icon(Icons.arrow_drop_down),
            lastDate: DateTime.now().add(Duration(days: 366)),
            firstDate: DateTime.now(),
            initialDate: DateTime.now().add(Duration(days: 1)),
            onDateChanged: (selectedDate) =>
                context.read<CreateIzinCubit>().toDateChanged(selectedDate!),
          );
        }
    );
  }
}




