part of 'create_izin_cubit.dart';

class CreateIzinState extends Equatable {

  final Default title;
  final Default information;
  final Default pengasuhName;
  final Default pembinaName;
  final Default santriName;
  final Default fromDate;
  final Default toDate;
  final FormzStatus status;

  CreateIzinState({
    this.title = const Default.pure(),
    this.information = const Default.pure(),
    this.pengasuhName = const Default.pure(),
    this.pembinaName = const Default.pure(),
    this.santriName = const Default.pure(),
    this.fromDate = const Default.pure(),
    this.toDate = const Default.pure(),
    this.status = FormzStatus.pure
});

  @override
  List<Object> get props => [title, information, pengasuhName, pembinaName, santriName, fromDate, toDate, status];

  CreateIzinState copyWith({
    Default title,
    Default information,
    Default pengasuhName,
    Default pembinaName,
    Default santriName,
    Default fromDate,
    Default toDate,
    FormzStatus status
  }){
    return CreateIzinState(
      title: title ?? this.title,
      information: information ?? this.information,
      pengasuhName: pengasuhName ?? this.pengasuhName,
      pembinaName: pembinaName ?? this.pembinaName,
      santriName: santriName ?? this.santriName,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      status: status ?? this.status,
    );
  }
}