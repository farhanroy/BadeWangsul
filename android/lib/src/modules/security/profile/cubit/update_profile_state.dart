part of 'update_profile_cubit.dart';

enum ImageStorageStatus {unknown, loading, success, failed}
class UpdateProfileState extends Equatable {

  final Default username;
  final Default address;
  final Default age;
  final Default pos;
  final Default imageUrl;
  final Default phoneNumber;
  final FormzStatus status;
  final ImageStorageStatus storageStatus;

  UpdateProfileState({
    this.username = const Default.pure(),
    this.address = const Default.pure(),
    this.age = const Default.pure(),
    this.pos = const Default.pure(),
    this.imageUrl = const Default.pure(),
    this.phoneNumber = const Default.pure(),
    this.status = FormzStatus.pure,
    this.storageStatus = ImageStorageStatus.unknown
  });

  @override
  List<Object> get props =>
      [username, address, age, pos, imageUrl, phoneNumber, status, storageStatus];

  UpdateProfileState copyWith ({
    Default username,
    Default address,
    Default age,
    Default pos,
    Default imageUrl,
    Default phoneNumber,
    FormzStatus status,
    ImageStorageStatus storageStatus
  }) {
    return UpdateProfileState(
        username:  username ?? this.username,
        address: address ?? this.address,
        age: age ?? this.age,
        pos: pos ?? this.pos,
        imageUrl: imageUrl ?? this.imageUrl,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        status: status ?? this.status,
        storageStatus: storageStatus ?? this.storageStatus
    );
  }
  
}