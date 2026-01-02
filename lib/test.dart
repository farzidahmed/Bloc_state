// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:location/location.dart';

// class TomTomMapScreen extends StatefulWidget {
//   const TomTomMapScreen({super.key});

//   @override
//   State<TomTomMapScreen> createState() => _TomTomMapScreenState();
// }

// class _TomTomMapScreenState extends State<TomTomMapScreen> {
//   /// 🔑 TomTom API KEY (এখানে তোমার key বসাও)
//   final String tomTomApiKey = "VYg4RrR7Gybw4aSaM48O172n8Ygzii2i";

//   GoogleMapController? _mapController;
//   final Location _location = Location();

//   LatLng? _currentLocation;
//   final LatLng _destination = const LatLng(23.8103, 90.4125); // Example: Dhaka

//   Set<Polyline> _polylines = {};

//   @override
//   void initState() {
//     super.initState();
//     _getUserLocation();
//   }

//   /// 📍 Get current user location
//   Future<void> _getUserLocation() async {
//     bool serviceEnabled = await _location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await _location.requestService();
//     }

//     PermissionStatus permission = await _location.hasPermission();
//     if (permission == PermissionStatus.denied) {
//       permission = await _location.requestPermission();
//     }

//     final loc = await _location.getLocation();

//     setState(() {
//       _currentLocation = LatLng(loc.latitude!, loc.longitude!);
//     });

//     _fetchTomTomRoute();
//   }

//   /// 🚗 Fetch Route from TomTom (with traffic)
//   Future<void> _fetchTomTomRoute() async {
//     if (_currentLocation == null) return;

//     final url =
//         "https://api.tomtom.com/routing/1/calculateRoute/"
//         "${_currentLocation!.latitude},${_currentLocation!.longitude}:"
//         "${_destination.latitude},${_destination.longitude}/json"
//         "?traffic=true&travelMode=car&routeType=fastest"
//         "&key=$tomTomApiKey";

//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);

//       final points = data['routes'][0]['legs'][0]['points'];

//       List<LatLng> routePoints = points.map<LatLng>((p) {
//         return LatLng(p['latitude'], p['longitude']);
//       }).toList();

//       setState(() {
//         _polylines = {
//           Polyline(
//             polylineId: const PolylineId("tomtom_route"),
//             color: Colors.red, // Traffic route
//             width: 5,
//             points: routePoints,
//           ),
//         };
//       });
//     } else {
//       debugPrint("TomTom API error");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("TomTom Traffic Route"),
//         backgroundColor: Colors.red,
//       ),
//       body: _currentLocation == null
//           ? const Center(child: CircularProgressIndicator())
//           : GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target: _currentLocation!,
//                 zoom: 14,
//               ),
//               myLocationEnabled: true,
//               polylines: _polylines,
//               markers: {
//                 Marker(
//                   markerId: const MarkerId("start"),
//                   position: _currentLocation!,
//                   infoWindow: const InfoWindow(title: "Start"),
//                 ),
//                 Marker(
//                   markerId: const MarkerId("end"),
//                   position: _destination,
//                   infoWindow: const InfoWindow(title: "Destination"),
//                 ),
//               },
//               onMapCreated: (controller) {
//                 _mapController = controller;
//               },
//             ),
//     );
//   }
// }
