import 'package:flutter/material.dart';

class TermsAndConditionsTextButton extends StatelessWidget {
  const TermsAndConditionsTextButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text('Terms and conditions'),
      onPressed: () {},
      style: TextButton.styleFrom(
        primary: Colors.grey.shade600,
      ),
    );
  }
}
