import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:rafik/Controller/Services/tokens_service.dart';
import 'package:rafik/View/Authpages/chosepage.dart';
import 'package:rafik/View/Authpages/terms.dart';
import 'package:rafik/View/Compenents/theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OneBoard extends StatefulWidget {
  const OneBoard({super.key});

  @override
  State<OneBoard> createState() => _OneBoardState();
}

class _OneBoardState extends State<OneBoard> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPageIndex = 0;

  final List<Widget> _onboardingScreens = [
    Container(
      color: Color(0xffFA8A33),
      child: Center(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: Get.size.height * 0.05),
                    child: SizedBox(
                        width: Get.width * 0.83,
                        child: Image.asset('assets/taxi.png')),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: Get.height * 0.04,
                    ),
                    child: const Text(
                      'Rafik',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: Get.size.height * 0.2,
                    ),
                    child: SizedBox(
                      width: Get.width * 0.7,
                      child: const Text(
                        " It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    Container(
      color: secondmaincolor,
      child: Center(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: Get.size.height * 0.05),
                    child: SizedBox(
                        width: Get.width * 0.83,
                        child: Image.asset('assets/img2.jpg')),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: Get.height * 0.04,
                    ),
                    child: const Text(
                      'Sharikcar',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: Get.size.height * 0.2,
                    ),
                    child: SizedBox(
                      width: Get.width * 0.7,
                      child: const Text(
                        " It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    Container(
      color: beage,
      child: Center(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: Get.size.height * 0.05),
                    child: SizedBox(
                        width: Get.width * 0.83,
                        child: Image.asset('assets/img4.png')),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: Get.height * 0.04,
                    ),
                    child: const Text(
                      'Rafik',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: Get.size.height * 0.2,
                    ),
                    child: SizedBox(
                      width: Get.width * 0.7,
                      child: const Text(
                        " It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPageIndex < _onboardingScreens.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {}
    if (_currentPageIndex >= _onboardingScreens.length - 1) {
      //Go to signup
      _skip();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Stack(alignment: Alignment.bottomCenter, children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int pageIndex) {
              setState(() {
                _currentPageIndex = pageIndex;
              });
            },
            children: _onboardingScreens,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: Get.height * 0.15),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: _onboardingScreens.length,
                effect: ExpandingDotsEffect(
                    dotHeight: 5,
                    dotWidth: 5,
                    dotColor: Colors.white,
                    activeDotColor: Colors.white,
                    spacing: 7),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 100,
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => _skip(),
                      child: Text(
                        'Skip',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Get.width * 0.055,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    InkWell(
                      onTap: () {
                        _nextPage();
                      },
                      child: Text(
                        'Next',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Get.width * 0.055,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(width: 3),
                    Icon(
                      IconlyBroken.arrow_right,
                      color: white,
                      size: Get.width * 0.07,
                    )
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

void _skip() {
  print('skip');
  Get.to(ChosePage());
}
