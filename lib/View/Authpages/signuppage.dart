import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafik/Controller/authcontroller.dart';
import 'package:rafik/View/Compenents/theme.dart';

import '../Compenents/components.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController carmodeleEditingController = TextEditingController();
  Authcontroller authcontroller = Get.put(Authcontroller(), permanent: true);

  String title = 'Hi!';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.025, vertical: 10),
            width: Get.width,
            height: Get.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/walppr.jpg'), fit: BoxFit.cover)),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: title == 'Hi!'
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(
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
                  SizedBox(height: Get.height * 0.1),
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
            return controller.isloading == true
                ? Center(
                    child: CircularProgressIndicator(
                      color: lightgreen,
                    ),
                  )
                : Container();
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
          controller: emailEditingController,
          label: 'Email',
        ),
        const SizedBox(
          height: 20,
        ),
        mytextField(
          controller: phoneEditingController,
          label: 'phone',
        ),
        const SizedBox(
          height: 20,
        ),
        mytextField(
          controller: nameEditingController,
          label: 'Name',
        ),
        const SizedBox(
          height: 20,
        ),
        mytextField(
          controller: passwordEditingController,
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
          onTap: () {},
          child: Text(
            'I agree to Terms of Service and Privacy Policy',
            style: Get.textTheme.bodyMedium!
                .copyWith(fontSize: 14, color: lightgreen),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        mybutton(
            bgcolor: lightgreen,
            ontap: () {
              print(emailEditingController.text.trim());
              print(passwordEditingController.text.trim());
              print(nameEditingController.text.trim());
              print(phoneEditingController.text.trim());

              authcontroller.signup(
                  emailEditingController.text.trim(),
                  passwordEditingController.text.trim(),
                  nameEditingController.text.trim(),
                  phoneEditingController.text.trim());
              print('button tapped');
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
      color: Colors.white.withOpacity(0.15),
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
                  style: Get.textTheme.headlineLarge,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  emailEditingController.text,
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
          controller: passwordEditingController,
          label: 'Password',
        ),
        const SizedBox(
          height: 20,
        ),
        mybutton(
            bgcolor: lightgreen,
            ontap: () async {
              print(emailEditingController.text);
              print(passwordEditingController.text);
              print('button tapped');

              authcontroller.isDriver == true
                  ? await authcontroller.loginDriver(
                      emailEditingController.text,
                      passwordEditingController.text)
                  : await authcontroller.login(emailEditingController.text,
                      passwordEditingController.text);
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
                .copyWith(fontSize: 14, color: lightgreen),
          ),
        ),
      ]),
    );
  }

  BlurryContainer hiwidget() {
    return BlurryContainer(
      blur: 5,
      width: Get.width * 0.95,
      elevation: 10,
      color: Colors.white.withOpacity(0.15),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        mytextField(
          controller: emailEditingController,
          label: 'Email',
        ),
        const SizedBox(
          height: 20,
        ),
        mybutton(
            bgcolor: lightgreen,
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
                      .copyWith(fontSize: 14, color: lightgreen),
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
                .copyWith(fontSize: 14, color: lightgreen),
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
          controller: emailEditingController,
          label: 'Email',
        ),
        const SizedBox(
          height: 20,
        ),
        mytextField(
          controller: carmodeleEditingController,
          label: 'Car Modele',
        ),
        const SizedBox(
          height: 20,
        ),
        mytextField(
          controller: nameEditingController,
          label: 'Name',
        ),
        const SizedBox(
          height: 20,
        ),
        mytextField(
          controller: passwordEditingController,
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
          onTap: () {},
          child: Text(
            'I agree to Terms of Service and Privacy Policy',
            style: Get.textTheme.bodyMedium!
                .copyWith(fontSize: 14, color: lightgreen),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        mybutton(
            bgcolor: lightgreen,
            ontap: () {
              print(emailEditingController.text.trim());
              print(passwordEditingController.text.trim());
              print(nameEditingController.text.trim());
              print(carmodeleEditingController.text.trim());

              authcontroller.signupdriver(
                  emailEditingController.text.trim(),
                  passwordEditingController.text.trim(),
                  nameEditingController.text.trim(),
                  carmodeleEditingController.text.trim());
              print('button tapped');
            },
            cntr:
                Text('Agree and Continue', style: Get.textTheme.headlineLarge)),
      ]),
    );
  }
//
}
