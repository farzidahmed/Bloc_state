import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class TomTomMap extends StatelessWidget {
  const TomTomMap({super.key});

  final String apiKey = "JnprDIwtsdRGria1nmHVey2Ofh8bn4PG";

  @override
  Widget build(BuildContext context) {
    final tomtomHQ = LatLng(52.376372, 4.908066);

    return Scaffold(
      appBar: AppBar(title: const Text("TomTom Map")),
      body: FlutterMap(
        options: MapOptions(initialCenter: tomtomHQ, initialZoom: 13),
        children: [
          TileLayer(
            urlTemplate:
                "https://api.tomtom.com/map/1/tile/basic/main/{z}/{x}/{y}.png?key=$apiKey",
            userAgentPackageName: 'com.example.app',
          ),
        ],
      ),
    );
  }
}
