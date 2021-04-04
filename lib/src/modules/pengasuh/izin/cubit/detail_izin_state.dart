part of 'detail_izin_cubit.dart';

enum DetailIzinStatus {loading, success, failure}
class DetailIzinState extends Equatable {

  final Izin? izin;
  final Santri? santri;
  final DetailIzinStatus? status;

  DetailIzinState({
    this.izin,
    this.santri,
    this.status
  });

  @override
  List<Object?> get props => [this.izin, this.santri, this.status];

  DetailIzinState copyWith({
    Izin? izin,
    Santri? santri,
    DetailIzinStatus? status
  }){
    return DetailIzinState(
      izin: izin ?? this.izin,
      santri: santri ?? this.santri,
      status: status ?? this.status
    );
  }

}