import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

getdata() async {
  // final String cityName = 'New York';
  var apiKey =
      "https://api.openweathermap.org/data/2.5/weather?q=karachi&appid=f5783e1fee68d6228723ecc46804ee40"; // Replace with your OpenWeatherMap API key

  var url = Uri.parse(apiKey);

  var response = await get(url);
  var resdata = jsonDecode(response.body);
  if (response.statusCode == 200) {
    final temperature = resdata['main'];
    final actualtemperature = resdata['temp'];
    print(temperature);
    print(actualtemperature);
    // final weatherDescription = resdata['weather'][0]['description'];

  } else {
    print('Error: ${response.statusCode}');
  }
}
