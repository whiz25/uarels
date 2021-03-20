import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication/authentication_state.dart';
import '../blocs/blocs.dart';
import 'screens.dart';
import 'splash_screen.dart';

class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigatorState => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: _navigatorKey,
        theme: ThemeData(
            accentColor: Colors.cyan[700], primaryColor: Colors.cyan[700]),
        builder: (context, child) =>
            BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              _navigatorState.pushAndRemoveUntil<void>(
                  HomeScreen.route(), (route) => false);
            } else {
              _navigatorState.pushAndRemoveUntil<void>(
                  LogInScreen.route(), (route) => false);
            }
          },
          child: child,
        ),
        onGenerateRoute: (_) => SplashScreen.route(),
      );
}
