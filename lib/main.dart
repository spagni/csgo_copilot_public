import 'package:csgo_copilot/application/auth/auth_bloc.dart';
import 'package:csgo_copilot/presentation/screens/splash_screen.dart';
import 'package:csgo_copilot/utils/analytics_helper.dart';
import 'package:csgo_copilot/utils/app.dart';
import 'package:csgo_copilot/utils/di.dart';
import 'package:csgo_copilot/utils/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Preferences.initPrefs();
  await Firebase.initializeApp();
  Injector.init();

  // Loggeo el primer evento
  Injector.getIt<AnalyticsHelper>().logAppOpen();

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => Injector.getIt<AuthBloc>()
        ..add(
          AuthStatusRequested(),
        ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Constants.appTitle,
        theme: Themes.dark,
        home: SplashScreen(),
      ),
    );
  }
}
