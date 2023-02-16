import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather_app/model/weathermodel.dart';

getweather() async {
  var baseurl =
      "https://api.openweathermap.org/data/2.5/weather?q=karachi&appid=f5783e1fee68d6228723ecc46804ee40";
  var url = Uri.parse(baseurl);
  var res = await http.get(url);
  var jsonRes = jsonDecode(res.body);
  print(res.statusCode);
  print(res.body);
  Map mydata = jsonRes["coord"];
  print(mydata);

  return jsonRes;
}
