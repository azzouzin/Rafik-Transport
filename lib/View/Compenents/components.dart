import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafik/Helpers/translate_helper.dart';
import 'package:rafik/View/Compenents/theme.dart';
import 'package:rive/rive.dart';

Widget mytextField({
  required TextEditingController controller,
  required String label,
}) {
  bool ishaigh = false;
  return Container(
      // width: Get.width * 0.9,
      // padding: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        border: ishaigh == true
            ? Border.all(
                color: maincolorlighter,
                width: 2.0,
              )
            : Border.all(
                color: maincolor,
                width: 0.5,
              ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: TextField(
            keyboardType: label == getStatment("Phone number")
                ? TextInputType.number
                : TextInputType.name,
            style: Get.textTheme.bodyMedium,
            controller: controller,
            obscureText: label == getStatment('Password') ? true : false,
            decoration: InputDecoration(
              isDense: true,
              //errorText: validateEmail(controller.text),
              border: InputBorder.none,
              hintText: label,

              alignLabelWithHint: true,
              fillColor: white,
              filled: true,
              hintStyle: Get.textTheme.bodyMedium,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: maincolorlighter, width: 3),
              ),
            ),
          ),
        ),
      ));
}

Widget borderlesstextfield({
  required TextEditingController controller,
  required String label,
}) {
  bool ishaigh = false;
  return Container(
      // width: Get.width * 0.9,
      // padding: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        border: ishaigh == true
            ? Border.all(
                color: lightgreen,
                width: 2.0,
              )
            : null,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: TextField(
            /* onTap: () {
            if (validateEmail(controller.text) != null) {
              Get.snackbar('Error', 'Invalid Email');
            }
          },
          onEditingComplete: () {
            if (validateEmail(controller.text) != null) {
              Get.snackbar('Error', 'Invalid Email');
            }
          },*/
            controller: controller,
            obscureText: label == 'Password' ? true : false,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              isDense: true,
              //errorText: validateEmail(controller.text),
              border: InputBorder.none,
              hintText: label,
              hintStyle:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              fillColor: white,
              filled: true,
            ),
          ),
        ),
      ));
}

String? validateEmail(String? value) {
  if (!value!.contains('@')) {
    return 'Invalid email';
  } else {
    return null;
  }
}

Widget mybutton({
  required Function ontap,
  required Widget cntr,
  Color? bgcolor,
  String? image,
}) {
  return InkWell(
    onTap: () => ontap(),
    child: Container(
      width: Get.width * 0.85,
      height: Get.height * 0.075,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          border: Border.all(width: 0.5),
          borderRadius: BorderRadius.circular(10),
          color: bgcolor == null ? Colors.white : bgcolor),
      child: Center(
          child: image == null
              ? cntr
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(image),
                    Padding(
                        padding: EdgeInsets.only(left: Get.width * 0.07),
                        child: cntr),
                  ],
                )),
    ),
  );
}

SnackbarController alertError(titel, messege) {
  return Get.snackbar(titel, messege,
      backgroundColor: Colors.red, colorText: Colors.white);
}

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          width: 75,
          height: 75,
          child: ClipOval(
            child: RiveAnimation.asset(
              "assets/rive/loading.riv",
              fit: BoxFit.cover,
            ),
          )),
    );
  }
}
