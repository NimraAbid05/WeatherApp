import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/controller/homecontroller.dart';
import 'package:weather_app/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _textController = TextEditingController();
  String? cityName = 'Karachi';
  DateTime currentdate = new DateTime.now();
  String? searchcity = '';
  @override
  Widget build(BuildContext context) {
    String dateformat = new DateFormat('E d MMMM').format(currentdate);
    String timeformat = DateFormat(' hh:mm a').format(DateTime.now());
    return SafeArea(
        child: Scaffold(
      body: FutureBuilder(
          future: getweather('$cityName'),
          builder: (context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('none');
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
                return Text('');
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text(
                    '${snapshot.error}',
                    style: TextStyle(color: Colors.red),
                  );
                }
                if (snapshot.data == null) {
                  return Text("Something went wrong!");
                } else {
                  return Container(
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
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: ColorConstraint.search,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.25),
                                      spreadRadius: 0,
                                      blurRadius: 4,
                                      offset: Offset(
                                          0, 4), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'City, Country?,',
                                      prefixIcon: Icon(Icons.location_on,
                                          color: Colors.white),
                                      border: InputBorder.none,
                                    ),
                                    controller: _textController,
                                    onSubmitted: (value) {
                                      searchcity = value;
                                      setState(() {
                                        cityName == searchcity;
                                        cityName = _textController.text;
                                        getweather('$cityName');
                                      });
                                    }),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    spreadRadius: 0,
                                    blurRadius: 2,
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                backgroundColor: ColorConstraint.search,
                                radius: 25,
                                child: IconButton(
                                    onPressed: () {
                                      controller:
                                      _textController;
                                      onSubmitted:
                                      (value) {
                                        searchcity = value;
                                        setState(() {
                                          cityName == searchcity;
                                          cityName = _textController.text;
                                          getweather('$cityName');
                                        });
                                      };
                                    },
                                    icon: Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    )),
                              ),
                            )
                          ],
                        ),
                        Positioned(
                          top: 100,
                          left: 23,
                          child: Container(
                              child: Text(
                            "$cityName",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Positioned(
                          left: 23,
                          top: 140,
                          child: Text(
                            '$dateformat',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 160,
                          left: 21,
                          child: Text(
                            '$timeformat',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 200,
                          top: 90,
                          child: Stack(
                            children: [
                              Image.asset('images/cloud.png'),
                              Positioned(
                                top: 50,
                                left: 35,
                                child: Text(
                                  "${(snapshot.data[0].temp - 273).toStringAsFixed(0)}°C",
                                  style: TextStyle(
                                    color: ColorConstraint.background,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          top: 230,
                          left: 16,
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.099,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Percipitation",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: ColorConstraint.FONTS)),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Text("${(snapshot.data[0].pressure)} Hg",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: ColorConstraint.font)),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Image.asset("images/rain.png"),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ColorConstraint.box,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.25),
                                      spreadRadius: 0,
                                      blurRadius: 4,
                                      offset: Offset(
                                          0, 4), // changes position of shadow
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.099,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Humidity",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: ColorConstraint.FONTS)),
                                    SizedBox(
                                      width: 60,
                                    ),
                                    Text("${(snapshot.data[0].humidity)}%",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: ColorConstraint.font)),
                                    SizedBox(
                                      width: 80,
                                    ),
                                    Image.asset("images/drop.png"),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ColorConstraint.box,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.25),
                                      spreadRadius: 0,
                                      blurRadius: 4,
                                      offset: Offset(
                                          0, 4), // changes position of shadow
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.099,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Wind",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: ColorConstraint.FONTS)),
                                    SizedBox(
                                      width: 80,
                                    ),
                                    Text("${(snapshot.data[0].wind)} Km/h",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: ColorConstraint.font)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Image.asset("images/wind.png"),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ColorConstraint.box,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.25),
                                      spreadRadius: 0,
                                      blurRadius: 4,
                                      offset: Offset(
                                          0, 4), // changes position of shadow
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 17,
                              ),
                              Text("Next Day Updates",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: ColorConstraint.FONTS)),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 530,
                          child: SingleChildScrollView(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      CircleAvatar(
                                        backgroundColor: ColorConstraint.circle,
                                        radius: 28,
                                        child: Text("MON",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: ColorConstraint.FONTS)),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("${(snapshot.data[0].degree)}°",
                                          style: TextStyle(
                                              fontSize: 23,
                                              color: ColorConstraint.FONTS)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("${(snapshot.data[0].degree)}°",
                                          style: TextStyle(
                                              fontSize: 23,
                                              color: ColorConstraint.FONTS)),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Image.asset("images/sun.png"),
                                    ],
                                  ),
                                  width: 69,
                                  height: 184,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: ColorConstraint.container,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 4), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      CircleAvatar(
                                        backgroundColor: ColorConstraint.circle,
                                        radius: 28,
                                        child: Text("TUE",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: ColorConstraint.FONTS)),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("${(snapshot.data[0].degree)}°",
                                          style: TextStyle(
                                              fontSize: 23,
                                              color: ColorConstraint.FONTS)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("${(snapshot.data[0].degree)}°",
                                          style: TextStyle(
                                              fontSize: 23,
                                              color: ColorConstraint.FONTS)),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Image.asset("images/sun.png"),
                                    ],
                                  ),
                                  width: 69,
                                  height: 184,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: ColorConstraint.container,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 4), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      CircleAvatar(
                                        backgroundColor: ColorConstraint.circle,
                                        radius: 28,
                                        child: Text("WED",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: ColorConstraint.FONTS)),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("${(snapshot.data[0].degree)}°",
                                          style: TextStyle(
                                              fontSize: 23,
                                              color: ColorConstraint.FONTS)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("${(snapshot.data[0].degree)}°",
                                          style: TextStyle(
                                              fontSize: 23,
                                              color: ColorConstraint.FONTS)),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Image.asset("images/sun.png"),
                                    ],
                                  ),
                                  width: 69,
                                  height: 184,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: ColorConstraint.container,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 4), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      CircleAvatar(
                                        backgroundColor: ColorConstraint.circle,
                                        radius: 28,
                                        child: Text("THU",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: ColorConstraint.FONTS)),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("${(snapshot.data[0].degree)}°",
                                          style: TextStyle(
                                              fontSize: 23,
                                              color: ColorConstraint.FONTS)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("${(snapshot.data[0].degree)}°",
                                          style: TextStyle(
                                              fontSize: 23,
                                              color: ColorConstraint.FONTS)),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Image.asset("images/sun.png"),
                                    ],
                                  ),
                                  width: 69,
                                  height: 184,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: ColorConstraint.container,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 4), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      CircleAvatar(
                                        backgroundColor: ColorConstraint.circle,
                                        radius: 28,
                                        child: Text("FRI",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: ColorConstraint.FONTS)),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("${(snapshot.data[0].degree)}°",
                                          style: TextStyle(
                                              fontSize: 23,
                                              color: ColorConstraint.FONTS)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("${(snapshot.data[0].degree)}°",
                                          style: TextStyle(
                                              fontSize: 23,
                                              color: ColorConstraint.FONTS)),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Image.asset("images/sun.png"),
                                    ],
                                  ),
                                  width: 69,
                                  height: 184,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: ColorConstraint.container,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 4), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      CircleAvatar(
                                        backgroundColor: ColorConstraint.circle,
                                        radius: 28,
                                        child: Text("SAT",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: ColorConstraint.FONTS)),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("${(snapshot.data[0].degree)}°",
                                          style: TextStyle(
                                              fontSize: 23,
                                              color: ColorConstraint.FONTS)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("${(snapshot.data[0].degree)}°",
                                          style: TextStyle(
                                              fontSize: 23,
                                              color: ColorConstraint.FONTS)),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Image.asset("images/sun.png"),
                                    ],
                                  ),
                                  width: 69,
                                  height: 184,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: ColorConstraint.container,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 4), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
            }
          }),
    ));
  }
}
