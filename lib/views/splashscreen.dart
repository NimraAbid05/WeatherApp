import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weather_app/views/homescreen.dart';

import '../utils/colors.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorConstraint.background,
            ColorConstraint.bg2,
          ],
        ),
      ),
      child: Stack(children: [
        Positioned(
          top: 250,
          left: 40,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(children: [
              Image.asset(
                "images/logo.png",
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "Your Ultimate Weather App",
                style: TextStyle(
                  color: ColorConstraint.FONTS,
                  fontSize: 25,
                ),
              ),
            ]),
          ),
        ),
      ]),
    ));
  }
}
