import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:omnisense/src/extensions/num.dart';

@RoutePage(
  name: 'omnisenseLearn',
)
class OmnisenseLearn extends StatefulWidget {
  const OmnisenseLearn({super.key});

  @override
  State<OmnisenseLearn> createState() => _OmnisenseLearnState();
}

class _OmnisenseLearnState extends State<OmnisenseLearn>
    with SingleTickerProviderStateMixin {
  late AnimationController _radarController;
  late FlutterBluePlus flutterBlue;
  @override
  void initState() {
    super.initState();
    flutterBlue = FlutterBluePlus.instance;
    _radarController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20))
          ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    // Start scanning
    flutterBlue.startScan(timeout: const Duration(seconds: 4));

// Listen to scan results
    final subscription = flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (final r in results) {
        print('${r.device.name} found! rssi: ${r.rssi}');
      }
    });
    return Scaffold(
      body: Column(
        children: [
          34.vGap,
          StreamBuilder<ScanResult>(
            stream: flutterBlue.scan(
              timeout: const Duration(minutes: 5),
            ),
            builder: (
              BuildContext context,
              AsyncSnapshot<ScanResult> snapshot,
            ) {
              if (snapshot.hasData) {
                return Text('Device found: ${snapshot.data!.device.name}');
              } else {
                return const Text('Scanning');
              }
            },
          ),
          Expanded(
            child: RotationTransition(
              turns: Tween<double>(begin: 0, end: 4).animate(_radarController),
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: SweepGradient(
                    stops: [.2, .25, .2],
                    colors: [
                      Colors.transparent,
                      Colors.blue,
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Center(
                  child: CircleAvatar(
                    child: Center(child: Icon(Hicons.profile_1)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
