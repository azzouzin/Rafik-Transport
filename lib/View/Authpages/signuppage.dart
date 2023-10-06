import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafik/Controller/authcontroller.dart';
import 'package:rafik/View/Authpages/OTP/register.dart';
import 'package:rafik/View/Compenents/theme.dart';

import '../Compenents/components.dart';
import 'terms.dart';

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
          style: Get.textTheme.bodyLarge!.copyWith(color: white),
        ),
        InkWell(
          onTap: () {},
          child: TextButton(
            onPressed: () {
              Get.to(TermesPage());
            },
            child: Text(
              'I agree to Terms of Service and Privacy Policy',
              style: Get.textTheme.bodyMedium!
                  .copyWith(fontSize: 14, color: lightgreen),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        mybutton(
            bgcolor: lightgreen,
            ontap: () {
              print(authcontroller.emailEditingController.text.trim());
              print(authcontroller.passwordEditingController.text.trim());
              print(authcontroller.nameEditingController.text.trim());
              print(authcontroller.phoneEditingController.text.trim());

              Get.to(Register(
                isDriver: false,
              ));
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
                  authcontroller.emailEditingController.text,
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
            bgcolor: lightgreen,
            ontap: () async {
              print(authcontroller.emailEditingController.text);
              print(authcontroller.passwordEditingController.text);
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
          controller: authcontroller.emailEditingController,
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
          onTap: () {},
          child: TextButton(
            onPressed: () {
              Get.to(TermesPage());
            },
            child: Text(
              'I agree to Terms of Service and Privacy Policy',
              style: Get.textTheme.bodyMedium!
                  .copyWith(fontSize: 14, color: lightgreen),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        mybutton(
            bgcolor: lightgreen,
            ontap: () {
              print(authcontroller.emailEditingController.text.trim());
              print(authcontroller.passwordEditingController.text.trim());
              print(authcontroller.nameEditingController.text.trim());
              print(authcontroller.carmodeleEditingController.text.trim());
              Get.to(Register(
                isDriver: true,
              ));
              /* authcontroller.signupdriver(
                  emailEditingController.text.trim(),
                  passwordEditingController.text.trim(),
                  nameEditingController.text.trim(),
                  carmodeleEditingController.text.trim());*/
              print('button tapped');
            },
            cntr:
                Text('Agree and Continue', style: Get.textTheme.headlineLarge)),
      ]),
    );
  }
//
}
