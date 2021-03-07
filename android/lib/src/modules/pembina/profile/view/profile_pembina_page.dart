import 'package:bade_wangsul/src/bloc/authentication.dart';
import 'package:bade_wangsul/src/models/models.dart';
import 'package:bade_wangsul/src/services/database/dao/pembina_dao.dart';
import 'package:bade_wangsul/src/utils/theme.dart';
import 'package:bade_wangsul/src/utils/usertype_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                onPressed: null
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
              return _content(Pembina.fromJson(snapshot.data));
            }

            return Center(child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }

  Widget _content(Pembina pembina) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: pembina.imageUrl != null ? CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(pembina.imageUrl),
            ) : CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('assets/img/default-profile.png')),
          ),
          SizedBox(height: 32,),

          Text("Name"),
          Text(pembina.name),
          SizedBox(height: 16,),

          Text("Umur"),
          Text(pembina.age),
          SizedBox(height: 16,),

          Text("Alamat"),
          Text(pembina.address),
          SizedBox(height: 16,),

          Text("Asrama"),
          Text(pembina.dormitory),
          SizedBox(height: 16,),

          Text("Nomor Telepon"),
          Text(pembina.phoneNumber ?? ""),
          SizedBox(height: 16,),

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
    );
  }

  void deleteUser() async{
    await _dao.deleteUsers();
  }
}
