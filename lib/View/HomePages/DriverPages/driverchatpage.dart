import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rafik/Controller/authcontroller.dart';
import 'package:rafik/Model/user.dart';
import 'package:rafik/View/Compenents/theme.dart';

import '../../../../Controller/usercontoller.dart';
import '../../../../Model/messege.dart';

class DriverChatPage extends StatefulWidget {
  DriverChatPage(this.user);
  final AppUser user;

  @override
  State<DriverChatPage> createState() => DriverChatPageState();
}

class DriverChatPageState extends State<DriverChatPage> {
  TextEditingController textEditingController = TextEditingController();

  final scrollController = ScrollController();

  UserContoller userController = Get.put(UserContoller());
  Authcontroller authController = Get.put(Authcontroller());

  @override
  void initState() {
    super.initState();
    userController.getMessege(
        authController.driverProfile!.uid!, widget.user.uid!);
    print('getting messgeges');
    userController.messegelist.length == 0
        ? null
        : WidgetsBinding.instance.addPostFrameCallback((_) {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userController.messegelist.clear();
    print('Its Clear ${userController.messegelist}');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        /*floatingActionButton: FloatingActionButton(onPressed: () {
          print(widget.user.uid);
          print(authController.driverProfile!.uid!);
          userController.getMessege(
              authController.driverProfile!.uid!, widget.user.uid!);
        }),*/
        body: Builder(builder: (context) {
          print(widget.user.uid);

          return GetBuilder<UserContoller>(builder: (controller) {
            return controller.messegelist.isEmpty &&
                    controller.isloading == true
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.black,
                                  )),
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, bottom: 5),
                                child: ClipOval(
                                  child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Image.network(
                                      widget.user.image ??
                                          'https://img.freepik.com/photos-gratuite/lapin-dessin-anime-mignon-genere-par-ai_23-2150288877.jpg?size=626&ext=jpg',
                                      scale: 10,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )),
                            SizedBox(width: 20),
                            Text(
                              widget.user.name!,
                              style: Get.textTheme.titleLarge!
                                  .copyWith(fontSize: 20),
                            ),
                          ],
                        ),
                        Expanded(
                          child: ListView.separated(
                            controller: scrollController,
                            reverse: false,
                            // physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var messege = controller.messegelist[index];
                              print(authController.driverProfile!.uid!);
                              print(messege.senderid);

                              if (messege.senderid ==
                                  authController.driverProfile!.uid!) {
                                return mymessege(messege);
                              } else {
                                return (yourmessege(messege));
                              }
                            },
                            itemCount: controller.messegelist.length,
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 15);
                            },
                          ),
                        ),
                        controller.messegelist.length == 0
                            ? Container()
                            : SizedBox(
                                height: 10,
                              ),
                        Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextField(
                                controller: textEditingController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Write a messege'),
                              )),
                              InkWell(
                                onTap: () {
                                  userController.sendDriverMessege(
                                      senderid:
                                          authController.driverProfile!.uid!,
                                      recieverid: widget.user.uid!,
                                      date: DateTime.now().toString(),
                                      text: textEditingController.text);
                                  textEditingController.clear();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: lightgreen,
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: GetBuilder<UserContoller>(
                                      builder: (controller) {
                                    return controller.isloading == true
                                        ? Center(
                                            child: CircularProgressIndicator(
                                                color: Colors.white),
                                          )
                                        : Icon(
                                            Iconsax.send1,
                                            color: Colors.white,
                                            size: 30,
                                          );
                                  }),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
          });
        }),
      ),
    );
  }

  Align mymessege(Messege messege) {
    double raduis = messege.imgurl == null ? 20 : 20;
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        decoration: BoxDecoration(
            color: lightgreen,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(raduis),
                bottomLeft: Radius.circular(raduis),
                topRight: Radius.circular(raduis))),
        padding: EdgeInsets.all(10),
        child: Text(
          messege.text,
          style: Get.textTheme.titleSmall!.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Align yourmessege(Messege messege) {
    double raduis = messege.imgurl == null ? 20 : 20;
    return Align(
      alignment: Alignment.topLeft,
      child: Row(
        children: [
          Padding(
              padding: const EdgeInsets.only(right: 15),
              child: ClipOval(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.network(
                    widget.user.image ??
                        'https://img.freepik.com/photos-gratuite/lapin-dessin-anime-mignon-genere-par-ai_23-2150288877.jpg?size=626&ext=jpg',
                    scale: 10,
                    fit: BoxFit.cover,
                  ),
                ),
              )),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(raduis),
                    bottomRight: Radius.circular(raduis),
                    topRight: Radius.circular(raduis))),
            padding: EdgeInsets.all(10),
            child: Text(
              messege.text,
              style: Get.textTheme.titleSmall!.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
