import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rafik/Controller/authcontroller.dart';
import 'package:rafik/Model/driver.dart';
import 'package:rafik/Model/ride.dart';
import 'package:rafik/View/Compenents/theme.dart';

import '../Model/user.dart';
import '../View/HomePages/UserPages/chatpage.dart';

class RidesController extends GetxController {
  bool isloading = false;
  var hendPayment = true;
  List<Ride> searchedrides = [
    Ride(
      from: 'Algeria',
      to: "Setif",
      price: '1000',
      date: DateTime.now().month.toString(),
      seats: 4,
      totalSeats: 4,
      driver: Driver(
          isDriver: true,
          uid: 'fHmX5f4GgaelG9bRR87viOotkak1',
          carmodele: 'picanto 2012',
          email: 'azzouz@gmail.com',
          phone: "0562413935",
          name: 'azzouz',
          rating: '1',
          image:
              'https://img.freepik.com/psd-gratuit/illustration-3d-personne-lunettes-soleil-cheveux-verts_23-2149436201.jpg?w=740&t=st=1690473822~exp=1690474422~hmac=fa024e8d7501f866eb9c6a5049f82d755c79701b6ccaa8e4cb458d3034b73ce3'),
    ),
    Ride(
      from: 'Ourgla',
      to: "Mila",
      price: '700',
      date: DateTime.now().month.toString(),
      seats: 4,
      totalSeats: 4,
      driver: Driver(
          isDriver: true,
          email: 'azzouzmerouani@gmail.com',
          uid: '45881632jusckmcl',
          phone: "0562413935",
          carmodele: 'Symbole',
          name: 'Akedkad',
          rating: '5.0',
          image:
              "https://img.freepik.com/psd-gratuit/illustration-3d-personne-lunettes-soleil_23-2149436188.jpg?w=740&t=st=1690473670~exp=1690474270~hmac=48da6f35f154f9d57e3e27d4cf96c1c53d653393278091564791de9faaa9a33d"),
    ),
    Ride(
      from: 'Algeria',
      to: "Setif",
      price: '1000',
      date: DateTime.now().month.toString(),
      seats: 4,
      totalSeats: 4,
      driver: Driver(
          isDriver: true,
          phone: "0562413935",
          email: 'azzouzmerouani@gmail.com',
          uid: '45881632jusckmcl',
          carmodele: 'picanto',
          name: 'Ahmed amrani',
          rating: '3.5',
          image:
              'https://img.freepik.com/psd-gratuit/illustration-3d-personne-lunettes-soleil_23-2149436180.jpg?w=740&t=st=1690473860~exp=1690474460~hmac=09877664ae7a857fed98477c4b733e68feeaabb05a6ef9507a39f2d65116b237'),
    ),
  ].obs;
  List<Ride> myRides = [
    Ride(
      from: 'Algeria',
      to: "Setif",
      price: '1000',
      date: DateTime.now().month.toString(),
      seats: 4,
      totalSeats: 4,
      driver: Driver(
          isDriver: true,
          uid: 'fHmX5f4GgaelG9bRR87viOotkak1',
          carmodele: 'picanto 2012',
          email: 'azzouz@gmail.com',
          phone: "0562413935",
          name: 'azzouz',
          rating: '1',
          image:
              'https://img.freepik.com/psd-gratuit/illustration-3d-personne-lunettes-soleil-cheveux-verts_23-2149436201.jpg?w=740&t=st=1690473822~exp=1690474422~hmac=fa024e8d7501f866eb9c6a5049f82d755c79701b6ccaa8e4cb458d3034b73ce3'),
    ),
    Ride(
      from: 'Ourgla',
      to: "Mila",
      price: '700',
      date: DateTime.now().month.toString(),
      seats: 4,
      totalSeats: 4,
      driver: Driver(
          isDriver: true,
          email: 'azzouzmerouani@gmail.com',
          uid: '45881632jusckmcl',
          phone: "0562413935",
          carmodele: 'Symbole',
          name: 'Akedkad',
          rating: '5.0',
          image:
              "https://img.freepik.com/psd-gratuit/illustration-3d-personne-lunettes-soleil_23-2149436188.jpg?w=740&t=st=1690473670~exp=1690474270~hmac=48da6f35f154f9d57e3e27d4cf96c1c53d653393278091564791de9faaa9a33d"),
    ),
    Ride(
      from: 'Algeria',
      to: "Setif",
      price: '1000',
      date: DateTime.now().month.toString(),
      seats: 4,
      totalSeats: 4,
      driver: Driver(
          isDriver: true,
          phone: "0562413935",
          email: 'azzouzmerouani@gmail.com',
          uid: '45881632jusckmcl',
          carmodele: 'picanto',
          name: 'Ahmed amrani',
          rating: '3.5',
          image:
              'https://img.freepik.com/psd-gratuit/illustration-3d-personne-lunettes-soleil_23-2149436180.jpg?w=740&t=st=1690473860~exp=1690474460~hmac=09877664ae7a857fed98477c4b733e68feeaabb05a6ef9507a39f2d65116b237'),
    ),
  ].obs;

  RxString searchedName = ''.obs;

  void changepaymentMethod() {
    hendPayment = !hendPayment;
    update();
  }

