// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_beacon/flutter_beacon.dart';
//
// class FlutterBeaconWidget extends StatefulWidget {
//   @override
//   _FlutterBeaconWidgetState createState() => _FlutterBeaconWidgetState();
// }
//
// class _FlutterBeaconWidgetState extends State<FlutterBeaconWidget> {
//
//   StreamSubscription<RangingResult> _streamRanging;
//   final _regionBeacons = <Region, List<Beacon>>{};
//   final _beacons = <Beacon>[];
//
//   @override
//   void initState() {
//
//     super.initState();
//   }
//
//   initScanBeacon() async {
//     await flutterBeacon.initializeScanning;
//     final regions = <Region>[
//       Region(
//         identifier: 'Cubeacon',
//         proximityUUID: '91374D0A-FA8F-43AB-968B-88EAF83C6E4C',
//       ),
//     ];
//
//     if (_streamRanging != null) {
//       if (_streamRanging.isPaused) {
//         _streamRanging.resume();
//         return;
//       }
//     }
//
//     _streamRanging =
//         flutterBeacon.ranging(regions).listen((RangingResult result) {
//           print(result);
//           if (result != null && mounted) {
//             setState(() {
//               _regionBeacons[result.region] = result.beacons;
//               _beacons.clear();
//               _regionBeacons.values.forEach((list) {
//                 _beacons.addAll(list);
//               });
//             });
//           }
//         });
//   }
//   @override
//   void dispose() {
//     // _flutterBlue.stopScan();
//     _streamRanging.cancel();
//     flutterBeacon.close;
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('BLE test'),
//       ),
//       body: Center(
//         child: ListView(
//           children: <Widget>[
//             Text(
//               'Beacon info:',
//             ),
//             RaisedButton(onPressed: _refresh, child: Text('refresh'),),
//             ..._beacons
//                 .map((r) =>
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       Text('uuid: ${r.proximityUUID}, found! rssi: ${r.rssi}'),
//                       Text('$r'),
//                     ],
//                   ),
//                 ))
//                 .toList(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _refresh() async {
//
//   }
// }