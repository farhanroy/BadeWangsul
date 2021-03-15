part of 'create_santri_cubit.dart';

class CreateSantriState extends Equatable {
  const CreateSantriState({
    this.name = const Default.pure(),
    this.age = const Default.pure(),
    this.address = const Default.pure(),
    this.dormitory = const Default.pure(),
    this.birthDate = const Date.pure(),
    this.imagePath = const Default.pure(),
    this.status = FormzStatus.pure,
});

  final Default name;
  final Default age;
  final Default address;
  final Default dormitory;
  final Date birthDate;
  final Default imagePath;
  final FormzStatus status;

  @override
  List<Object> get props => [name, age, address, dormitory, birthDate, imagePath, status];

  CreateSantriState copyWith({
    Default name,
    Default age,
    Default address,
    Default dormitory,
    Date birthDate,
    Default imagePath,
    FormzStatus status
  }) {
    return CreateSantriState(
      name: name ?? this.name,
      age: age ?? this.age,
      address: address ?? this.address,
      dormitory: dormitory ?? this.dormitory,
      birthDate: birthDate ?? this.birthDate,
      imagePath: imagePath ?? this.imagePath,
      status: status ?? this.status
    );
  }
}