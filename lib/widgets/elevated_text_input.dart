import 'package:flutter/material.dart';

class ElevatedTextField extends StatelessWidget {
  final Widget child;
  const ElevatedTextField(this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.none,
      color: Colors.transparent,
      elevation: 12.0,
      shadowColor: Colors.black12,
      child: child,
    );
  }
}
