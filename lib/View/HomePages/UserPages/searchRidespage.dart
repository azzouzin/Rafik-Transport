import 'package:animations/animations.dart';
import 'package:firestore_search/firestore_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafik/View/Compenents/components.dart';
import 'package:rafik/View/Compenents/theme.dart';
import 'package:rafik/View/HomePages/UserPages/ridedetails.dart';

import '../../../Model/ride.dart';

class SearchRides extends StatelessWidget {
  const SearchRides({super.key});

  @override
  Widget build(BuildContext context) {
    return FirestoreSearchScaffold(
      appBarBackgroundColor: maincolor,
      // clearSearchButtonColor: white,
      // searchBackgroundColor: lightgreen,
      appBarTitle: 'Rides',
      appBarTitleColor: white,
      clearSearchButtonColor: maincolor,
      showSearchIcon: true,
      searchIconColor: white,
      scaffoldBody: Container(
        width: Get.width,
        height: Get.height,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: Get.width * 0.9,
                height: Get.height * 0.3,
                child: Image.asset(
                  "assets/img4.png",
                  fit: BoxFit.cover,
                )),
            SizedBox(
              height: 20,
            ),
            Text('Search for Rides Near you '),
          ],
        )),
      ),
      firestoreCollectionName: 'rides',
      searchBy: 'from',
      // scaffoldBody: Center(),
      dataListFromSnapshot: Ride(totalSeats: 4).dataListFromSnapshot,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<Ride>? dataList = snapshot.data;
          if (dataList!.isEmpty) {
            return Center(
              child: SizedBox(
                height: Get.width,
                width: Get.width * 0.7,
                child: Image.asset(
                  'assets/preview.png',
                  fit: BoxFit.cover,
                ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  final Ride data = dataList[index];

                  return Column(
                    children: [
                      SizedBox(height: 10),
                      ridedetails(data),
                    ],
                  );
                }),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          if (!snapshot.hasData) {
            return Center(
              child: SizedBox(
                height: Get.width,
                width: Get.width * 0.7,
                child: Image.asset(
                  'assets/preview.png',
                  fit: BoxFit.cover,
                ),
              ),
            );
          }
        }
        return const Center(
          child: Loader(),
        );
      },
    );
  }

  Center ridedetails(ride) {
    return Center(
      child: OpenContainer(
        closedBuilder: (_, openContainer) {
          return Container(
            // margin: EdgeInsets.symmetric(vertical: 100),
            height: Get.height * 0.2,
            width: Get.width * 0.95,
            child: Row(
              children: [
                SizedBox(
                    width: Get.width * 0.4,
                    height: Get.height * 0.2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        ride.driver!.image,
                        fit: BoxFit.cover,
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: Get.height * 0.075,
                        width: Get.width * 0.4,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Text(
                                '${ride.from} - ${ride.to}',
                                style: Get.textTheme.headlineLarge!.copyWith(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ]),
                      ),
                      Text(
                        'Date : ${ride.date}',
                        style: Get.textTheme.headlineLarge!.copyWith(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Price : ${ride.price} DA',
                        style: Get.textTheme.headlineLarge!.copyWith(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Seats availble : ${ride.seats}',
                        style: Get.textTheme.headlineLarge!.copyWith(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Rating : ${ride.driver!.rating}',
                        style: Get.textTheme.headlineLarge!.copyWith(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
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
          return RideDetails(
            ride: ride,
            closeContainer: closeContainer,
          );
        },
      ),
    );
  }
}
