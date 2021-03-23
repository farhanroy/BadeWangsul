part of 'create_izin_cubit.dart';

class CreateIzinState extends Equatable {

  final String idSantri;
  final int currentStep;
  final Santri? santri;

  final Default title;
  final Default information;
  final Date fromDate;
  final Date toDate;
  final FormzStatus status;

  CreateIzinState({
    this.idSantri = "",
    this.currentStep = 0,
    this.santri,
    this.title = const Default.pure(), 
    this.information = const Default.pure(), 
    this.fromDate = const Date.pure(),
    this.toDate = const Date.pure(),
    this.status = FormzStatus.pure
  });

  @override
  List<Object?> get props => [idSantri, currentStep, santri, title, information, fromDate, toDate, status];

  CreateIzinState copyWith({
    String? idSantri,
    int? currentStep,
    Santri? santri,
    Default? title,
    Default? information,
    Date? fromDate,
    Date? toDate,
    FormzStatus? status
  }){
    return CreateIzinState(
      idSantri: idSantri ?? this.idSantri,
      currentStep: currentStep ?? this.currentStep,
      santri: santri ?? this.santri,
      title: title ?? this.title,
      information: information ?? this.information,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      status: status ?? this.status
    );
  }
}