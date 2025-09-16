import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sec_app/models/credential.dart';
import 'package:sec_app/models/emailInfo.dart';
import 'package:sec_app/state/auth.state.dart';
import 'package:sec_app/state/email.state.dart';

class EmailView extends StatefulWidget {
  const EmailView({super.key});

  @override
  State<EmailView> createState() => _EmailViewState();
}

class _EmailViewState extends State<EmailView> {
  @override
  Widget build(BuildContext context) {
    List<Credential> crds = context
        .read<AuthenticationBloc>()
        .state
        .currentCredentials;

    Map<String, Emailinfo> test = context.read<EmailBloc>().state.emails;
    return Column(children: [
        
      ],
    );
  }
}
