import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/authentication.dart';

import 'modules/signup/signup.dart';
import 'modules/login/login.dart';
import 'modules/pengasuh/pengasuh.dart' as pengasuh;
import 'modules/keamanan/keamanan.dart' as keamanan;
import 'modules/pembina/pembina.dart';
import 'modules/splash/splash.dart';

import 'services/repository/authentication_repository/authentication_repository.dart';

import 'utils/theme.dart';

class App extends StatelessWidget {
  const App({
    Key key,
    @required this.authenticationRepository,
  })  : assert(authenticationRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
        ),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      navigatorKey: _navigatorKey,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),

        '/pembina': (context) => DashboardPembinaPage(),
        '/pembina/profile/complete': (context) => CompleteProfilePage(),
        '/pembina/izin/manage': (context) => ManageIzinPage(),
        '/pembina/izin/create': (context) => CreateIzinPage(),
        '/pembina/santri/create': (context) => CreateSantriPage(),
        '/pembina/santri/manage': (context) => ManageSantriPage(),
        '/pembina/santri/detail': (context) => DetailSantriPage(),
        '/pembina/profile': (context) => ProfilePembinaPage(),
        '/pembina/profile/update': (context) => UpdateProfilePage(),

        '/pengasuh': (context) => pengasuh.DashboardPengasuhPage(),
        '/pengasuh/izin/manage': (context) => pengasuh.ListIzinPage(),
        '/pengasuh/profile/complete': (context) => pengasuh.CompleteProfilePage(),
        '/pengasuh/profile': (context) => pengasuh.ProfilePengasuhPage(),
        '/pengasuh/profile/update': (context) => pengasuh.UpdateProfilePage(),

        '/keamanan': (context) => keamanan.DashboardKeamananPage(),
        '/keamanan/profile/complete': (context) => keamanan.CompleteProfilePage(),
        '/keamanan/profile': (context) => keamanan.ProfileKeamananPage(),
        '/keamanan/profile/update': (context) => keamanan.UpdateProfilePage(),
      },
    );
  }
}
