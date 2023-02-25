import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weather_app/controller/homecontroller.dart';
import 'package:weather_app/utils/colors.dart';

class Dashboard_View extends StatefulWidget {
  const Dashboard_View({super.key});

  @override
  State<Dashboard_View> createState() => _Dashboard_ViewState();
}

class _Dashboard_ViewState extends State<Dashboard_View> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: ColorConstraint.background,
      body: SingleChildScrollView(
        child: Column(
          
          children: [
            Container(
              child: Stack(children: [
                Container(
                  width: size.width,
                  height: size.height * 0.75,
                  // margin: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    gradient: LinearGradient(
                        colors: [
                          ColorConstraint.theme,
                          ColorConstraint.themecolor,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [0.2, 0.85]),
                  ),
                ),
                Container(
                  width: size.width * 0.50,
                  height: size.height * 0.20,
                  margin: EdgeInsets.all(110),
                  decoration: BoxDecoration(),
                  child: Column(
                
                    children: [
                      Text("CITY",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 50),),
                      SizedBox(height: 60,),
                      Text("32 C",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 40),),
           
                    ],
                  ),
                ),
                
               
              ]),
            ),
            SizedBox(
              height: 10,
            ),
             Container(
                  width: 300,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                
                  ),
                  child: TextField(
                  decoration: InputDecoration(
               
               labelText: "Search",
              suffixIcon: InkWell(
                onTap: () {
                  
                },
                child: Icon(Icons.search)),
                  ),  
                  ),
                )
          ],
          
        ),
      ),
    ));
  }
}
