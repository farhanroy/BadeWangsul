part of 'verval_izin_cubit.dart';

enum IzinStatus{success, loading, failure, unknown}

class VervalIzinState extends Equatable {

  final Default idSantri;
  final Izin izin;
  final Santri santri;
  final FormzStatus status;
  final IzinStatus izinStatus;

  VervalIzinState({
    this.idSantri = const Default.pure(),
    this.status = FormzStatus.pure,
    this.santri,
    this.izin,
    this.izinStatus
  });

  @override
  List<Object> get props => [this.idSantri, this.santri, this.izin, this.status, izinStatus];

  VervalIzinState copyWith({
    Default idSantri,
    Izin izin,
    Santri santri,
    FormzStatus status,
    IzinStatus izinStatus
  }){
    return VervalIzinState(
      idSantri: idSantri ?? this.idSantri,
      izin: izin ?? this.izin,
      santri: santri ?? this.santri,
      status: status ?? this.status,
      izinStatus: izinStatus ?? this.izinStatus
    );
  }

}