import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class LocationsController extends GetxController {
  TextEditingController pickupEditingController = TextEditingController();
  TextEditingController destinationEditingController = TextEditingController();
  RxInt selectedlocation = 1000.obs;
  List<String> locations = [
    'Setif vill,Setif',
    'Ouad bibi,Skikda',
    'El eulma,Setif',
    'ain arnet,Setif',
  ];

  void changePickup(String locName) {
    pickupEditingController.text = locName;
    print(destinationEditingController.text);
  }

  void changeselctedlocation(index) {
    selectedlocation.value = index;
    destinationEditingController.text = locations[index];
    print(destinationEditingController.text);
  }

  void locationpermissions() async {
    var status = await Permission.locationWhenInUse.status;
    print("Status is $status");
    if (status != PermissionStatus.granted) {
      status = await Permission.locationWhenInUse.request().then((value) {
        print("Status is $value");

        return value;
      });
    } else {
      print('Permission garented');
    }
  }

  Future<String> getLocationName(double lat, double lng) async {
    final url =
        "https://nominatim.openstreetmap.org/reverse?lat=$lat&lon=$lng&format=json";
    final response = await http.get(Uri.parse(url));
    var myDataString = utf8.decode(response.bodyBytes);
    final data = jsonDecode(myDataString);
    print(data);
    final String locName = data['display_name'];

    // var decoded = utf8.decode(utf8.fuse(locName));

    //print(decoded);
    Get.snackbar('Your Location', locName);
    print(locName);
    return locName ?? 'null';
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    locationpermissions();
  }
}
