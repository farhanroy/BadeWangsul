part of 'update_santri_cubit.dart';

enum ImageStorageStatus {unknown, loading, success, failed}
class UpdateSantriState extends Equatable {

  UpdateSantriState({
    this.name = const Default.pure(),
    this.age = const Default.pure(),
    this.address = const Default.pure(),
    this.dormitory = const Default.pure(),
    this.birthDate =  const Date.pure(),
    this.imagePath = const Default.pure(),
    this.storageStatus = ImageStorageStatus.unknown,
    this.status = FormzStatus.pure
  });

  final Default name;
  final Default age;
  final Default address;
  final Default dormitory;
  final Date birthDate;
  final Default imagePath;
  final FormzStatus status;
  final ImageStorageStatus storageStatus;

  @override
  List<Object> get props => [name, age, address, dormitory, birthDate, imagePath, storageStatus, status];

  UpdateSantriState copyWith({
    Default name,
    Default age,
    Default address,
    Default dormitory,
    Date birthDate,
    Default imagePath,
    ImageStorageStatus storageStatus,
    FormzStatus status,
  }){
    return UpdateSantriState(
      name: name ?? this.name,
      age: age ?? this.age,
      address: address ?? this.address,
      dormitory: dormitory ?? this.dormitory,
      birthDate: birthDate ?? this.birthDate,
      imagePath: imagePath ?? this.imagePath,
      storageStatus: storageStatus ?? this.storageStatus,
      status: status ?? this.status
    );
  }
}