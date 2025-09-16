import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LeftSidebar extends StatelessWidget {
  const LeftSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(decoration: BoxDecoration(color: Colors.red)),
        ),
      ],
    );
  }
}
