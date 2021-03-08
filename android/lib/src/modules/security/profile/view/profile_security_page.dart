import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../bloc/authentication.dart';
import '../../../../models/security.dart';
import '../../../../services/database/dao/users_dao.dart';
import '../../../../utils/usertype_manager.dart';

class ProfileSecurityPage extends StatefulWidget {
  @override
  _ProfileSecurityPageState createState() => _ProfileSecurityPageState();
}

class _ProfileSecurityPageState extends State<ProfileSecurityPage> {
  UsersDao _dao;
  @override
  void initState() {
    super.initState();
    _dao = UsersDao();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft, color: theme.primaryColor,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
                icon: Icon(FontAwesomeIcons.edit, color: theme.primaryColor),
                onPressed: (){
                  Navigator.pushNamed(context, "/security/profile/update");
                }
            )
          ],
        ),
        body: FutureBuilder(
          future: _dao.readPembina(),
          builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {

            if (snapshot.hasError) {
              return Center(child: Text("Something went wrong"));
            }

            if (snapshot.connectionState == ConnectionState.done){
              return _content(Security.fromJson(snapshot.data));
            }

            return Center(child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }

  Widget _content(Security security) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: security.imageUrl != null ? CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(security.imageUrl),
            ) : CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/img/default-profile.png')),
          ),
          SizedBox(height: 32,),

          Text("Name"),
          Text(security.name),
          SizedBox(height: 16,),

          Text("Umur"),
          Text(security.age.toString()),
          SizedBox(height: 16,),

          Text("Alamat"),
          Text(security.address),
          SizedBox(height: 16,),

          Text("Pos"),
          Text(security.pos.toString()),
          SizedBox(height: 16,),

          Text("Nomor Telepon"),
          Text(security.phoneNumber ?? ""),
          SizedBox(height: 16,),

          Center(
            child: MaterialButton(
              onPressed: (){
                context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested());
                UsertypeManager.delete();
                deleteUser();
                Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
              },
              child: Text("Logout"),
            ),
          )
        ],
      ),
    );
  }

  void deleteUser() async{
    await _dao.deleteUsers();
  }
}