import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EmailView extends StatefulWidget {
  const EmailView({super.key});

  @override
  State<EmailView> createState() => _EmailViewState();
}

class _EmailViewState extends State<EmailView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(decoration: BoxDecoration(color: Colors.green)),
        ),
      ],
    );
  }
}
