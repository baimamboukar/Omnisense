import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:omnisense/src/common/common.dart';

@RoutePage(
  name: 'googleAuth',
)
class GoogleAuthScreen extends StatelessWidget {
  const GoogleAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: OmnisenseButton(
              text: 'Sign in with Google',
              action: () {},
              //icon: FontAwesomeIcons.google,
            ),
          ),
        ],
      ),
    );
  }
}
