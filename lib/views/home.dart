import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weather_app/controller/homecontroller.dart';

class Dashboard_View extends StatefulWidget {
  const Dashboard_View({super.key});

  @override
  State<Dashboard_View> createState() => _Dashboard_ViewState();
}

class _Dashboard_ViewState extends State<Dashboard_View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
                onPressed: () {
                  getdata();
                },
                child: Text("Get Data")),
          )
        ],
      ),
    );
  }
}
