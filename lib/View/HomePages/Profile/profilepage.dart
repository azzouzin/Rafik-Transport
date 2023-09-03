import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rafik/View/Compenents/theme.dart';
import '../../../Controller/authcontroller.dart';
import 'driverlistpage.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  Authcontroller authcontroller = Get.put(Authcontroller(), permanent: true);

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Iconsax.arrow_left,
              color: Colors.black,
            )),
        title: Text('Profile', style: Get.textTheme.titleLarge),
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(isDark ? Iconsax.sun : Iconsax.moon))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              /// -- IMAGE
              Stack(
                children: [
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
                                    authcontroller.profile!.image!,
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
                        Iconsax.verify1,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(authcontroller.profile!.name!,
                  style: Get.textTheme.titleLarge),
              Text(authcontroller.profile!.email!,
                  style: Theme.of(context).textTheme.bodyText2),
              const SizedBox(height: 20),

              /// -- BUTTON

              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    await authcontroller.updatephoto(false);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text('Update Photo',
                      style: TextStyle(color: Colors.white)),
                ),
              ),

              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(MessegePage2());
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: lightgreen,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text('Rides History',
                      style: TextStyle(color: Color.fromARGB(255, 22, 80, 24))),
                ),
              ),
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
                    Get.snackbar('Billing comming soon',
                        'We are currently working on it thank you for your patient');
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
        child: Icon(icon, color: iconColor),
      ),
      title: Text(title,
          style:
              Theme.of(context).textTheme.bodyText1?.apply(color: textColor)),
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
