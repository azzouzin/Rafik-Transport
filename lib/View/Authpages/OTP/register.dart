import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import 'otp.dart';

import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  final bool isDriver;

  const Register({super.key, required this.isDriver});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController numberEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () async {
        await verifyPhone("562413935", "5465");
      }),
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
                  child: const Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(height: 18),
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
                'Registration',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Add your phone number. we'll send you a verification code so we know you're real",
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
              Container(
                padding: EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10)),
                        prefix: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            '(+213)',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        suffixIcon: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 32,
                        ),
                      ),
                      controller: numberEditingController,
                    ),
                    const SizedBox(height: 22),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          String code = generateRandomString(4);
                          await verifyPhone(numberEditingController.text, code);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => Otp(
                                      code: code,
                                      isDriver: widget.isDriver,
                                    )),
                          );
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
                            'Send',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
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

    number = "213${number}";

    var body = jsonEncode({
      "to": number,
      "msg": "Your Verification code is $code",
      "username": "Merouani Azzouz",
      "userid": "25357",
      "handle": "965c928b80726b06be98425fc3484fd2",
      "from": "ShariKCar",
    });
    await http
        .post(Uri.parse("https://api.budgetsms.net/testsms/"),
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json"
            },
            body: body)
        .then((value) {
      print(value.body);
    });
    /*  number = "+213 $number";
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
    });*/
  }
}
