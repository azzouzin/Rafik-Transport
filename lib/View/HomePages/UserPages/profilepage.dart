import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rafik/Helpers/translate_helper.dart';
import 'package:rafik/View/Compenents/components.dart';
import 'package:rafik/View/Compenents/theme.dart';
import '../../../Controller/authcontroller.dart';
import '../DriverPages/driverlistpage.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Authcontroller authcontroller = Get.put(Authcontroller(), permanent: true);
  String language = "ar";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.to(ProfileScreen());
        return Future.delayed(Duration(microseconds: 100));
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          getStatment("Try now!");
          changeLanguage("ar");
        }),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.toNamed("/homepage"),
              icon: const Icon(
                Iconsax.arrow_left,
                color: Colors.black,
              )),
          title: Text(getStatment("Profile"), style: Get.textTheme.titleLarge),
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
                                ? const Center(
                                    child: Loader(),
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
                            color: maincolorlighter,
                          ),
                          child: Image.asset("assets/logo.png")),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(authcontroller.profile!.name!,
                    style: Get.textTheme.titleLarge),

                const SizedBox(height: 20),

                /// -- BUTTON

                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () async {
                      await authcontroller.updatephoto(false);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: maincolordarker,
                        side: BorderSide.none,
                        shape: const StadiumBorder()),
                    child: Text(getStatment('Update picture'),
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
                        backgroundColor:
                            const Color.fromARGB(255, 49, 214, 255),
                        side: BorderSide.none,
                        shape: const StadiumBorder()),
                    child: Text(getStatment('Drivers'),
                        style: TextStyle(color: maincolordarker)),
                  ),
                ),
                const SizedBox(height: 30),
                const Divider(),
                const SizedBox(height: 10),

                ListTile(
                  onTap: () {},
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: Icon(Iconsax.language_circle, color: Colors.grey),
                  ),
                  title: Text(getStatment("Language"),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.apply(color: Colors.black)),
                  trailing: DropdownButton<String>(
                      elevation: 10,
                      value: language,
                      items: const [
                        DropdownMenuItem<String>(
                            value: "ar", child: Text("العربية")),
                        DropdownMenuItem(
                          child: Text("Francais"),
                          value: "fr",
                        ),
                        DropdownMenuItem(
                          child: Text("English"),
                          value: "en",
                        )
                      ],
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          language = value!;
                        });
                        changeLanguage(language);
                        Get.to(ProfileScreen());
                        print(language);
                      }),
                ),
                ProfileMenuWidget(
                    title: getStatment("Biling details"),
                    icon: Iconsax.wallet,
                    onPress: () {
                      Get.snackbar('Billing comming soon',
                          'We are currently working on it thank you for your patient');
                    }),

                const Divider(),
                const SizedBox(height: 10),

                ProfileMenuWidget(
                    title: getStatment("Log out"),
                    icon: Iconsax.logout,
                    textColor: Colors.red,
                    endIcon: false,
                    onPress: () {
                      Get.defaultDialog(
                        title: getStatment("Log out"),
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
                            onPressed: () => Get.back(),
                            child: const Text("No")),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//-----------------------------------------------------------------------------

class ProfileMenuWidget extends StatefulWidget {
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
  State<ProfileMenuWidget> createState() => _ProfileMenuWidgetState();
}

class _ProfileMenuWidgetState extends State<ProfileMenuWidget> {
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor = isDark ? lightgreen : const Color.fromARGB(255, 21, 68, 23);

    return ListTile(
        onTap: widget.onPress,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: iconColor.withOpacity(0.1),
          ),
          child: Icon(widget.icon, color: iconColor),
        ),
        title: Text(widget.title,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.apply(color: widget.textColor)),
        trailing: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.grey.withOpacity(0.1),
            ),
            child: const Icon(Iconsax.align_left,
                size: 18.0, color: Colors.grey)));
  }
}

//------------------------------------------------------------------------------
