import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafik/View/Compenents/theme.dart';

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
            style: Get.textTheme.bodyMedium,
            controller: controller,
            obscureText: label == 'Password' ? true : false,
            decoration: InputDecoration(
              isDense: true,
              //errorText: validateEmail(controller.text),
              border: InputBorder.none,
              hintText: label,
              fillColor: white,
              filled: true,
              hintStyle: Get.textTheme.bodyMedium,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: lightgreen, width: 3),
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
