import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sec_app/state/auth.state.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthenticationBloc>().add(CheckAccountEvent());
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
