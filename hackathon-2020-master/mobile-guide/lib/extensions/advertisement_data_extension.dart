import 'package:flutter_blue/flutter_blue.dart';

extension UuidParsing on AdvertisementData {
  String get uuid {
    if (manufacturerData[76] == null) return '';
    if (manufacturerData[76].length < 17) return '';
    List<int> uuidList = manufacturerData[76].sublist(2, 16+2);
    String uuid = uuidList.map((e) => e.toRadixString(16).padLeft(2, '0')).join();
    return _beaconUuidFormat(uuid);
  }

  String _beaconUuidFormat(String uuid) {
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
}