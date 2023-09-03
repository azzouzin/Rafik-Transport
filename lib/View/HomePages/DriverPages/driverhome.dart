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
import 'package:rafik/View/Compenents/theme.dart';
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
              backgroundColor: lightgreen,
              elevation: 5,
              centerTitle: false,
              title: Text(
                "Welcome back ${authcontroller.driverProfile!.name}",
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
                          size: size.width * .076, color: lightgreen),
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
                          color: lightgreen,
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
            GetBuilder<RidesController>(builder: (controller) {
              return controller.isloading == true
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container();
            }),
            bodycontenent(),
            GetBuilder<RidesController>(builder: (controller) {
              return controller.isloading == true
                  ? Center(
                      child: CircularProgressIndicator(),
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
                : lightgreen,
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
                            'Date : ${ridesController.searchedrides[index].date}',
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
                      'Price : ${ridesController.searchedrides[index].price}',
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
            ride: ridesController.searchedrides[index],
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
                : lightgreen,
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
                  'Date : ${ridesController.searchedrides[index].date}',
                  style: Get.textTheme.headlineLarge!.copyWith(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.fade),
                ),
                Text(
                  'Price : ${ridesController.searchedrides[index].price}',
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
        openColor: Colors.lightGreen,
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

  Widget addridepage() {
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
                        controller: departlocation, label: 'Depart Location')),
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
                        label: 'Destination Location')),
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
                    child: mytextField(controller: price, label: 'Price DA')),
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
                        controller: seats, label: 'Number Of Seats Available')),
                const SizedBox(
                  height: 30,
                ),
                //  mytextField(controller: date, label: 'Date'),

                Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 10)
                  ]),
                  child: mybutton(
                      ontap: () {
                        print('Creat New ride tapped');

                        DateTime now = DateTime.now();

                        DateFormat yearFormat = DateFormat('yyyy');
                        DateFormat monthFormat = DateFormat('MM');
                        DateFormat dayFormat = DateFormat('dd');
                        DateFormat hourFormat = DateFormat('HH');
                        DateFormat minuteFormat = DateFormat('mm');

                        String year = yearFormat.format(now);
                        String month = monthFormat.format(now);
                        String day = dayFormat.format(now);
                        String hour = hourFormat.format(now);
                        String minute = minuteFormat.format(now);

                        print('$year-$month-$day $hour:$minute');
                        ridesController.addnewRide(
                            from: departlocation.text,
                            to: destinationC.text,
                            price: price.text,
                            date: '$month-$day $hour:$minute',
                            seats: seats.text,
                            driver: authcontroller.driverProfile!,
                            startpoint: GeoPoint(
                                locationsController.currentPosition.latitude,
                                locationsController.currentPosition.longitude),
                            endpoint: GeoPoint(destenation!.point.latitude,
                                destenation!.point.longitude));
                      },
                      cntr: Text('Creat New Ride')),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bodycontenent() {
    return GetBuilder<LocationsController>(builder: (locationsController) {
      return locationsController.isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : currentIndex == 0
              ? GetBuilder<RidesController>(builder: (ridecontrller) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                        child: Text('Your Rides'),
                      ),
                      Container(
                        height: Get.height * 0.2,
                        width: Get.width,
                        child: ListView.builder(
                          itemCount: ridesController.searchedrides.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return (ridesController
                                        .searchedrides[index].driver!.uid! ==
                                    authcontroller.driverProfile!.uid!)
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ridedetails2(index))
                                : Container();
                          },
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                        child: Row(
                          children: [
                            Text('All Active Rides'),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      Expanded(
                        child: GridView.builder(
                          //       padding: EdgeInsets.symmetric(horizontal: 10),

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
                      ? addridepage()
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
