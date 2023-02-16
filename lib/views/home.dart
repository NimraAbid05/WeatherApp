import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weather_app/controller/homecontroller.dart';
import 'package:weather_app/model/weathermodel.dart';

class Dashboard_View extends StatefulWidget {
  const Dashboard_View({super.key});

  @override
  State<Dashboard_View> createState() => _Dashboard_ViewState();
}

class _Dashboard_ViewState extends State<Dashboard_View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
     

      body: FutureBuilder(
        future: getweather(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    // without model
                    title: Text(snapshot.data[index]["coord"]),
                    // subtitle: Text(snapshot.data[index]["weather"]),
                    // title: Text(snapshot.data[index].id),
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
