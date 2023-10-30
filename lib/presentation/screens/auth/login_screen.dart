import 'package:csgo_copilot/application/auth/auth_bloc.dart';
import 'package:csgo_copilot/presentation/widgets/multi_circular_progress_indicator.dart';
import 'package:csgo_copilot/presentation/widgets/toast.dart';
import 'package:csgo_copilot/utils/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _controller = TextEditingController();
  AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = Injector.getIt<AuthBloc>();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          Toast.show(
            context,
            content: state.message,
            backgroundColor: Colors.redAccent[200],
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SafeArea(
              child: Column(
                children: [
                  Spacer(flex: 1),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: TextField(
                        controller: _controller,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: Theme.of(context).textTheme.headline5,
                        cursorColor: Theme.of(context).accentColor,
                        onEditingComplete: _onSubmit,
                        autocorrect: false,
                        decoration: InputDecoration(
                          hintText: 'Enter your Steam ID',
                          hintStyle:
                              Theme.of(context).textTheme.headline5.copyWith(
                                    color: Colors.white60,
                                  ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Center(
                      child: buildRaisedButton(state),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildRaisedButton(AuthState state) {
    if (state is AuthLoading)
      return MultiCircularProgressIndicator(
        baseRadius: 12,
      );

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).accentColor),
        shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        )),
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
      ),
      onPressed: _onSubmit,
      child: Container(
        height: MediaQuery.of(context).size.height * .09,
        width: MediaQuery.of(context).size.width * .5,
        child: Center(
          child: Text(
            'GO',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
    );
  }

  void _onSubmit() {
    FocusScope.of(context).unfocus();
    _authBloc.add(
      LogInWithSteamId(steamId: _controller.text),
    );
  }
}
