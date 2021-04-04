import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../services/repository/user_repository/user_repository.dart';
import '../cubit/update_profile_cubit.dart';
import 'update_profile_form.dart';

class UpdateProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.arrowLeft,
            color: theme.primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: BlocProvider<UpdateProfileCubit>(
          create: (_) => UpdateProfileCubit(UserRepository()),
          child: UpdateProfileForm(),
        ),
      ),
    );
  }
}
