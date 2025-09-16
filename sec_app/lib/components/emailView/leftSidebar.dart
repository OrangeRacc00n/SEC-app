import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sec_app/components/emailView/emailFolder.dart';
import 'package:sec_app/state/email.state.dart';

class LeftSidebar extends StatelessWidget {
  final String selectedAccount;
  const LeftSidebar({super.key, required this.selectedAccount});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: context.read<EmailBloc>(),
      builder: (context, state) {
        if (state is EmailStateOk) {
          return Column(
            children: [
              Row(children: [Expanded(child: Text("Sync"))]),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () =>
                          context.read<EmailBloc>().add(SyncEmail()),
                      child: Text("Sync"),
                    ),
                  ),
                ],
              ),
              ...((state.emails[selectedAccount])?.folders ?? [])
                  .map(
                    (x) => EmailFolder(
                      mailBox: x,
                      messages:
                          state.emails[selectedAccount]?.messages[x
                              .encodedName] ??
                          [],
                    ),
                  )
                  .toList(),
            ],
          );
        } else {
          return Text("BOOH");
        }
      },
    );
  }
}
