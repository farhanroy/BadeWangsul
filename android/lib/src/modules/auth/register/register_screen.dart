import 'package:bade_wangsul/src/components/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: _RegisterForm(),
    ));
  }
}

class _RegisterForm extends StatefulWidget {
  @override
  __RegisterFormState createState() => __RegisterFormState();
}

class __RegisterFormState extends State<_RegisterForm> {

  final _controller = Get.put(RegisterController());

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        Form(
            key: _key,
            autovalidateMode: _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 206,),
                  CustomTextField(
                    inputType: InputType.Default,
                    hintTextString: "Username",
                    textEditController: _userNameController,
                    prefixIcon: Icon(Icons.person),
                  ),
                  SizedBox(height: 20,),
                  CustomTextField(
                    inputType: InputType.Email,
                    hintTextString: "Email",
                    textEditController: _emailController,
                    prefixIcon: Icon(Icons.email),
                  ),
                  SizedBox(height: 20,),
                  CustomTextField(
                    inputType: InputType.Password,
                    hintTextString: "Email",
                    textEditController: _passwordController,
                    prefixIcon: Icon(Icons.vpn_key_rounded),
                  ),
                  SizedBox(height: 32,),

                  // Button Login
                  RaisedButton(
                    color: Get.theme.primaryColor,
                    textColor: Get.theme.primaryColorLight,
                    padding: const EdgeInsets.all(16),
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
                    child: Text('Sign In'),
                    onPressed: _controller.state is RegisterLoading ? () {} : _onRegisterButtonPressed,
                  ),
                  if (_controller.state is RegisterFailure)
                    Text((_controller.state as RegisterFailure).error,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Get.theme.errorColor
                      ),
                    ),
                  if (_controller.state is RegisterLoading)
                    Center(child: CircularProgressIndicator(),)
                ],
              ),
            )
        ));
  }

  _onRegisterButtonPressed() {
    if (_key.currentState.validate()) {
      _controller.register(_emailController.text, _passwordController.text);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}

