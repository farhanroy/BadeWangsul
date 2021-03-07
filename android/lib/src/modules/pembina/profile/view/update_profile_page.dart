import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'update_profile_form.dart';
import '../bloc/update_profile_cubit.dart';
import '../../../../services/repository/user_repository/user_repository.dart';

class UpdateProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider<UpdateProfileCubit>(
          create: (_) => UpdateProfileCubit(
            UserRepository()
          ),
          child: UpdateProfileForm(),
        ),
      ),
    );
  }
}
