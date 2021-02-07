import 'package:bade_wangsul/src/components/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'login_controller.dart';
import 'login_state.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _SignInForm(),
      ),
    );
  }
}

class _SignInForm extends StatefulWidget {
  @override
  __SignInFormState createState() => __SignInFormState();
}

class __SignInFormState extends State<_SignInForm> {
  final _controller = Get.put(LoginController());

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

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
                    onPressed: _controller.state is LoginLoading ? () {} : _onLoginButtonPressed,
                  ),
                  if (_controller.state is LoginFailure)
                    Text((_controller.state as LoginFailure).error,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Get.theme.errorColor
                      ),
                    ),
                  if (_controller.state is LoginLoading)
                    Center(child: CircularProgressIndicator(),)
                ],
              ),
            )
        ));
  }

  _onLoginButtonPressed() {
    if (_key.currentState.validate()) {
      _controller.login(_emailController.text, _passwordController.text);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}

