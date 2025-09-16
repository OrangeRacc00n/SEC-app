import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sec_app/state/email.state.dart';

class LeftSidebar extends StatelessWidget {
  const LeftSidebar({super.key});

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
              ...((state.emails["orangeraccoon@brohosoft.com"])?.folders ?? [])
                  .map((x) => Text(x.name))
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
