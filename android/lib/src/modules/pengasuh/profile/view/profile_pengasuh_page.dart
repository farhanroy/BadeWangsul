import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/usertype_manager.dart';
import '../../../../bloc/authentication.dart';
import '../../../../models/models.dart';
import '../../../../services/database/dao/users_dao.dart';

class ProfilePengasuhPage extends StatefulWidget {
  @override
  _ProfilePengasuhPageState createState() => _ProfilePengasuhPageState();
}

class _ProfilePengasuhPageState extends State<ProfilePengasuhPage> {
  late UsersDao _dao;

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
                  Navigator.pushNamed(context, "/pengasuh/profile/update");
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
              return _content(Pengasuh.fromJson(snapshot.data!));
            }

            return Center(child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }

  Widget _content(Pengasuh pengasuh) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: pengasuh.imageUrl != null ? CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(pengasuh.imageUrl!),
            ) : CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/img/default-profile.png')),
          ),
          SizedBox(height: 32,),

          Text("Name"),
          Text(pengasuh.name!),
          SizedBox(height: 16,),

          Text("Umur"),
          Text(pengasuh.age.toString()),
          SizedBox(height: 16,),

          Text("Alamat"),
          Text(pengasuh.address!),
          SizedBox(height: 16,),

          Text("Asrama"),
          Text(pengasuh.dormitory!),
          SizedBox(height: 16,),

          Text("Nomor Telepon"),
          Text(pengasuh.phoneNumber ?? ""),
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
