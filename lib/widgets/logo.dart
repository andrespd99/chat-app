import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const [
          Image(
            image: AssetImage('assets/logo.png'),
            fit: BoxFit.cover,
            height: 100.0,
          ),
          SizedBox(height: 20.0),
          Text(
            'Woosh!',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
