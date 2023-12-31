import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:latlong2/latlong.dart' as latlong;

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

import 'package:rafik/Controller/authcontroller.dart';
import 'package:rafik/Controller/locationsController.dart';
import 'package:rafik/Helpers/translate_helper.dart';
import 'package:rafik/View/Compenents/theme.dart';
import 'package:rafik/View/HomePages/DriverPages/add_Ride.dart';
import 'package:rafik/View/HomePages/DriverPages/userslistpage.dart';

import '../../../../Controller/ridescontroller.dart';
import '../../Compenents/components.dart';

import '../UserPages/mapPage.dart';
import 'DriverProfilePage.dart';
import 'driverridedetails.dart';

class DriverHomePage extends StatefulWidget {
  @override
  DriverHomePageState createState() => DriverHomePageState();
}

class DriverHomePageState extends State<DriverHomePage> {
  TextEditingController departlocation = TextEditingController();
  TextEditingController destinationC = TextEditingController();
  // TextEditingController date = TextEditingController();
  TextEditingController seats = TextEditingController();
  TextEditingController price = TextEditingController();
  var currentIndex = 0;
  RidesController ridesController = Get.find();
  Authcontroller authcontroller = Get.find();
  LocationsController locationsController = Get.find();

  String title = 'Your Upcoming Rides';
  @override
  Widget build(BuildContext context) {
    //locationsController.getCurrentPosition();
    departlocation.text = locationsController.departlocation;
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromARGB(255, 255, 251, 251),
          //extendBodyBehindAppBar: true,
          appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: maincolor,
              elevation: 5,
              centerTitle: true,
              title: Text(
                "${getStatment('Welcome back')} ${authcontroller.driverProfile!.name}",
                style: Get.textTheme.headlineLarge,
                // style: Get.textTheme.titleLarge!.copyWith(color: white),
              )),
          bottomNavigationBar: Container(
            color: white,
            height: size.width * .155,
            child: ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: size.width * .024),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = index;
                    if (currentIndex == 1) {
                      // ridesController.getUsersTochat();
                    }
                    title = currentIndex == 0
                        ? 'Your Upcoming Rides'
                        : currentIndex == 1
                            ? 'Messeges'
                            : currentIndex == 2
                                ? 'Add Ride'
                                : 'Profile';
                    // print(index);
                  });
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: SizedBox(
                  width: Get.width / 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: size.width * .014),
                      Icon(listOfIcons[index],
                          size: size.width * .076, color: maincolor),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 1500),
                        curve: Curves.fastLinearToSlowEaseIn,
                        margin: EdgeInsets.only(
                          top: index == currentIndex ? 0 : size.width * .029,
                          right: size.width * .0422,
                          left: size.width * .0422,
                        ),
                        width: size.width * .153,
                        height: index == currentIndex ? size.width * .014 : 0,
                        decoration: BoxDecoration(
                          color: maincolor,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: Stack(children: [
            bodycontenent(),
            GetBuilder<RidesController>(builder: (controller) {
              return controller.isloading == true
                  ? const Center(
                      child: Loader(),
                    )
                  : Container();
            }),
          ])),
    );
  }

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Iconsax.message,
    Iconsax.add,
    Icons.person_rounded,
  ];

  Center ridedetails2(int index) {
    return Center(
      child: OpenContainer(
        closedBuilder: (_, openContainer) {
          return Container(
            // height: Get.height * 0.2,
            width: Get.width / 3,
            padding: EdgeInsets.all(5),
            color: ridesController.searchedrides![index].seats == 0
                ? const Color.fromARGB(255, 255, 0, 85)
                : maincolor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: Get.height * 0.1,
                    width: Get.width * 0.3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        ridesController.searchedrides[index].driver!.image,
                        fit: BoxFit.cover,
                      ),
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                      width: Get.width,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Text(
                            'Date : ${ridesController.myRides[index].date}',
                            style: Get.textTheme.headlineLarge!.copyWith(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.fade),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Price : ${ridesController.myRides[index].price}',
                      style: Get.textTheme.headlineLarge!.copyWith(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.fade),
                    ),
                  ],
                )
              ],
            ),
          );
        },
        openColor: Colors.white,
        closedElevation: 5.0,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        closedColor: Colors.white,
        openBuilder: (_, closeContainer) {
          return DriverRideDetails(
            ride: ridesController.myRides[index],
            closeContainer: closeContainer,
          );
        },
      ),
    );
  }

  Center ridedetails(int index) {
    return Center(
      child: OpenContainer(
        closedBuilder: (_, openContainer) {
          return Container(
            // height: Get.height * 0.2,
            //width: Get.width * 0.95,
            padding: const EdgeInsets.all(5),
            color: ridesController.searchedrides![index].seats == 0
                ? const Color.fromARGB(255, 255, 0, 85)
                : maincolor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: Get.height * 0.14,
                    width: Get.width * 0.8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        ridesController.searchedrides[index].driver!.image,
                        fit: BoxFit.cover,
                      ),
                    )),
                SizedBox(
                  height: 15,
                  width: Get.width,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Text(
                        '${ridesController.searchedrides[index].from} - ${ridesController.searchedrides[index].to}',
                        style: Get.textTheme.headlineLarge!.copyWith(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.fade),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${getStatment('Date')} : ${ridesController.searchedrides[index].date}',
                  style: Get.textTheme.headlineLarge!.copyWith(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.fade),
                ),
                Text(
                  '${getStatment('Price')} : ${ridesController.searchedrides[index].price}',
                  style: Get.textTheme.headlineLarge!.copyWith(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.fade),
                ),
              ],
            ),
          );
        },
        openColor: maincolorlighter,
        closedElevation: 5.0,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        closedColor: Colors.white,
        openBuilder: (_, closeContainer) {
          return DriverRideDetails(
            ride: ridesController.searchedrides[index],
            closeContainer: closeContainer,
          );
        },
      ),
    );
  }

  Widget bodycontenent() {
    return GetBuilder<LocationsController>(builder: (locationsController) {
      return locationsController.isloading
          ? Center(
              child: Loader(),
            )
          : currentIndex == 0
              ? GetBuilder<RidesController>(builder: (ridecontrller) {
                  print(ridecontrller.myRides.length);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                        child: Text(getStatment('Your rides')),
                      ),
                      Container(
                        height: Get.height * 0.2,
                        width: Get.width,
                        child: ridesController.myRides.isEmpty
                            ? Center(
                                child: Column(
                                  children: [
                                    Container(
                                      width: Get.width * 0.4,
                                      height: Get.height * 0.15,
                                      child: Image.asset(
                                        "assets/img6.jpg",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      " Ooops You Have No Rides now ",
                                      style: Get.theme.textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                itemCount: ridesController.myRides.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ridedetails2(index));
                                },
                              ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                        child: Row(
                          children: [
                            Text(getStatment("All active rides")),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      Expanded(
                        child: GridView.builder(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ridedetails(index),
                            );
                          },
                          itemCount: ridecontrller.searchedrides.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                        ),
                      ),
                    ],
                  );
                })
              : currentIndex == 1
                  ? MessegePage()
                  : currentIndex == 2
                      ? AddRidePage()
                      : DriverProfileScreen();
    });
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
}
