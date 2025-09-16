import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sec_app/state/auth.state.dart';

class AddAccountPage extends StatelessWidget {
  AddAccountPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController imapServerController = TextEditingController();
  final TextEditingController imapPortController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(100.0),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextField(
                  // orangeraccoon@brohosoft.com
                  controller: emailController,
                  decoration: InputDecoration(label: Text("Email")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(label: Text("Password")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextField(
                  controller: imapServerController,
                  decoration: InputDecoration(label: Text("IMAP")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextField(
                  controller: imapPortController,
                  decoration: InputDecoration(label: Text("Porta IMAP")),
                ),
              ),
              FilledButton(
                onPressed: () => context.read<AuthenticationBloc>().add(
                  AddAccountEvent(
                    emailController.text,
                    passwordController.text,
                    imapServerController.text,
                    int.parse(imapPortController.text),
                    true,
                  ),
                ),
                child: Text("Aggiungi account"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
