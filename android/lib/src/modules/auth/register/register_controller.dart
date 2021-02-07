import 'package:get/get.dart';

import '../auth.dart';

class RegisterController  extends GetxController {
  final AuthenticationController _authenticationController = Get.find();

  final _registerStateStream = RegisterState().obs;

  RegisterState get state => _registerStateStream.value;

  void register(String email, String password) async {
    _registerStateStream.value = RegisterLoading();

    try{
      await _authenticationController.signIn(email, password);
      _registerStateStream.value = RegisterState();
    } on AuthenticationException catch(e){
      _registerStateStream.value = RegisterFailure(error: e.message);
    }
  }
}