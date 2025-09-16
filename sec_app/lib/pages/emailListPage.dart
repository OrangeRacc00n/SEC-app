import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resizable_container/flutter_resizable_container.dart';
import 'package:sec_app/components/emailView/emailView.dart';
import 'package:sec_app/components/leftSidebar.dart';
import 'package:sec_app/models/credential.dart';
import 'package:sec_app/state/auth.state.dart';

class EmailListPage extends StatefulWidget {
  const EmailListPage({super.key});

  @override
  State<EmailListPage> createState() => _EmailListPageState();
}

class _EmailListPageState extends State<EmailListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResizableContainer(
        direction: Axis.horizontal,
        children: [
          ResizableChild(
            child: LeftSidebar(),
            size: ResizableSize.expand(min: 250, max: 400),
          ),
          ResizableChild(child: EmailView(), size: ResizableSize.expand()),
        ],
      ),
    );
  }
}
