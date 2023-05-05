import 'dart:async';
import 'package:edu_application_pre/common/kiosk_main.dart';
import 'package:edu_application_pre/common/main_page.dart';
import 'package:edu_application_pre/layout/wave_widget.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () async {
      final sharedPreferences = await SharedPreferences.getInstance();
      final kioskData = sharedPreferences.getString('kioskData');
      Widget child = kioskData == null ? MainPage() : KioskMain();

      if (!mounted) return;
      await Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          reverseDuration: Duration(seconds: 3),
          child: child,
        ),
      );
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Container(),
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Transform.rotate(
                angle: 180 * pi / 180,
                child: SizedBox(height: 294, child: WaveWidget()),
              )),
          Container(
              alignment: Alignment.center,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(left: 8),
                        child: Image.asset(
                          'assets/img/logo.png',
                          width: 141,
                        )),
                    Container(
                      padding: EdgeInsets.all(2),
                      margin: EdgeInsets.only(top: 20),
                      height: 10,
                      width: 149,
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: Color(0xff9C9C9C)),
                          borderRadius: BorderRadius.circular(4)),
                      child: const LinearProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ])),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SizedBox(height: 294, child: WaveWidget()),
          )
        ],
      ),
    );
  }
}
