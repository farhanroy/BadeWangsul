import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:image_picker/image_picker.dart';

import '../../../../models/santri.dart';
import '../../../../utils/validator/validator.dart';
import '../../../../services/repository/santri_repository/santri_repository.dart';

part 'update_santri_state.dart';

class UpdateSantriCubit extends Cubit<UpdateSantriState> {
  UpdateSantriCubit(this._santriRepository, this.idSantri) : super(UpdateSantriState());

  final SantriRepository _santriRepository;
  final String? idSantri;

  File? _file;

  void setInitialImage(String? url) {
    imageUrlChanged(url);
    emit(state.copyWith(storageStatus: ImageStorageStatus.success));
  }

  void nameChanged(String value) {
    final name = Default.dirty(value);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([
        name,
        state.age,
        state.address,
        state.dormitory,
        state.birthDate,
        state.imagePath
      ]),
    ));
  }

  void ageChanged(String value) {
    final age = Default.dirty(value);
    emit(state.copyWith(
      age: age,
      status: Formz.validate([
        state.name,
        age,
        state.address,
        state.dormitory,
        state.birthDate,
        state.imagePath
      ]),
    ));
  }

  void addressChanged(String value) {
    final address = Default.dirty(value);
    emit(state.copyWith(
      address: address,
      status: Formz.validate([
        state.name,
        state.age,
        address,
        state.dormitory,
        state.birthDate,
        state.imagePath
      ]),
    ));
  }

  void dormitoryChanged(String value) {
    final dormitory = Default.dirty(value);
    emit(state.copyWith(
      dormitory: dormitory,
      status: Formz.validate([
        state.name,
        state.age,
        state.address,
        dormitory,
        state.birthDate,
        state.imagePath
      ]),
    ));
  }

  void birthDateChanged(DateTime? value) {
    final birthDate = Date.dirty(value);
    emit(state.copyWith(
      birthDate: birthDate,
      status: Formz.validate([
        state.name,
        state.age,
        state.address,
        state.dormitory,
        birthDate,
        state.imagePath
      ]),
    ));
  }

  void imageUrlChanged(String? value) {
    final imagePath = Default.dirty(value);
    emit(state.copyWith(
      imagePath: imagePath,
      status: Formz.validate([
        state.name,
        state.age,
        state.address,
        state.dormitory,
        state.birthDate,
        imagePath
      ]),
    ));
  }

  Future<String?> uploadImage() async {
    String? imageUrl;
    File _file = File(state.imagePath.value!);
    try {
      var storageRef = firebase_storage
          .FirebaseStorage.instance.ref('santri/${state.name.value}');
      await storageRef.putFile(_file);
      await storageRef.getDownloadURL().then((url) {
        imageUrl = url;
      });
    } on firebase_core.FirebaseException catch (e) {
      print(e.code);
    }
    print(imageUrl);
    return imageUrl;
  }

  Future<void> updateSantri() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      String? imageUrl;

      await uploadImage().then((value) {
        imageUrl = value;
        print("URL = $value");
      });

      await _santriRepository.createSantri(Santri(
          id: idSantri,
          name: state.name.value,
          age: state.age.value,
          address: state.address.value,
          dormitory: state.dormitory.value,
          birthDate: state.birthDate.value,
          imageUrl: imageUrl
      ));
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
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