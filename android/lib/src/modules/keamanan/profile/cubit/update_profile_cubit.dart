import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:image_picker/image_picker.dart';

import '../../../../models/keamanan.dart';
import '../../../../utils/validator/validator.dart';
import '../../../../services/repository/user_repository/user_repository.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit(this._userRepository) : super(UpdateProfileState());

  final UserRepository _userRepository;

  late File _file;

  void setInitialImage(String? url) {
    imageUrlChanged(url);
    emit(state.copyWith(storageStatus: ImageStorageStatus.success));
  }

  void usernameChanged(String value) {
    final username = Default.dirty(value);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([
        username,
        state.address,
        state.age,
        state.imageUrl,
        state.phoneNumber
      ]),
    ));
  }

  void addressChanged(String value) {
    final address = Default.dirty(value);
    emit(state.copyWith(
      address: address,
      status: Formz.validate([
        state.username,
        address,
        state.age,
        state.imageUrl,
        state.phoneNumber
      ]),
    ));
  }
  void ageChanged(String value) {
    final age = Default.dirty(value);
    emit(state.copyWith(
      age: age,
      status: Formz.validate([
        state.username,
        state.address,
        age,
        state.imageUrl,
        state.phoneNumber
      ]),
    ));
  }
  void imageUrlChanged(String? value) {
    final imageUrl = Default.dirty(value);
    emit(state.copyWith(
      imageUrl: imageUrl,
      status: Formz.validate([
        state.username,
        state.address,
        state.age,
        imageUrl,
        state.phoneNumber
      ]),
    ));
  }
  void phoneNumberChanged(String value) {
    final phoneNumber = Default.dirty(value);
    emit(state.copyWith(
      phoneNumber: phoneNumber,
      status: Formz.validate([
        state.username,
        state.address,
        state.age,
        state.imageUrl,
        phoneNumber
      ]),
    ));
  }

  // Create new fire store user data
  Future<void> updateData() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _userRepository.updateKeamanan(Keamanan(
          name: state.username.value,
          age: state.age.value,
          address: state.address.value,
          imageUrl: state.imageUrl.value,
          phoneNumber: state.phoneNumber.value
      ));
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  // Upload image chosen to firebase storage bucket
  Future<void> uploadImage() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      var storageRef = firebase_storage
          .FirebaseStorage.instance.ref('user/image/$userId');

      emit(state.copyWith(storageStatus: ImageStorageStatus.loading));

      await storageRef.putFile(_file);
      await storageRef.getDownloadURL().then((url) {
        print(url);
        print(url);
        imageUrlChanged(url);
        emit(state.copyWith(storageStatus: ImageStorageStatus.success));
      });

    } on firebase_core.FirebaseException catch (e) {
      emit(state.copyWith(storageStatus: ImageStorageStatus.failed));
      print(e.code);
    }
  }

  // Choose image file in device storage
  void chooseFile() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    if(image == null) return;
    _file = File(image.path);

    uploadImage();
  }
  
}