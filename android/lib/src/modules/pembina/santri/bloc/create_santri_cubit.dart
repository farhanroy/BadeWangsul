import 'dart:io';

import 'package:bade_wangsul/src/models/santri.dart';
import 'package:bade_wangsul/src/repository/santri_repository/santri_repository.dart';
import 'package:bade_wangsul/src/utils/validator/default_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';

part 'create_santri_state.dart';

class CreateSantriCubit extends Cubit<CreateSantriState>{
  CreateSantriCubit(this._santriRepository ) : super(CreateSantriState());

  final SantriRepository _santriRepository;

  void nameChanged(String value) {
    final name = Default.dirty(value);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([
        name,
        state.age,
        state.address,
        state.dormitory,
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
        state.imagePath
      ]),
    ));
  }

  void imagePathChanged(String value) {
    final imagePath = Default.dirty(value);
    emit(state.copyWith(
      imagePath: imagePath,
      status: Formz.validate([
        state.name,
        state.age,
        state.address,
        state.dormitory,
        imagePath
      ]),
    ));
  }

  Future<String> uploadImage() async {
    String imageUrl;
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('santri/${state.name.value}}');
    UploadTask uploadTask = storageReference.putFile(File(state.imagePath.value));
    uploadTask
        .then((value){
      value.ref.getDownloadURL().then((url) {
        imageUrl = url;
      });
          print("Success Upload");
    })
        .catchError((e){
          print(e);
    });

    return imageUrl;
  }

  Future<void> createSantri() async {
    //if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      String imageUrl;

      uploadImage().then((value) {
        imageUrl = value;
      });

      await _santriRepository.createSantri(Santri(
          name: state.name.value,
          age: state.age.value,
          address: state.address.value,
          dormitory: state.dormitory.value,
          imagePath: imageUrl
      ));
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

}