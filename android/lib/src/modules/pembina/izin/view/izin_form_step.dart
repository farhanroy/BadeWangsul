import 'package:bade_wangsul/src/widgets/datetextfield.dart';
import 'package:flutter/material.dart';

class IzinFormStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _TitleInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _PengasuhNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _PembinaNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _SantriNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _InformationInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
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




