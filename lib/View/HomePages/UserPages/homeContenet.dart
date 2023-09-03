import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rafik/View/Compenents/components.dart';
import 'package:rafik/View/Compenents/theme.dart';

import '../../../Controller/locationsController.dart';

class HomeContenent extends StatelessWidget {
  const HomeContenent({
    super.key,
    required this.locationsController,
  });

  final LocationsController locationsController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.05, vertical: 10),
              child: Text('Wher do you want to go ?',
                  style: Get.textTheme.titleLarge),
            ),

            //Pick up Point
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
              child: Row(children: [
                Icon(
                  Iconsax.location,
                  color: Colors.purple,
                  size: Get.size.width * 0.08,
                ),
                SizedBox(
                  width: Get.width * 0.8,
                  height: Get.height * 0.07,
                  child: borderlesstextfield(
                      controller: locationsController.pickupEditingController,
                      label: 'Where are you ?'),
                ),
              ]),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
              child: Divider(
                color: Colors.grey,
                thickness: 1,
              ),
            ),
            //Destentation
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
              child: Row(children: [
                Icon(
                  Iconsax.location5,
                  color: Colors.pink,
                  size: Get.size.width * 0.08,
                ),
                SizedBox(
                  width: Get.width * 0.8,
                  height: Get.height * 0.07,
                  child: borderlesstextfield(
                      controller:
                          locationsController.destinationEditingController,
                      label: 'Where is your destination ?'),
                ),
              ]),
            ),
            //Locations
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.01, vertical: 10),
                child: SizedBox(
                  width: Get.width,
                  height: Get.height * 0.035,
                  child: ListView.separated(
                      itemCount: locationsController.locations.length,
                      separatorBuilder: (context, index) => SizedBox(width: 15),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            locationsController.changeselctedlocation(index);
                          },
                          child: Obx(() {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: locationsController
                                              .selectedlocation.value ==
                                          index
                                      ? lightgreen
                                      : const Color.fromARGB(
                                          255, 231, 231, 231)),
                              child: Text(
                                locationsController.locations[index],
                                style: TextStyle(
                                    color: locationsController
                                                .selectedlocation.value ==
                                            index
                                        ? white
                                        : lightgreen),
                              ),
                            );
                          }),
                        );
                      }),
                )),
            //Button
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: mybutton(
                    bgcolor: lightgreen,
                    ontap: () {
                      print("search clicked");
                      Get.toNamed('/ridespage');
                    },
                    cntr: Text(
                      "Search for rides",
                      style: Get.textTheme.headlineLarge,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
