import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/authentication.dart';

import 'modules/signup/signup.dart';
import 'modules/login/login.dart';
import 'modules/pengasuh/dashboard/dashboard.dart';
import 'modules/pembina/pembina.dart';
import 'modules/splash/splash.dart';

import 'repository/authentication_repository/authentication_repository.dart';

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
        '/pengasuh': (context) => DashboardPengasuhPage(),
        '/pembina': (context) => DashboardPembinaPage(),
        '/pembina/izin/create': (context) => ManageIzinPage(),
        '/pembina/santri/create': (context) => CreateSantriPage(),
        '/pembina/santri/manage': (context) => ManageSantriPage(),
        '/pembina/santri/detail': (context) => DetailSantriPage(),
        '/pembina/profile': (context) => ProfilePembinaPage(),
      },
    );
  }
}