  void deleteride(String rideUID) async {
    // Get reference to rides collection
    final ridesRef = FirebaseFirestore.instance.collection('rides');

// Document ID/path of ride to delete
    final rideDocPath = rideUID;

// Execute delete operation
    await ridesRef.doc(rideDocPath).delete();

// Confirm delete
    print('Ride deleted successfully');
  }

  void addnewRide({
    required String from,
    required String to,
    required String price,
    required String date,
    required String seats,
    required Driver driver,
    required GeoPoint startpoint,
    required GeoPoint endpoint,
  }) async {
    isloading = true;
    print(isloading);
    update();
    print("Adding new ride on firebase");
    try {
      var documentRef =
          await FirebaseFirestore.instance.collection('rides').add(Ride(
                from: from,
                to: to,
                price: price,
                date: date,
                seats: int.parse(seats),
                totalSeats: int.parse(seats),
                driver: driver,
                startpoint: startpoint,
                endpoint: endpoint,
              ).toMap());
      print("DOC ID  = $documentRef.id");
      await FirebaseFirestore.instance
          .collection('rides')
          .doc(documentRef.id)
          .update({
        'uid': documentRef.id,
      });
      Get.snackbar('New Ride Added', 'Location : $from  Destenation : $to');
    } catch (e) {
      print(e);
    }
    isloading = false;
    print(isloading);
    update();
    Get.toNamed("/driverhome");
  }

  void getrides() async {
    isloading = true;
    print(isloading);
    searchedrides.clear();
    myRides.clear();
    update();
    String driverid = FirebaseAuth.instance.currentUser!.uid;
    var documents = await FirebaseFirestore.instance.collection("rides").get();
    print(documents.docs.isEmpty);
    for (var element in documents.docs) {
      searchedrides.add(Ride.fromMap(element.data()));
      print(
          "${searchedrides.last.driver!.uid!} = ${driverid} ? ${searchedrides.last.driver!.uid! == driverid} ");
      if (searchedrides.last.driver!.uid! == driverid) {
        myRides.add(Ride.fromMap(element.data()));
        print("My Rides Lenght is ${myRides.length}");
      }
      print(element.data());
    }
    print(searchedrides);
    isloading = false;
    update();
  }

  List appusers = [];

  void bookRide(Ride ride, int seats) {
    FirebaseFirestore.instance.collection('rides').doc(ride.uid).update({
      "seats": seats - 1,
    }).then((value) {
      print('Secccses');

      Get.to(
        ChatPage(ride!.driver!),
      );
    }).catchError((e) {
      print(e);
    });
  }

  void getFees(var driverid) async {
    // Reference the rides collection
    final ridesRef = FirebaseFirestore.instance.collection('rides');

// Create a query to filter by driver and get the fee field
    final query = ridesRef.where('driver.uid', isEqualTo: driverid);

// Execute the query
    final snapshot = await query.get();

    for (var doc in snapshot.docs) {
      print("${doc.data()['price']} * ${doc.data()['totalSeats']}");
    }
// Initialize a variable to hold the total fees
    var totalFees = 0;

// Loop through the query results and sum the fees
    for (var doc in snapshot.docs) {
      if (doc.data()['totalSeats'] != null || doc.data()['totalSeats'] != 0) {
        int totalSeats = doc.data()['totalSeats'] ?? 0;
        totalFees += int.parse(doc.data()['price']) * totalSeats;
      } else {}
    }

// Log the result
    print('Total fees for driver: $totalFees');
    Get.dialog(
      AlertDialog(
        elevation: 0,

        // backgroundColor: white.withOpacity(0.5),
        alignment: Alignment.center,
        title: Text("Totale Fee Amount"),
        content: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          direction: Axis.vertical,
          children: [
            Text(" Your totale income : ${totalFees} DA"),
            Text(" Your totale fee : ${totalFees * 0.15} DA"),
          ],
        ),
      ),
    );
  }

  void getUsersTochat() {
    isloading = true;
    update();

    FirebaseFirestore.instance.collection('users').get().then((value) async {
      value.docs.forEach((element) {
        appusers.add(AppUser.fromMap(element.data()));
      });

      print('The Users ${appusers}');
      isloading = false;
      update();
    }).onError((error, stackTrace) {
      print(error.toString());
      Get.showSnackbar(GetSnackBar(
          message: error.toString(),
          icon: const Icon(
            Iconsax.warning_2,
          )));
      isloading = false;
      update();
    });
  }

  List drivers = [];

  void getDriversTochat() {
    isloading = true;
    update();

    FirebaseFirestore.instance.collection('drivers').get().then((value) async {
      value.docs.forEach((element) {
        drivers.add(Driver.fromMap(element.data()));
      });

      print('The Users ${appusers}');
      isloading = false;
      update();
    }).onError((error, stackTrace) {
      print(error.toString());
      Get.showSnackbar(GetSnackBar(
          message: error.toString(),
          icon: const Icon(
            Iconsax.warning_2,
          )));
      isloading = false;
      update();
    });
  }

  void searchrides(String searchName) {
    searchedName.value = searchName;
    print(searchedName);
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    appusers.clear();
    getUsersTochat();
    getDriversTochat();
    getrides();
  }
}
