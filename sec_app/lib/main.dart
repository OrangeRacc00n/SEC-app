import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sec_app/pages/addAccountPage.dart';
import 'package:sec_app/pages/emailListPage.dart';
import 'package:sec_app/pages/loadingPage.dart';
import 'package:sec_app/repository/authentication.repository.dart';
import 'package:sec_app/state/auth.state.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => AuthenticationBloc(
            authenticationrepository: AuthenticationRepository(),
          ),
        ),
      ],
      child: const MaterialApp(home: SecApp()),
    );
  }
}

class SecApp extends StatelessWidget {
  const SecApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationInitial || state is AuthLoading) {
          return LoadingPage();
        }
        if (state is Unauthenticated) {
          return AddAccountPage();
        }
        if (state is Authenticated) {
          return EmailListPage();
        }
        return Scaffold(body: Center(child: Text("HELO")));
      },
    );
  }
}
