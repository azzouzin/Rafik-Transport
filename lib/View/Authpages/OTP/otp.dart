import 'dart:convert';
import 'dart:math';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafik/Controller/authcontroller.dart';
import 'package:rafik/Helpers/translate_helper.dart';
import 'package:rafik/View/Compenents/theme.dart';

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
                  color: maincolor,
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
                getStatment("verifaction"),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                getStatment("Enter your OTP code number"),
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
                                    email: authcontroller
                                        .emailEditingController.text,
                                    name: authcontroller
                                        .nameEditingController.text,
                                    password: authcontroller
                                        .passwordEditingController.text,
                                    phone: authcontroller
                                        .phoneEditingController.text);
                          } else {
                            Get.snackbar("Your Account is not Verified ",
                                "Wrong Code Please try again",
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: white,
                          backgroundColor: maincolor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            getStatment("verifaction"),
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
                getStatment("Didn't you receive any code?"),
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
              InkWell(
                onTap: () async {
                  print("Resend Code tapped");
                  String code = generateRandomString(4);
                  await verifyPhone(
                      authcontroller.phoneEditingController.text, code);
                  Get.to(Otp(isDriver: widget.isDriver, code: code));
                },
                child: Text(
                  "Resend New Code",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                  textAlign: TextAlign.center,
                ),
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
                borderSide: BorderSide(width: 2, color: maincolorlighter),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }

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
    number = "+213 $number";
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
