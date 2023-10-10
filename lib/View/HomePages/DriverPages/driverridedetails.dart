import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:latlong2/latlong.dart' as latlong;
import 'package:rafik/Controller/authcontroller.dart';
import 'package:rafik/Controller/ridescontroller.dart';
import 'package:rafik/Helpers/translate_helper.dart';

import '../../../../Controller/locationsController.dart';
import '../../../../Model/ride.dart';
import '../../Compenents/components.dart';
import '../../Compenents/theme.dart';
import '../UserPages/mapPage.dart';

class DriverRideDetails extends StatefulWidget {
  DriverRideDetails({
    required this.closeContainer,
    required this.ride,
  });
  final closeContainer;
  final Ride ride;

  @override
  State<DriverRideDetails> createState() => _DriverRideDetailsState();
}

class _DriverRideDetailsState extends State<DriverRideDetails> {
  final LocationsController locationsController = Get.find();

  final RidesController ridesController = Get.find();
  TextEditingController destinationC = TextEditingController();

  final Authcontroller authcontroller = Get.put(Authcontroller());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            getStatment("Ride details"),
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          leading: IconButton(
            onPressed: widget.closeContainer,
            icon: const Icon(Iconsax.arrow_left, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                    height: Get.height * 0.45,
                    width: Get.width,
                    child: flutterMap()),
                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: SizedBox(
                    height: 20,
                    width: Get.width,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Icon(
                          Iconsax.location,
                          color: pink,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('${widget.ride.from}',
                            style: Get.textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Icon(
                        Iconsax.location,
                        color: pink,
                      ),
                      Text('${widget.ride.to}',
                          style: Get.textTheme.bodyMedium),
                    ],
                  ),
                ),
                //CAr Details
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '${widget.ride.driver!.carmodele}',
                      style: Get.textTheme.bodyLarge!
                          .copyWith(color: Colors.black),
                    )),
                //Divider
                Padding(
                  padding: EdgeInsets.only(
                      left: Get.width * 0.05, right: Get.width * 0.05, top: 15),
                  child: Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: Get.width * 0.05,
                              right: Get.width * 0.05,
                              top: 15),
                          child: Text(
                              '${getStatment('Seats available')} : ${widget.ride.seats}',
                              style: Get.textTheme.bodyMedium),
                        ),
                        //Locations
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.05, vertical: 10),
                          child: Text(
                              '${getStatment('Ride price')} : ${widget.ride.price} DA',
                              style: Get.textTheme.bodyLarge),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.05, vertical: 10),
                      child: ClipOval(
                        child: SizedBox(
                            height: Get.width * 0.175,
                            width: Get.width * 0.175,
                            child: Image.network(
                              widget.ride.driver!.image,
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.only(
                      left: Get.width * 0.05, right: Get.width * 0.05, top: 0),
                  child: Text(
                      '${getStatment('Name')} : ${widget.ride.driver!.name!}',
                      style: Get.textTheme.bodyLarge!
                          .copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(
                  height: 25,
                ),

                authcontroller.driverProfile!.uid! == widget.ride.driver!.uid
                    ? Center(
                        child: mybutton(
                          bgcolor: pink,
                          ontap: () {
                            print(widget.ride.driver!.uid);
                            Get.dialog(AlertDialog(
                              title: const Text(
                                  "Are you sure you want to delete this ride?"),
                              actions: [
                                ElevatedButton(
                                  child: Text("Confirm"),
                                  onPressed: () {
                                    ridesController
                                        .deleteride(widget.ride.uid!);
                                    Get.toNamed("/driverhome");
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.pink),
                                ),
                                ElevatedButton(
                                  child: Text("Cancel"),
                                  onPressed: () {
                                    Get.back();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey),
                                )
                              ],
                            ));
                          },
                          cntr: Text(
                            "Delete Ride",
                            style: Get.textTheme.headlineLarge,
                          ),
                        ),
                      )
                    : Container(),

                SizedBox(height: 25),
              ]),
        ),
      ),
    );
  }

  void showbottom(context) {
    showModalBottomSheet(
        backgroundColor: white,
        barrierColor: lightgreen.withOpacity(0.2),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        )),
        context: context,
        builder: (context) {
          return Container(
            height: Get.height * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'chose payment method',
                    style: Get.textTheme.titleLarge!.copyWith(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'chose payment method you can pay hand to hand or even with baridi mob or visa card please select on choice and one only .',
                    style: Get.textTheme.titleLarge!
                        .copyWith(fontSize: 15, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GetBuilder<RidesController>(builder: (controller) {
                    return Expanded(
                        child: InkWell(
                      onTap: () {
                        controller.hendPayment == true
                            ? null
                            : controller.changepaymentMethod();
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: controller.hendPayment == true
                                ? lightgreen
                                : null,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: lightgreen)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                    width: 50,
                                    height: 40,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset('assets/hand.jpg'))),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'Hand to hand',
                                  style: Get.textTheme.titleLarge!
                                      .copyWith(fontSize: 15),
                                ),
                              ],
                            ),
                            Text(
                              'pay when you meet with the driver',
                              style: Get.textTheme.titleLarge!.copyWith(
                                fontSize: 15,
                                color: controller.hendPayment == true
                                    ? white
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ));
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  GetBuilder<RidesController>(builder: (controller) {
                    return Expanded(
                        child: InkWell(
                      onTap: () {
                        controller.hendPayment == false
                            ? null
                            : controller.changepaymentMethod();
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: controller.hendPayment == true
                                ? white
                                : lightgreen,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: lightgreen)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                    width: 50,
                                    height: 40,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset('assets/cart.png'))),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'El dhahabia',
                                  style: Get.textTheme.titleLarge!
                                      .copyWith(fontSize: 15),
                                ),
                              ],
                            ),
                            Text(
                              'pay with el dhahabia or cib',
                              style: Get.textTheme.titleLarge!.copyWith(
                                fontSize: 15,
                                color: controller.hendPayment == false
                                    ? white
                                    : Colors.grey,
                              ),
                            ),
                            //
                          ],
                        ),
                      ),
                    ));
                  })
                ],
              ),
            ),
          );
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
}
