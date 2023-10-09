import 'dart:async';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rafik/Controller/Bindings/homepagebindings.dart';
import 'package:rafik/Controller/authcontroller.dart';
import 'package:rafik/Helpers/translate_helper.dart';
import 'package:rafik/View/Compenents/components.dart';

import '../../../Controller/locationsController.dart';
import 'profilepage.dart';
import 'homeContenet.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LocationsController locationsController = Get.find();
  Authcontroller authcontroller = Get.find();

  final CameraPosition _initialPosition =
      const CameraPosition(target: LatLng(26.8206, 30.8025));

  // Completer<GoogleMapController> _controller = Completer();

  final Set<Marker> markers = Set();

  /* void _onMapCreated(GoogleMapController controller) async {
    // _controller.complete(controller);

    Position position = await locationsController.getCurrentPosition();

    locationsController.pickupEditingController.text = await locationsController
        .getLocationName(position.latitude, position.longitude);
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Get.toNamed('/ridespage');
          },
          icon: Icon(
            EvaIcons.menu2,
            color: Colors.black,
          ),
        ),
        title: Row(
          children: [
            Text(
              getStatment("Hello!"),
              style: TextStyle(
                  fontWeight: FontWeight.w300, fontSize: Get.width * 0.06),
            ),
            Text(
              authcontroller.profile!.name!,
              overflow: TextOverflow.fade,
              style: TextStyle(
                  fontWeight: FontWeight.w500, fontSize: Get.width * 0.06),
            ),
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.to(ProfileScreen(), binding: Homebindings());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                Iconsax.setting,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: GetBuilder<LocationsController>(builder: (controller) {
        return controller.isloading == true
            ? Center(child: Loader())
            : SafeArea(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Get.height * 0.3,
                        width: Get.width,
                        child: GoogleMap(
                          markers: Set<Marker>.of(markers),
                          myLocationEnabled: true,
                          myLocationButtonEnabled: true,
                          onMapCreated: (controller) async {},
                          initialCameraPosition: _initialPosition,
                          mapType: MapType.normal,
                          gestureRecognizers:
                              <Factory<OneSequenceGestureRecognizer>>{
                            Factory<OneSequenceGestureRecognizer>(
                                () => EagerGestureRecognizer()),
                          }.toSet(),
                          onTap: (point) async {
                            // Get tapped coordinates
                            final lat = point.latitude;
                            final lng = point.longitude;
                            print("Lang = $lng");
                            print("lat = $lat");
                            // Add marker
                            Marker newMarker = Marker(
                                markerId:
                                    MarkerId(lat.toString() + lng.toString()),
                                position: LatLng(lat, lng));
                            // Set state to refresh map with new marker
                            setState(() {
                              // Add to markers set
                              markers.clear();
                              markers.add(newMarker);
                            });
                            String locName = await locationsController
                                .getLocationName(lat, lng);
                            locationsController.changePickup(locName);
                          },
                        ),
                      ),
                      //Contenent
                      HomeContenent(locationsController: locationsController),
                    ]),
              );
      }),
    );
  }
}
