import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:latlong2/latlong.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class MapScreen extends StatefulWidget {
  const MapScreen(
      {super.key, required this.startpoint, required this.endpoint});
  final GeoPoint startpoint;
  final GeoPoint endpoint;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Raw coordinates got from  OpenRouteService
  List listOfPoints = [];

  // Conversion of listOfPoints into LatLng(Latitude, Longitude) list of points
  List<LatLng> points = [];

  // Method to consume the OpenRouteService API
  getCoordinates() async {
    // Requesting for openrouteservice api
    var response = await http.get(getRouteUrl(
        "${widget.startpoint.latitude},${widget.startpoint.longitude}",
        '${widget.endpoint.latitude},${widget.endpoint.longitude}'));
    setState(() {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        listOfPoints = data['features'][0]['geometry']['coordinates'];
        points = listOfPoints
            .map((p) => LatLng(p[1].toDouble(), p[0].toDouble()))
            .toList();
      } else {
        Fluttertoast.showToast(
            msg: "Unable to get routs",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        print(response.body);
      }
    });
  }

//Get Current Location

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        FlutterMap(
          options: MapOptions(
            zoom: 10,
            center:
                LatLng(widget.startpoint.latitude, widget.startpoint.longitude),
          ),
          children: [
            // Layer that adds the map
            TileLayer(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            ),
            // Layer that adds points the map
            MarkerLayer(
              markers: [
                // First Marker
                Marker(
                  point: LatLng(
                      widget.startpoint.latitude, widget.startpoint.longitude),
                  width: 80,
                  height: 80,
                  builder: (context) => IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.location_on),
                    color: Colors.green,
                    iconSize: 45,
                  ),
                ),
                // Second Marker
                Marker(
                  point: LatLng(
                      widget.endpoint.latitude, widget.endpoint.longitude),
                  width: 80,
                  height: 80,
                  builder: (context) => IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.location_on),
                    color: Colors.red,
                    iconSize: 45,
                  ),
                ),
              ],
            ),

            // Polylines layer
            PolylineLayer(
              polylineCulling: false,
              polylines: [
                Polyline(
                    points: points, color: Colors.lightBlue, strokeWidth: 20),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: FloatingActionButton(
            backgroundColor: Colors.blueAccent,
            onPressed: () => getCoordinates(),
            child: const Icon(
              Icons.route,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

/// OPENROUTESERVICE DIRECTION SERVICE REQUEST
/// Parameters are : startPoint, endPoint and api key

const String baseUrl =
    'https://api.openrouteservice.org/v2/directions/driving-car';
const String apiKey =
    '5b3ce3597851110001cf6248e28bf45a088b4780a5a872104e4ab977';

getRouteUrl(String startPoint, String endPoint) {
  return Uri.parse('$baseUrl?api_key=$apiKey&start=$startPoint&end=$endPoint');
}
