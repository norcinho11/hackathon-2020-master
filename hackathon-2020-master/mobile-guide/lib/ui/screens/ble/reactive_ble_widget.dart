// import 'package:flutter/material.dart';
// import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
//
// class ReactiveBLE extends StatefulWidget {
//   @override
//   _ReactiveBLEState createState() => _ReactiveBLEState();
// }
//
// class _ReactiveBLEState extends State<ReactiveBLE> {
//   FlutterReactiveBle _ble = FlutterReactiveBle();
//
//
//   @override
//   void initState() {
//     super.initState();
//
//     _ble.scanForDevices(withServices: [], scanMode: ScanMode.lowLatency).listen((device) {
//       print(device);
//     });
//   }
//
//
//   @override
//   void dispose() {
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
//             // ..._beacons
//             //     .map((r) =>
//             //     Padding(
//             //       padding: const EdgeInsets.all(8.0),
//             //       child: Column(
//             //         children: [
//             //           Text('uuid: ${r.proximityUUID}, found! rssi: ${r.rssi}'),
//             //           Text('$r'),
//             //         ],
//             //       ),
//             //     ))
//             //     .toList(),
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