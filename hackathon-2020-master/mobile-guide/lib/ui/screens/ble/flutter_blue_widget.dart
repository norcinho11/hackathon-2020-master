import 'package:ble_app/core/locator.dart';
import 'package:ble_app/models/GuidePoint.dart';
import 'package:ble_app/services/ble_service.dart';
import 'package:ble_app/ui/widgets/guide_point_grid_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlutterBlueWidget extends StatefulWidget {
  static const String route = '/flutter-blue-widget';

  @override
  _FlutterBlueWidgetState createState() => _FlutterBlueWidgetState();
}

class _FlutterBlueWidgetState extends State<FlutterBlueWidget> {
  // final FlutterBlue _flutterBlue = FlutterBlue.instance;

  final BLEService _bleService = locator<BLEService>();

  final TextEditingController _searchController = TextEditingController();

  List<GuidePoint> _scannedBeacons = [];
  String _nameSearch = '';
  bool _filtering = false;
  FocusNode _focusNode = FocusNode();
  bool _focused = false;


  void _updateBeacons(List<GuidePoint> guidePoints) {
    setState(() {});
    if (!_bleService.isScanning && guidePoints != null &&
        guidePoints.isNotEmpty)
      setState(() {
        _scannedBeacons = guidePoints;
      });
  }

  @override
  void initState() {
    super.initState();
    _bleService.addOnBeaconsUpdateListener(_updateBeacons);
    _doScan();

    _focusNode.addListener(() {
      setState(() {
        _focused = _focusNode.hasFocus;
        if (!_focused && _nameSearch.length == 0) _filtering = false;
      });
    });
  }


  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Widget body = Center(
    //   child: ListView(
    //     children: _buildBeaconsList(),
    //   ),
    // );

    Widget body = GuidePointGridWidget(
      guidePoints: _scannedBeacons.where(
            (element) => element.name.toLowerCase().contains(_nameSearch),
      ).toList(),
    );

    if (_filtering && _focused) {
      body = GestureDetector(
        onTap: _focusNode.unfocus,
        child: AbsorbPointer(child: body),
      );
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        backgroundColor: Colors.pink,
        onPressed: _doScan,
      ),
      appBar: AppBar(
        // centerTitle: true,
        leading: Icon(Icons.dehaze),
        // leadingWidth: 50,
        titleSpacing: 1,
        title: _filtering
            ? TextField(
          style: TextStyle(color: Colors.white),
          autofocus: true,
          focusNode: _focusNode,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(12),
            isDense: true,
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.white70),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(50))),
          ),
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              _nameSearch = value;
            });
          },
        )
            : Text('Guide Points'),
        actions: [
          if (!_filtering)
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () =>
                  setState(() {
                    _filtering = true;
                  }),
            ),
          if (_filtering)
            IconButton(
                icon: Icon(Icons.close_rounded),
                onPressed: () {
                  _searchController.text = '';
                  setState(() {
                    _filtering = false;
                    _nameSearch = '';
                  });
                })
        ],
      ),
      body: _bleService.isScanning
          ? Center(child: CircularProgressIndicator())
          : body,
    );
  }

  void _doScan() async {
    _bleService.scan(4);
  }
}