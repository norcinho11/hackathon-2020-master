import 'package:ble_app/models/GuidePoint.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirestoreService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<GuidePoint>> queryBeacon(String uuid) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('guidepoints')
        .where('uid', isEqualTo: uuid)
        .get();

    List<GuidePoint> bleDevicesInfo = [];
    querySnapshot.docs.forEach((queryDocSnapshot) {
      bleDevicesInfo.add(GuidePoint(
        name: queryDocSnapshot['name'],
        beaconUuid: queryDocSnapshot['uid'],
        imageUrl: queryDocSnapshot['url'],
        description: queryDocSnapshot['description'],
        isLast: queryDocSnapshot['lastBeacon'],
        freeAccess: queryDocSnapshot['freeAccess'],
        pointType: PointType.values[(queryDocSnapshot['type'])],
      ));
    });
    return bleDevicesInfo;
  }
}
