import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../widgets/appdialog.dart';
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
    return Scaffold(
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
        builder: (context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {

          if (snapshot.hasError) {
            return Center(child: Text("Something went wrong"));
          }

          if (snapshot.connectionState == ConnectionState.done){
            return _content(Pengasuh.fromJson(snapshot.data!), theme);
          }

          return Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }

  Widget _content(Pengasuh pengasuh, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: SingleChildScrollView(
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

            Text("Name", style: theme.textTheme.subtitle2,),
            Text(pengasuh.name!, style: theme.textTheme.subtitle1),
            SizedBox(height: 16,),

            Text("Umur", style: theme.textTheme.subtitle2),
            Text(pengasuh.age.toString(), style: theme.textTheme.subtitle1),
            SizedBox(height: 16,),

            Text("Alamat", style: theme.textTheme.subtitle2),
            Text(pengasuh.address!, style: theme.textTheme.subtitle1),
            SizedBox(height: 16,),

            Text("Asrama", style: theme.textTheme.subtitle2),
            Text(pengasuh.dormitory!, style: theme.textTheme.subtitle1),
            SizedBox(height: 16,),

            Text("Nomor Telepon", style: theme.textTheme.subtitle2),
            Text(pengasuh.phoneNumber ?? "", style: theme.textTheme.subtitle1),
            SizedBox(height: 32,),

            Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    primary: Theme.of(context).errorColor
                ),
                onPressed: (){
                  showConfirmationDialog(
                      context: context,
                      title: "Logout",
                      content: "Apakah anda akan logout ?",
                      onAccept: () async {
                        context.read<AuthenticationBloc>()
                            .add(AuthenticationLogoutRequested());
                        UsertypeManager.delete();
                        deleteUser();
                        Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
                      }
                  );
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
