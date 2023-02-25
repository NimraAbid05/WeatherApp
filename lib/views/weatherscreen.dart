import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/controller/homecontroller.dart';
import 'package:weather_app/utils/colors.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String? cityName = 'Karachi';
  DateTime currentdate = new DateTime.now();
  @override
  Widget build(BuildContext context) {
    String dateformat = new DateFormat('E d MMMM').format(currentdate);
    String timeformat = DateFormat(' hh:mm a').format(DateTime.now());
    return Scaffold(
        backgroundColor: ColorConstraint.themecolor,
        appBar: AppBar(
          backgroundColor: ColorConstraint.themecolor,
          elevation: 0,
          centerTitle: true,
          leading: Icon(Icons.sort, color: Colors.white),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 100.0),
              child: Row(
                children: [
                  Text("$cityName"),
                  Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          ],
        ),
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
                    return Text("Sorry! There is no data");
                  } else {
                    return Container(
                      width: MediaQuery.of(context).size.width * 100,
                      height: MediaQuery.of(context).size.height * 40,
                      decoration: BoxDecoration(
                          color: ColorConstraint.theme,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 30,
                            left: 20,
                            child: Container(
                                child: Text(
                              "$cityName",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                          ),
                          Positioned(
                            top: 70,
                            left: 20,
                            child: Container(
                                child: Row(children: [
                              Text(
                                '$dateformat',
                                style: TextStyle(
                                  color: Color.fromRGBO(
                                    250,
                                    156,
                                    20,
                                    1.0,
                                  ),
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '$timeformat',
                                style: TextStyle(
                                  color: Color.fromRGBO(
                                    250,
                                    156,
                                    20,
                                    1.0,
                                  ),
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ])),
                          ),

                          Positioned(
                            top: 150,
                            left: 20,
                            child: Container(
                                child: Text(
                              "${(snapshot.data[0].temp - 273).toStringAsFixed(0)}°C",
                              style: TextStyle(
                                color: Color.fromRGBO(
                                  250,
                                  156,
                                  20,
                                  1.0,
                                ),
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                          ),
                          Positioned(
                              left: 240,
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    0.3,
                                child: Image.asset(
                                    'images/logo.png'),
                              )),

                          // Positioned(
                          //   top: 180,
                          //   left: 20,
                          //   child: Container(
                          //     child: Text(
                          //        "Clear sky",
                          //       style: TextStyle(
                          //         fontSize: 20,
                          //         color: Colors.white,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    );
                  }
              }
            }));
  }
}
