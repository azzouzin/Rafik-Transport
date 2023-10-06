import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafik/Controller/authcontroller.dart';

class Otp extends StatefulWidget {
  final String code;
  final bool isDriver;

  const Otp({super.key, required this.isDriver, required this.code});
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  Authcontroller authcontroller = Get.put(Authcontroller());
  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();
  TextEditingController c3 = TextEditingController();
  TextEditingController c4 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/logo.png',
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'Verification',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Enter your OTP code number",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 28,
              ),

              //Code Cases

              Container(
                padding: EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _textFieldOTP(first: true, last: false, controller: c1),
                        _textFieldOTP(
                            first: false, last: false, controller: c2),
                        _textFieldOTP(
                            first: false, last: false, controller: c3),
                        _textFieldOTP(first: false, last: true, controller: c4),
                      ],
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (c1.text + c2.text + c3.text + c4.text ==
                              widget.code) {
                            Get.snackbar("Your Account is Verified ",
                                "Welcome to rafik Community",
                                backgroundColor: Colors.green,
                                colorText: Colors.white);

                            widget.isDriver == true
                                ? authcontroller.signupdriver(
                                    authcontroller.emailEditingController.text
                                        .trim(),
                                    authcontroller
                                        .passwordEditingController.text
                                        .trim(),
                                    authcontroller.nameEditingController.text
                                        .trim(),
                                    authcontroller.phoneEditingController.text
                                        .trim(),
                                    authcontroller
                                        .carmodeleEditingController.text
                                        .trim())
                                : authcontroller.signup(
                                    authcontroller.emailEditingController.text
                                        .trim(),
                                    authcontroller
                                        .passwordEditingController.text
                                        .trim(),
                                    authcontroller.nameEditingController.text
                                        .trim(),
                                    authcontroller.phoneEditingController.text
                                        .trim());
                          } else {
                            Get.snackbar("Your Account is not Verified ",
                                "Wrong Code Please try again",
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                          }
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.purple),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Verify',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                "Didn't you receive any code?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                "Resend New Code",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP(
      {bool? first, last, required TextEditingController controller}) {
    return Container(
      height: 70,
      child: AspectRatio(
        aspectRatio: 0.8,
        child: TextField(
          controller: controller,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.purple),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
