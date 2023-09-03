import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafik/Controller/ridescontroller.dart';

import '../UserPages/chatpage.dart';

class MessegePage2 extends StatelessWidget {
  MessegePage2({super.key});

  RidesController ridesController = Get.put(RidesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text('Your Messges'),
      ),
      body: Container(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: ridesController.drivers.isEmpty
            ? Center(
                child: Text(
                  'There is no one here',
                  style: Get.textTheme.headlineLarge,
                ),
              )
            : ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      print('GOING TOOOOOOOOOOOOO');
                      Get.to(
                        () => ChatPage(
                          ridesController.drivers[i],
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //Profile picture
                        ClipOval(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.network(
                              ridesController.drivers[i].image ??
                                  'https://img.freepik.com/photos-gratuite/lapin-dessin-anime-mignon-genere-par-ai_23-2150288877.jpg?size=626&ext=jpg',
                              scale: 10,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                        //username + date
                        ,
                        SizedBox(
                          width: 20,
                        ),

                        Text(
                          ridesController.drivers[i].name,
                          style: Get.textTheme.headlineLarge!
                              .copyWith(color: Colors.black),
                        ),

                        //    Expanded(child: Container()),
                        //three dots
                        //   Icon(Iconsax.more)
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, i) => Divider(
                      thickness: 3,
                      color: Colors.white,
                    ),
                itemCount: ridesController.drivers.length),
      )),
    );
  }
}
