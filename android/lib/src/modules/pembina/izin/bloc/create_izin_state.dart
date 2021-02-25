part of 'create_izin_cubit.dart';

class CreateIzinState extends Equatable {
  const CreateIzinState({
    this.idSantri = const Default.pure()
});

  final Default idSantri;

  @override
  List<Object> get props => [idSantri];
}