import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'package:latlong2/latlong.dart' as latlong;
import 'package:latlong2/latlong.dart';
import 'package:rafik/Controller/authcontroller.dart';
import 'package:rafik/Controller/locationsController.dart';
import 'package:rafik/Controller/ridescontroller.dart';
import 'package:rafik/Model/ride.dart';

import '../../../Helpers/translate_helper.dart';
import '../../Compenents/components.dart';
import '../../Compenents/theme.dart';
import '../UserPages/mapPage.dart';

class AddRidePage extends StatefulWidget {
  const AddRidePage({super.key});

  @override
  State<AddRidePage> createState() => _AddRidePageState();
}

class _AddRidePageState extends State<AddRidePage> {
  final _dateC = TextEditingController();
  final _timeC = TextEditingController();

  ///Date
  DateTime selected = DateTime.now();
  DateTime initial = DateTime(2000);
  DateTime last = DateTime(2025);

  ///Time
  TimeOfDay timeOfDay = TimeOfDay.now();
  TextEditingController departlocation = TextEditingController();
  TextEditingController destinationC = TextEditingController();
  // TextEditingController date = TextEditingController();
  TextEditingController seats = TextEditingController();
  TextEditingController price = TextEditingController();
  RidesController ridesController = Get.put(RidesController());
  Authcontroller authcontroller = Get.put(Authcontroller());
  LocationsController locationsController = Get.put(LocationsController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
              height: Get.height * 0.4, width: Get.width, child: flutterMap()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Container(  height: Get.height * 0.45,width: Get.width/2,color: Colors.amber,),

                const SizedBox(
                  height: 30,
                ),
                Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 10)
                    ]),
                    child: mytextField(
                        controller: departlocation,
                        label: getStatment('What is your current location?'))),
                const SizedBox(
                  height: 30,
                ),
                Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 10)
                    ]),
                    child: mytextField(
                        controller: destinationC,
                        label: getStatment('What is your destination?'))),
                const SizedBox(
                  height: 30,
                ),
                Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 10)
                    ]),
                    child: mytextField(
                        controller: price,
                        label: '${getStatment('Price')} DA')),
                const SizedBox(
                  height: 30,
                ),
                Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 10)
                    ]),
                    child: mytextField(
                        controller: seats,
                        label: '${getStatment('Number of seats available')}')),
                const SizedBox(
                  height: 30,
                ),

                //  mytextField(controller: date, label: 'Date'),
                ListView(
                  shrinkWrap: true,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            readOnly: true,
                            enabled: false,
                            controller: _dateC,
                            decoration: InputDecoration(
                                labelText: getStatment('Date'),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              backgroundColor: maincolor,
                            ),
                            onPressed: () => displayDatePicker(context),
                            child: const Icon(Iconsax.calendar)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _timeC,
                            decoration: InputDecoration(
                                labelText: getStatment('Time'),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: maincolor,
                                shape: CircleBorder()),
                            onPressed: () => displayTimePicker(context),
                            child: const Icon(Iconsax.clock)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 10)
                  ]),
                  child: mybutton(
                      bgcolor: maincolor,
                      ontap: () {
                        print('Creat New ride tapped');

                         print('${_dateC.text}-${_timeC.text}');
                        ridesController.addnewRide(
                            from: departlocation.text,
                            to: destinationC.text,
                            price: price.text,
                            date: '${_dateC.text} ${_timeC.text}',
                            seats: seats.text,
                            driver: authcontroller.driverProfile!,
                            startpoint: GeoPoint(
                                locationsController.currentPosition.latitude,
                                locationsController.currentPosition.longitude),
                            endpoint: GeoPoint(destenation!.point.latitude,
                                destenation!.point.longitude));
                      },
                      cntr: Text(
                        getStatment('Create new ride'),
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Marker? destenation = Marker(
    point: LatLng(36.071999, 4.7381114),
    builder: (context) {
      return Image.asset("assets/map2.png");
    },
  );
  List<LatLng> points = [];
  void getCoordinates(destenation) async {
    // Requesting for openrouteservice api
    var response = await http.get(getRouteUrl(
        "${locationsController.currentPosition.latitude},${locationsController.currentPosition.longitude}",
        '${destenation.latitude},${destenation.longitude}'));
    setState(() {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var listOfPoints = data['features'][0]['geometry']['coordinates'];
        points = listOfPoints
            .map((p) => LatLng(p[1].toDouble(), p[0].toDouble()))
            .toList();
      } else {
        Fluttertoast.showToast(
            msg: "This is Center Short Toast",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        print(response.body);
      }
    });
  }

  Widget flutterMap() {
    return FlutterMap(
      options: MapOptions(
        onTap: (tapPosition, point) async {
          String locName = await locationsController.getLocationName(
              point.latitude, point.longitude);
          setState(() {
            destenation = Marker(
              width: 40,
              height: 40,
              point: LatLng(point.latitude, point.longitude),
              builder: (context) {
                print("NEw Psition");
                return Image.asset(
                  "assets/map2.png",
                  fit: BoxFit.contain,
                );
              },
            );
            destinationC.text = locName;
          });
        },
        zoom: 10,
        center: latlong.LatLng(locationsController.currentPosition.latitude,
            locationsController.currentPosition.longitude),
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
            // Depart Marker
            Marker(
                point: LatLng(locationsController.currentPosition.latitude,
                    locationsController.currentPosition.longitude),
                width: 40,
                height: 40,
                builder: (context) => Image.asset(
                      "assets/map1.png",
                      fit: BoxFit.contain,
                    )),
            // Dest Marker
            destenation ?? destenation!,
          ],
        ),

        PolylineLayer(
          polylineCulling: false,
          polylines: [
            Polyline(points: points, color: Colors.lightBlue, strokeWidth: 20),
          ],
        ),
      ],
    );
  }

  Future displayDatePicker(BuildContext context) async {
    var date = await showDatePicker(
      context: context,
      initialDate: selected,
      firstDate: initial,
      lastDate: last,
    );

    if (date != null) {
      setState(() {
        _dateC.text = date.toLocal().toString().split(" ")[0];
      });
    }
  }

  Future displayTimePicker(BuildContext context) async {
    var time = await showTimePicker(context: context, initialTime: timeOfDay);

    if (time != null) {
      setState(() {
        _timeC.text = "${time.hour}:${time.minute}";
      });
    }
  }
}
