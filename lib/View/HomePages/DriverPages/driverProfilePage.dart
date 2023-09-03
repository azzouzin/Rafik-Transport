import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rafik/Controller/locationsController.dart';
import 'package:rafik/Controller/ridescontroller.dart';
import 'package:rafik/Controller/usercontoller.dart';
import 'package:rafik/View/Compenents/theme.dart';

import '../../../../Controller/authcontroller.dart';

class DriverProfileScreen extends StatelessWidget {
  DriverProfileScreen({Key? key}) : super(key: key);
  Authcontroller authcontroller = Get.put(Authcontroller(), permanent: true);
  RidesController ridesController = Get.put(RidesController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    // var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // padding: const EdgeInsets.all(10),
          color: Color.fromARGB(255, 255, 251, 251),
          child: Column(
            children: [
              const SizedBox(height: 15),

              /// -- IMAGE
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipOval(
                    child: Container(
                      width: 125,
                      height: 125,
                      decoration: BoxDecoration(color: lightgreen),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: GetBuilder<Authcontroller>(builder: (controller) {
                      return ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: authcontroller.photoIsLoading == true
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Image(
                                  image: NetworkImage(
                                    authcontroller.driverProfile!.image,
                                  ),
                                  fit: BoxFit.cover,
                                ));
                    }),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blue,
                      ),
                      child: const Icon(
                        Iconsax.verify,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(authcontroller.driverProfile!.name,
                  style: Get.textTheme.headlineLarge!
                      .copyWith(fontSize: 25, color: Colors.black)),
              Text(authcontroller.driverProfile!.email,
                  style: Get.textTheme.headlineLarge!
                      .copyWith(fontSize: 15, color: Colors.black)),
              const SizedBox(height: 20),

              //change Photo

              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    await authcontroller.updatephoto(true);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text('Update Photo',
                      style: TextStyle(color: Colors.white)),
                ),
              ),

              /// -- BUTTON

              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    ridesController.getFees(authcontroller.driverProfile!.uid!);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text('Get Fees',
                      style: TextStyle(color: Colors.white)),
                ),
              ),

              ///
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              /// -- MENU
              ProfileMenuWidget(
                  title: "Settings",
                  icon: Iconsax.cake,
                  onPress: () {
                    Get.snackbar('Settings comming soon',
                        'We are currently working on it thank you for your patient');
                  }),
              ProfileMenuWidget(
                  title: "Billing Details",
                  icon: Iconsax.wallet,
                  onPress: () {
                    ridesController.getFees(authcontroller.driverProfile!.uid);
                    /*   Get.snackbar('Billing comming soon',
                        'We are currently working on it thank you for your patient');*/
                  }),
              ProfileMenuWidget(
                  title: "User Management",
                  icon: Iconsax.user_add,
                  onPress: () {
                    Get.snackbar('User Management comming soon',
                        'We are currently working on it thank you for your patient');
                  }),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                  title: "Information",
                  icon: Iconsax.info_circle,
                  onPress: () {
                    Get.snackbar('Information comming soon',
                        'We are currently working on it thank you for your patient');
                  }),
              ProfileMenuWidget(
                  title: "Logout",
                  icon: Iconsax.logout,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {
                    Get.defaultDialog(
                      title: "LOGOUT",
                      titleStyle: const TextStyle(fontSize: 20),
                      content: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Text("Are you sure, you want to Logout?"),
                      ),
                      confirm: Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            print('logout');
                            authcontroller.logout();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              side: BorderSide.none),
                          child: const Text("Yes"),
                        ),
                      ),
                      cancel: OutlinedButton(
                          onPressed: () => Get.back(), child: const Text("No")),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

//-----------------------------------------------------------------------------

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor = isDark ? lightgreen : const Color.fromARGB(255, 21, 68, 23);

    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: iconColor.withOpacity(0.1),
        ),
        child: Icon(icon, color: title == "Logout" ? Colors.pink : green),
      ),
      title: Text(title,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.apply(color: title == "Logout" ? Colors.pink : lightgreen)),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: const Icon(Iconsax.align_left,
                  size: 18.0, color: Colors.grey))
          : null,
    );
  }
}

//------------------------------------------------------------------------------
