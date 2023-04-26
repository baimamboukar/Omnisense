import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage(
  name: 'omnisenseDesiderata',
)
class OmnisenseDesiderata extends StatelessWidget {
  const OmnisenseDesiderata({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Omnisense OmnisenseDesiderata'),
      ),
    );
  }
}
