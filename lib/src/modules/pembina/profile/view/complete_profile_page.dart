import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../services/repository/user_repository/user_repository.dart';
import '../bloc/complete_profile_cubit.dart';
import 'complete_profile_form.dart';

class CompleteProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<CompleteProfileCubit>(
        create: (_) => CompleteProfileCubit(UserRepository()),
        child: CompleteProfileForm(),
      ),
    );
  }
}
