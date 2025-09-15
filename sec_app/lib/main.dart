import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      child: const MaterialApp(
        home: Scaffold(body: Center(child: Text('Hello World!'))),
      ),
    );
  }
}
