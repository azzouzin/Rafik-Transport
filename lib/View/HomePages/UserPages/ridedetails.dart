import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rafik/Controller/ridescontroller.dart';

import '../../../Controller/locationsController.dart';
import '../../../Helpers/translate_helper.dart';
import '../../../Model/ride.dart';
import '../../Compenents/components.dart';
import '../../Compenents/theme.dart';
import 'mapPage.dart';

class RideDetails extends StatelessWidget {
  RideDetails({
    required this.closeContainer,
    required this.ride,
  });
  final closeContainer;
  final Ride ride;
  LocationsController locationsController = Get.find();
  RidesController ridesController = Get.find();

  final CameraPosition _initialPosition =
      const CameraPosition(target: LatLng(26.8206, 30.8025));

  Completer<GoogleMapController> _controller = Completer();

  final Set<Marker> markers = Set();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            getStatment("Book a ride"),
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          leading: IconButton(
            onPressed: closeContainer,
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
                  child: MapScreen(
                      endpoint: ride.endpoint!, startpoint: ride.startpoint!),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: SizedBox(
                    width: Get.width * 0.95,
                    height: Get.height * 0.03,
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
                        Text('${ride.from}', style: Get.textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: SizedBox(
                    width: Get.width * 0.95,
                    height: Get.height * 0.03,
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
                        Text('${ride.to}', style: Get.textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ),
                //CAr Details
                //Divider
                Padding(
                  padding: EdgeInsets.only(
                      left: Get.width * 0.05, right: Get.width * 0.05, top: 15),
                  child: const Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                ),

                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '${ride.driver!.carmodele}',
                      style: Get.textTheme.bodyLarge!
                          .copyWith(color: Colors.black),
                    )),
                //Divider
                Padding(
                  padding: EdgeInsets.only(
                      left: Get.width * 0.05, right: Get.width * 0.05, top: 15),
                  child: const Divider(
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
                              '${getStatment('Seats available')} : ${ride.seats}',
                              style: Get.textTheme.bodyMedium),
                        ),
                        //Locations
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.05, vertical: 10),
                          child: Text(
                              '${getStatment('Ride price')} : ${ride.price} DA',
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
                              ride.driver!.image!,
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                  ],
                ),
                //  SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.05, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('${getStatment('Phone number')} :',
                          style: Get.textTheme.bodyLarge),
                      Text(' ${ride.driver!.phone}',
                          style: Get.textTheme.bodyLarge),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: mybutton(
                    bgcolor: maincolor,
                    ontap: () {
                      print(ride.driver!.uid);

                      ridesController.hendPayment == true
                          ? ridesController.bookRide(ride, ride.seats!)
                          : Get.snackbar('Hand Payment',
                              'Please Select Hand pauyment for now Eldhahabia is comming soon');
                      ;
                    },
                    cntr: Text(
                      getStatment("Book a ride"),
                      style: Get.textTheme.headlineLarge,
                    ),
                  ),
                ),

                SizedBox(height: 25),
              ]),
        ),
      ),
    );
  }

  GoogleMap myMap() {
    return GoogleMap(
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(ride.startpoint!.latitude, ride.startpoint!.longitude),
        zoom: 14,
      ),
      markers: {
        Marker(
          markerId: MarkerId('Start'),
          position:
              LatLng(ride.startpoint!.latitude, ride.startpoint!.longitude),
        ),
        Marker(
          markerId: MarkerId('End'),
          position: LatLng(ride.endpoint!.latitude, ride.endpoint!.longitude),
        ),
      },
      mapType: MapType.normal,
    );
  }

  void showbottom(context) {
    showModalBottomSheet(
        backgroundColor: white,
        barrierColor: maincolor.withOpacity(0.2),
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
                    getStatment("Choose payment method"),
                    style: Get.textTheme.titleLarge!.copyWith(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    getStatment(
                        "You can pay hand to hand or with baridi mob, please select a choice"),
                    style: Get.textTheme.titleLarge!
                        .copyWith(fontSize: 15, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
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
                                ? maincolor
                                : null,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: maincolor)),
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
                                  getStatment("hand to hand"),
                                  style: Get.textTheme.titleLarge!
                                      .copyWith(fontSize: 15),
                                ),
                              ],
                            ),
                            Text(
                              getStatment("Pay Driver"),
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
                                : maincolor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: maincolor)),
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
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  mybutton(
                      bgcolor: maincolordarker,
                      ontap: () {
                        Get.back();
                      },
                      cntr: Text(
                        getStatment('Next'),
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
          );
        });
  }
}
