enum PointType {
  navigation,
  onePoint,
}

class GuidePoint {
  final String name;
  final String description;
  final String beaconUuid;
  final String imageUrl;
  final PointType pointType;
  final bool freeAccess;
  final bool isLast;

  GuidePoint({
    this.name,
    this.pointType,
    this.freeAccess,
    this.isLast,
    this.beaconUuid,
    this.imageUrl,
    this.description,
  });
}
