part of 'create_izin_cubit.dart';

class CreateIzinState extends Equatable {

  final String idSantri;
  final int currentStep;

  final Default title;
  final Default information;
  final Default fromDate;
  final Default toDate;
  final FormzStatus status;

  CreateIzinState({
    this.idSantri = "",
    this.currentStep = 0,
    this.title = const Default.pure(), 
    this.information = const Default.pure(), 
    this.fromDate = const Default.pure(), 
    this.toDate = const Default.pure(),
    this.status = FormzStatus.pure
  });

  @override
  List<Object> get props => [idSantri, currentStep, title, information, fromDate, toDate, status];

  CreateIzinState copyWith({
    String idSantri,
    int currentStep,
    Default title,
    Default information,
    Default fromDate,
    Default toDate,
    FormzStatus status
  }){
    return CreateIzinState(
      idSantri: idSantri ?? this.idSantri,
      currentStep: currentStep ?? this.currentStep,
      title: title ?? this.title,
      information: information ?? this.information,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      status: status ?? this.status
    );
  }
}