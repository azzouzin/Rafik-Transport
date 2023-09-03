import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafik/Controller/ridescontroller.dart';
import 'package:rafik/View/Compenents/theme.dart';

import 'driverchatpage.dart';

class MessegePage extends StatelessWidget {
  MessegePage({super.key});

  RidesController ridesController = Get.put(RidesController());
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: ridesController.appusers.isEmpty
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
                      () => DriverChatPage(
                        ridesController.appusers[i],
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Profile picture
                      ClipOval(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                         
                             
                               ClipOval(
                                 child: SizedBox( width: 50,
                                                             height: 50,
                                   child: Image.network(
                                    ridesController.appusers[i].image ??
                                        'https://img.freepik.com/photos-gratuite/lapin-dessin-anime-mignon-genere-par-ai_23-2150288877.jpg?size=626&ext=jpg',
                                    scale: 10,
                                    fit: BoxFit.cover,
                                                               ),
                                 ),
                               ),   Container(    width: 55,
                              height: 55,
                              decoration: BoxDecoration(border: Border.all(color: Colors.green,width: 2,style: BorderStyle.solid),shape: BoxShape.circle),
                       )
                       ,    
                            
                          ],
                        ),
                      )
                      //username + date
                      ,
                      SizedBox(
                        width: 20,
                      ),

                      Text(
                        ridesController.appusers[i].name,
                        style: Get.textTheme.headlineLarge!.copyWith(
                          color: lightgreen
                        ),
                      ),

                      //    Expanded(child: Container()),
                      //three dots
                      //   Icon(Iconsax.more)
                    ],
                  ),
                );
              },
              separatorBuilder: (context, i) => Divider(
                    thickness: 5,
                    color: Colors.black,
                  ),
              itemCount: ridesController.appusers.length),
    ));
  }
}
