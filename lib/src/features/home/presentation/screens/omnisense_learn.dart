import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage(
  name: 'omnisenseLearn',
)
class OmnisenseLearn extends StatelessWidget {
  const OmnisenseLearn({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Omnisense Learn'),
      ),
    );
  }
}
