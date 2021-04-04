import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../bloc/authentication.dart';
import '../../../../models/models.dart';
import '../../../../services/database/dao/users_dao.dart';
import '../../../../utils/usertype_manager.dart';
import '../../../../widgets/appdialog.dart';

class ProfileKeamananPage extends StatefulWidget {
  @override
  _ProfileKeamananPageState createState() => _ProfileKeamananPageState();
}

class _ProfileKeamananPageState extends State<ProfileKeamananPage> {
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
          icon: Icon(
            FontAwesomeIcons.arrowLeft,
            color: theme.primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              icon: Icon(FontAwesomeIcons.edit, color: theme.primaryColor),
              onPressed: () {
                Navigator.pushNamed(context, "/keamanan/profile/update");
              })
        ],
      ),
      body: FutureBuilder(
        future: _dao.readKeamanan(),
        builder: (context, AsyncSnapshot<Map<String, Object?>?> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Something went wrong"));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return _content(Keamanan.fromJson(snapshot.data!), theme);
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _content(Keamanan keamanan, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: keamanan.imageUrl != null
                  ? CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(keamanan.imageUrl!),
                    )
                  : CircleAvatar(
                      radius: 70,
                      backgroundImage:
                          AssetImage('assets/img/default-profile.png')),
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              "Name",
              style: theme.textTheme.subtitle2,
            ),
            Text(keamanan.name!, style: theme.textTheme.subtitle1),
            SizedBox(
              height: 16,
            ),
            Text("Umur", style: theme.textTheme.subtitle2),
            Text(keamanan.age.toString(), style: theme.textTheme.subtitle1),
            SizedBox(
              height: 16,
            ),
            Text("Alamat", style: theme.textTheme.subtitle2),
            Text(keamanan.address!, style: theme.textTheme.subtitle1),
            SizedBox(
              height: 16,
            ),
            Text("Nomor Telepon", style: theme.textTheme.subtitle2),
            Text(keamanan.phoneNumber ?? "", style: theme.textTheme.subtitle1),
            SizedBox(
              height: 32,
            ),
            Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    primary: Theme.of(context).errorColor),
                onPressed: () {
                  showConfirmationDialog(
                      context: context,
                      title: "Logout",
                      content: "Apakah anda akan logout ?",
                      onAccept: () async {
                        context
                            .read<AuthenticationBloc>()
                            .add(AuthenticationLogoutRequested());
                        UsertypeManager.delete();
                        deleteUser();
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/login", (route) => false);
                      });
                },
                child: Text("Logout"),
              ),
            )
          ],
        ),
      ),
    );
  }

  void deleteUser() async {
    await _dao.deleteUsers();
  }
}
