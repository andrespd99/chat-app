import 'package:flutter/material.dart';

class TermsAndConditionsTextButton extends StatelessWidget {
  const TermsAndConditionsTextButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text('Términos y condiciones de uso'),
      onPressed: () {},
      style: TextButton.styleFrom(
        primary: Colors.grey.shade600,
      ),
    );
  }
}
