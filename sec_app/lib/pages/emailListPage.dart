import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resizable_container/flutter_resizable_container.dart';
import 'package:sec_app/components/emailView/emailView.dart';
import 'package:sec_app/components/emailView/leftSidebar.dart';
import 'package:sec_app/models/credential.dart';
import 'package:sec_app/state/auth.state.dart';

class EmailListPage extends StatefulWidget {
  const EmailListPage({super.key});

  @override
  State<EmailListPage> createState() => _EmailListPageState();
}

class _EmailListPageState extends State<EmailListPage> {
  late String selectedAccount;
  late Authenticated authenticatedState;

  @override
  void initState() {
    authenticatedState =
        context.read<AuthenticationBloc>().state as Authenticated;
    selectedAccount = authenticatedState.currentCredentials.first.username;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 40,
            child: Container(
              decoration: BoxDecoration(color: Colors.yellow),
              child: Row(
                children: [
                  DropdownButton<String>(
                    value: selectedAccount,
                    items: authenticatedState.currentCredentials
                        .map(
                          (x) => DropdownMenuItem<String>(
                            child: Text(x.username),
                            value: x.username,
                          ),
                        )
                        .toList(),
                    onChanged: (s) {
                      setState(() {
                        selectedAccount =
                            s ??
                            authenticatedState
                                .currentCredentials
                                .first
                                .username;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ResizableContainer(
              direction: Axis.horizontal,
              children: [
                ResizableChild(
                  child: LeftSidebar(selectedAccount: selectedAccount),
                  size: ResizableSize.expand(min: 200, max: 280),
                ),
                ResizableChild(
                  child: EmailView(),
                  size: ResizableSize.expand(min: 280, max: 320),
                ),
                ResizableChild(
                  child: Text(selectedAccount),
                  size: ResizableSize.expand(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
