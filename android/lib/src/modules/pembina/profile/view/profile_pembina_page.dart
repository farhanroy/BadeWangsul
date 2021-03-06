import 'package:bade_wangsul/src/bloc/authentication.dart';
import 'package:bade_wangsul/src/services/database/dao/pembina_dao.dart';
import 'package:bade_wangsul/src/utils/usertype_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ProfilePembinaPage extends StatefulWidget {
  @override
  _ProfilePembinaPageState createState() => _ProfilePembinaPageState();
}

class _ProfilePembinaPageState extends State<ProfilePembinaPage> {
  UsersDao _dao;
  @override
  void initState() {
    super.initState();
    _dao = UsersDao();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Center(
              child: MaterialButton(
                onPressed: (){
                  context.read<AuthenticationBloc>()
                      .add(AuthenticationLogoutRequested());
                  UsertypeManager.delete();
                  deleteUser();
                  Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
                },
                child: Text("Logout"),
              ),
            )
          ],
        ),
      ),
    );
  }

  void deleteUser() async{
    await _dao.deleteUsers();
  }
}
