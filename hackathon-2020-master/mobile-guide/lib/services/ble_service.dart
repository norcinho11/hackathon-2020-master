import 'package:ble_app/core/locator.dart';
import 'package:ble_app/models/GuidePoint.dart';
import 'package:ble_app/services/firestore_service.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:ble_app/extensions/advertisement_data_extension.dart';
import 'package:injectable/injectable.dart';

// Nedokoncene
@LazySingleton(as: BLEService)
class BlueBLEService extends BLEService {
  final FlutterBlue _flutterBlue = FlutterBlue.instance;
  final FirestoreService _firestoreService = locator<FirestoreService>();
  bool _isScanning = false;

  @override
  bool get isScanning => _isScanning;

  @override
  Future<List<GuidePoint>> scan(int seconds) async {
    _isScanning = true;
    _lastScanned.clear();
    _notifyListeners();
    List<ScanResult> results = await _flutterBlue.startScan(
      timeout: Duration(seconds: seconds),
    );


    for (ScanResult r in results) {
      List<GuidePoint> guidePoints =
          await _firestoreService.queryBeacon(r.advertisementData.uuid);
      _lastScanned.addAll(guidePoints);
    }

    _isScanning = false;
    _notifyListeners();
    return [..._lastScanned];
  }

  @override
  Future<void> stopScan() async {
    await _flutterBlue.stopScan();
    _isScanning = false;
  }

  @override
  Future<GuidePoint> getNearestGuidePoint() async {
    _isScanning = true;
    _notifyListeners();
    List<ScanResult> results = await _flutterBlue.startScan(
      timeout: Duration(seconds: 4),
    );
    print('results:');
    print(results);
    if (results == null || results.isEmpty) return null;

    int higherRssi = -100;

    results.forEach((element) {
      if (element.rssi > higherRssi) higherRssi = element.rssi;
    });

    ScanResult result =
        results.where((element) => element.rssi == higherRssi).toList()[0];

    List<GuidePoint> guidePoints =
        await _firestoreService.queryBeacon(result.advertisementData.uuid);
    print('heree');
    _isScanning = false;
    _notifyListeners();
    return guidePoints.isEmpty ? null : guidePoints[0];
  }


}

abstract class BLEService {
  final List<Function> _listeners = [];
  final List<GuidePoint> _lastScanned = [];

  bool get isScanning;

  Future<dynamic> scan(int seconds);

  Future<void> stopScan();

  Future<GuidePoint> getNearestGuidePoint();

  static String beaconUuidFormat(String uuid) {
    print(uuid.length);
    print(uuid);
    String formattedUuid = uuid.substring(0, 8) +
        '-' +
        uuid.substring(8, 12) +
        '-' +
        uuid.substring(12, 16) +
        '-' +
        uuid.substring(16, 20) +
        '-' +
        uuid.substring(20, 32);

    return formattedUuid;
  }

  void addOnBeaconsUpdateListener(Function fun) {
    _listeners.add(fun);
  }

  void _notifyListeners() {
    for (Function fun in _listeners) {
      fun(_lastScanned);
    }
  }

}
