import 'package:ble_app/core/locator.dart';
import 'package:ble_app/models/GuidePoint.dart';
import 'package:ble_app/services/ble_service.dart';
import 'package:ble_app/ui/styles/spaces.dart';
import 'package:flutter/material.dart';

class GuidePointScreen extends StatefulWidget {
  static const String route = '/guide-point-screen';

  @override
  _GuidePointScreenState createState() => _GuidePointScreenState();
}

class _GuidePointScreenState extends State<GuidePointScreen> {
  final BLEService _bleService = locator<BLEService>();
  bool _init = false;
  GuidePoint guidePoint;
  bool _loading = false;

  void init() {
    setState(() {
      guidePoint = ModalRoute.of(context).settings.arguments;
    });
  }

  @override
  void didChangeDependencies() {
    if (!_init) {
      init();
      _init = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final GuidePoint guidePoint = ModalRoute.of(context).settings.arguments;
    print(guidePoint);
    return Scaffold(
      appBar: AppBar(
        title: Text(guidePoint.name),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      floatingActionButton: guidePoint.pointType == PointType.navigation
          ? RaisedButton(
        color: Colors.pink,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
              onPressed: guidePoint.isLast ? _close : _loadNextBeacon,
              child: Text(guidePoint.isLast ? 'ZRUŠIŤ' : 'SOM TU', style: TextStyle(fontSize: 20, color: Colors.white),),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
                // side: BorderSide(color: Colors.red),
              ),
            )
          : null,
      body: ListView(
        children: [
          if (guidePoint.imageUrl != null) Image.network(guidePoint.imageUrl),
          if (guidePoint.description != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Space.ver16,
                  Text(
                    'Popis:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Space.ver8,
                  Text(guidePoint.description),
                ],
              ),
            ),
          if (_loading) Center(child: CircularProgressIndicator()),
          // if (guidePoint.pointType == PointType.navigation)
          //   RaisedButton(
          //     onPressed: guidePoint.isLast ? () => _close : _loadNextBeacon,
          //     child: guidePoint.isLast ? Text('Zavrieť') : Text('Som Tu'),
          //   )
        ],
      ),
    );
  }

  void _loadNextBeacon() async {
    setState(() {
      _loading = true;
    });
    GuidePoint nearestGp = await _bleService.getNearestGuidePoint();
    if (nearestGp != null) {
      print(nearestGp.description);
      setState(() {
        guidePoint = nearestGp;
      });
    }
    setState(() {
      _loading = false;
    });
    _bleService.scan(4);
  }

  void _close() {
    Navigator.of(context).pop();
  }
}
