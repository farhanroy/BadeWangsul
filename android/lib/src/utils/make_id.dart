import 'package:intl/intl.dart';

String makeIdSantri({String name, DateTime birthDate}) {
  String formatedName = name.toLowerCase().replaceAll(' ', '');
  String formattedDate = DateFormat('yyyy-MM-dd').format(birthDate).replaceAll('-', '');
  return "$formattedDate$formatedName";
}