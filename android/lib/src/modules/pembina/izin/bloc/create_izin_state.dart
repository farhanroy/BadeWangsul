part of 'create_izin_cubit.dart';

class CreateIzinState extends Equatable {

  final String idSantri;

  CreateIzinState({
    this.idSantri = ""
});

  @override
  List<Object> get props => [idSantri];

  CreateIzinState copyWith({
    String idSantri
  }){
    return CreateIzinState(
      idSantri: idSantri ?? this.idSantri
    );
  }
}