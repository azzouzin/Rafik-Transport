import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rafik/Controller/ridescontroller.dart';
import 'package:rafik/View/Compenents/theme.dart';
import 'package:rafik/View/HomePages/UserPages/ridedetails.dart';
import 'package:rafik/View/HomePages/UserPages/searchRidespage.dart';

class RidesPage extends StatelessWidget {
  RidesPage({super.key});
  RidesController ridesController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Book a ride',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Iconsax.arrow_left,
            color: Colors.black,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.to(SearchRides());
            },
            child: Icon(
              Iconsax.search_normal,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: GetBuilder<RidesController>(builder: (controller) {
        return controller.isloading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return ridedetails(index);
                },
                itemCount: controller.searchedrides.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 20,
                  );
                },
              );
      }),
    );
  }

  Center ridedetails(int index) {
    return Center(
      child: OpenContainer(
        closedBuilder: (_, openContainer) {
          return Container(
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
                        ridesController.searchedrides[index].driver!.image,
                        fit: BoxFit.cover,
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '${ridesController.searchedrides[index].from} - ${ridesController.searchedrides[index].to}',
                        style: Get.textTheme.headlineLarge!.copyWith(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Date : ${ridesController.searchedrides[index].date}',
                        style: Get.textTheme.headlineLarge!.copyWith(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Price : ${ridesController.searchedrides[index].price} DA',
                        style: Get.textTheme.headlineLarge!.copyWith(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Seats availble : ${ridesController.searchedrides[index].seats}',
                        style: Get.textTheme.headlineLarge!.copyWith(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Rating : ${ridesController.searchedrides[index].driver!.rating}',
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
            ride: ridesController.searchedrides[index],
            closeContainer: closeContainer,
          );
        },
      ),
    );
  }
}
