import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafik/Controller/authcontroller.dart';
import 'package:rafik/View/Authpages/OTP/otp.dart';
import 'package:rafik/View/Authpages/OTP/register.dart';
import 'package:rafik/View/Authpages/terms.dart';
import 'package:rafik/View/Compenents/theme.dart';

import '../Compenents/components.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  Authcontroller authcontroller = Get.put(Authcontroller(), permanent: true);

  String title = 'Hi!';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolordarker,
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.025, vertical: 10),
            width: Get.width,
            height: Get.height,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: title == 'Hi!'
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        title = 'Hi!';
                      });
                    },
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        margin: EdgeInsets.all(40),
                        //  width: Get.width * 0.2,
                        height: Get.width * 0.1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: Get.width * 0.2,
                                height: Get.width * 0.2,
                                child: Image.asset("assets/logo.png")),
                            SizedBox(width: 20),
                            Text(
                              "SharikCare",
                              style: Get.textTheme.headlineMedium!
                                  .copyWith(color: Colors.white),
                            )
                          ],
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Text(
                      title,
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  title == 'Hi!'
                      ? hiwidget()
                      : title == 'Log In'
                          ? loginWidget()
                          : authcontroller.isDriver == true
                              ? signupdriver()
                              : signupwidget(),
                ],
              ),
            ),
          ),
          GetBuilder<Authcontroller>(builder: (controller) {
            return controller.isloading == true ? Loader() : Container();
          }),
        ],
      )),
    );
  }

  BlurryContainer signupwidget() {
    return BlurryContainer(
      blur: 5,
      width: Get.width * 0.95,
      elevation: 10,
      color: Colors.white.withOpacity(0.99),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Looks Like You Dont Have an account Let's creat account for you",
          style: Get.textTheme.bodyLarge!.copyWith(color: Colors.black),
        ),
        const SizedBox(
          height: 20,
        ),
        const SizedBox(
          height: 20,
        ),
        mytextField(
          controller: authcontroller.emailEditingController,
          label: 'Email',
        ),
        const SizedBox(
          height: 20,
        ),
        mytextField(
          controller: authcontroller.phoneEditingController,
          label: 'phone',
        ),
        const SizedBox(
          height: 20,
        ),
        mytextField(
          controller: authcontroller.nameEditingController,
          label: 'Name',
        ),
        const SizedBox(
          height: 20,
        ),
        mytextField(
          controller: authcontroller.passwordEditingController,
          label: 'Password',
        ),
        const SizedBox(
          height: 20,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'By Selecting Agree and Continue below,',
          style: Get.textTheme.bodyLarge!.copyWith(color: Colors.black),
        ),
        InkWell(
          onTap: () {
            Get.to(TermesPage());
          },
          child: Text(
            'I agree to Terms of Service and Privacy Policy',
            style: Get.textTheme.bodyMedium!
                .copyWith(fontSize: 14, color: maincolor),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        mybutton(
            bgcolor: maincolor,
            ontap: () async {
              print(authcontroller.emailEditingController.text.trim());
              print(authcontroller.passwordEditingController.text.trim());
              print(authcontroller.nameEditingController.text.trim());
              print(authcontroller.phoneEditingController.text.trim());
              var code = generateRandomString(4);
              await verifyPhone(
                  authcontroller.phoneEditingController.text, code);
              Get.to(Otp(code: code, isDriver: false));
            },
            cntr:
                Text('Agree and Continue', style: Get.textTheme.headlineLarge)),
      ]),
    );
  }

  BlurryContainer loginWidget() {
    return BlurryContainer(
      blur: 5,
      width: Get.width * 0.95,
      elevation: 10,
      color: Colors.white.withOpacity(0.99),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            SizedBox(
              height: Get.width * 0.15,
              child: ClipOval(
                child: Image.asset('assets/logo.png'),
              ),
            ),
            SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back!',
                  style: Get.textTheme.headlineLarge!
                      .copyWith(color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  authcontroller.phoneEditingController.text,
                  style: Get.textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        mytextField(
          controller: authcontroller.passwordEditingController,
          label: 'Password',
        ),
        const SizedBox(
          height: 20,
        ),
        mybutton(
            bgcolor: maincolor,
            ontap: () async {
              print('button tapped');

              authcontroller.isDriver == true
                  ? await authcontroller.loginDriver(
                      authcontroller.emailEditingController.text,
                      authcontroller.passwordEditingController.text)
                  : await authcontroller.login(
                      authcontroller.emailEditingController.text,
                      authcontroller.passwordEditingController.text);
            },
            cntr: Text('Continue', style: Get.textTheme.headlineLarge)),
        const SizedBox(
          height: 20,
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'Forget your password ?',
            style: Get.textTheme.bodyMedium!
                .copyWith(fontSize: 14, color: maincolor),
          ),
        ),
      ]),
    );
  }

  BlurryContainer hiwidget() {
    return BlurryContainer(
      blur: 1,
      width: Get.width * 0.95,
      elevation: 10,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        mytextField(
          controller: authcontroller.emailEditingController,
          label: 'Email',
        ),
        const SizedBox(
          height: 20,
        ),
        mybutton(
            bgcolor: maincolor,
            ontap: () async {
              setState(() {
                title = 'Log In';
              });
              print(title);
              print('button tapped');
            },
            cntr: Text('Continue', style: Get.textTheme.headlineLarge)),
        const SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            'or',
            style: Get.textTheme.bodySmall!
                .copyWith(fontSize: 20, fontWeight: FontWeight.w200),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        mybutton(
            image: 'assets/facebook.png',
            ontap: () {
              print('button tapped');
            },
            cntr: Text('Continue with Facebook',
                style: Get.textTheme.headlineLarge!
                    .copyWith(color: Colors.black))),
        const SizedBox(
          height: 20,
        ),
        mybutton(
            image: 'assets/google.png',
            ontap: () {
              print('button tapped');
            },
            cntr: Text('Continue with Google',
                style: Get.textTheme.headlineLarge!
                    .copyWith(color: Colors.black))),
        const SizedBox(
          height: 20,
        ),
        mybutton(
            image: 'assets/apple.png',
            ontap: () {
              print('button tapped');
            },
            cntr: Text('Continue with Apple',
                style: Get.textTheme.headlineLarge!
                    .copyWith(color: Colors.black))),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
          child: Row(
            children: [
              Text(
                'Dont have account ?',
                style: Get.textTheme.bodyMedium!.copyWith(fontSize: 14),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    title = 'Signup';
                  });
                },
                child: Text(
                  'Signup',
                  style: Get.textTheme.bodyMedium!
                      .copyWith(fontSize: 14, color: maincolor),
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'Forget your password ?',
            style: Get.textTheme.bodyMedium!
                .copyWith(fontSize: 14, color: maincolor),
          ),
        ),
      ]),
    );
  }

  BlurryContainer signupdriver() {
    return BlurryContainer(
      blur: 5,
      width: Get.width * 0.95,
      elevation: 10,
      color: Colors.white.withOpacity(0.15),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Looks Like You Dont Have an account Let's creat account for you",
          style: Get.textTheme.bodyLarge!.copyWith(color: white),
        ),
        const SizedBox(
          height: 20,
        ),
        mytextField(
          controller: authcontroller.emailEditingController,
          label: 'Email',
        ),
        const SizedBox(
          height: 20,
        ),
        mytextField(
          controller: authcontroller.phoneEditingController,
          label: 'Phone',
        ),
        const SizedBox(
          height: 20,
        ),
        mytextField(
          controller: authcontroller.carmodeleEditingController,
          label: 'Car Modele',
        ),
        const SizedBox(
          height: 20,
        ),
        mytextField(
          controller: authcontroller.nameEditingController,
          label: 'Name',
        ),
        const SizedBox(
          height: 20,
        ),
        mytextField(
          controller: authcontroller.passwordEditingController,
          label: 'Password',
        ),
        const SizedBox(
          height: 20,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'By Selecting Agree and Continue below,',
          style: Get.textTheme.bodyLarge!.copyWith(color: white),
        ),
        InkWell(
          onTap: () {
            Get.to(TermesPage());
          },
          child: Text(
            'I agree to Terms of Service and Privacy Policy',
            style: Get.textTheme.bodyMedium!
                .copyWith(fontSize: 14, color: maincolorlighter),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        mybutton(
            bgcolor: maincolorlighter,
            ontap: () async {
              print(authcontroller.passwordEditingController.text.trim());
              print(authcontroller.nameEditingController.text.trim());
              print(authcontroller.carmodeleEditingController.text.trim());
              var code = generateRandomString(4);
              await verifyPhone(
                  authcontroller.phoneEditingController.text, code);
              Get.to(Otp(code: code, isDriver: true));

              print('button tapped');
            },
            cntr:
                Text('Agree and Continue', style: Get.textTheme.headlineLarge)),
      ]),
    );
  }
//

  String generateRandomString(int length) {
    final random = Random();
    int buffer = 0;

    for (int i = 0; i < length; i++) {
      buffer = random.nextInt(9000) + 1000;
    }
    print(buffer);
    return buffer.toString();
  }

  Future<void> verifyPhone(String number, String code) async {
    print(code);
    number = "+213 ${number.substring(1)}";
    var body = jsonEncode({
      "messages": [
        {
          "destinations": [
            {"to": number}
          ],
          "from": "Rafik Transport",
          "text": "Your Verefication code from Azzouz $code"
        }
      ]
    });
    String apiKey =
        "b5cd4bf881bf69bd5271fe714b9466b7-678bf070-36bc-4875-b1b8-eb5edaf937fe";
    Map<String, String> headers = {
      "Authorization": "App " + apiKey,
      "Content-Type": "application/json",
      "Accept": "application/json"
    };

    await http
        .post(Uri.parse("https://xlr8x3.api.infobip.com/sms/2/text/advanced"),
            headers: headers, body: body)
        .then((value) {
      print(value.body);
    });
  }
}
