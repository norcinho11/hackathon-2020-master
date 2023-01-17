class BLEDevice {
  final String uuid;

  BLEDevice(this.uuid);

  @override
  bool operator ==(Object other) {
    return other is BLEDevice ? this.uuid == other.uuid : false;
  }
}