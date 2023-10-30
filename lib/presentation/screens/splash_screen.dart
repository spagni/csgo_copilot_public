import 'package:csgo_copilot/application/auth/auth_bloc.dart';
import 'package:csgo_copilot/presentation/screens/auth/login_screen.dart';
import 'package:csgo_copilot/presentation/screens/home/home_screen.dart';
import 'package:csgo_copilot/presentation/widgets/multi_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is AuthError) {
        print(state.message);
      }
    }, builder: (context, state) {
      if (state is AuthInitial)
        return Scaffold(
          body: Center(
            child: MultiCircularProgressIndicator(),
          ),
        );

      if (state is Authorized) return HomeScreen();

      return LoginScreen();
    });
  }
}
