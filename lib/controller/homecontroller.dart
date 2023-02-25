import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weathermodel.dart';

getweather(String cityName) async {
  try {
    final queryParameters = {
      'q': '$cityName',
      'appid': '6fed5a8a74b02be56f002ff4251f89b4'
    };
    var uri = Uri.https(
        "api.openweathermap.org", "/data/2.5/weather", queryParameters);
    var response = await http.get(uri);
    var jsondata = jsonDecode(response.body);

    print(jsondata);
    List<Weathermodel> weatherinfo = [];
    Weathermodel weatherdata = Weathermodel(
      cityname: jsondata['name'],
      temp: jsondata['main']['temp'],
      wind: jsondata['wind']['speed'],
      pressure: jsondata['main']['pressure'],
      humidity: jsondata['main']['humidity'],
      feelslike: jsondata['main']['feels_like'],
      degree: jsondata['wind']['deg'],
      // description: jsondata['weather']['description'],
    );
    weatherinfo.add(weatherdata);

    return weatherinfo;
  } catch (e) {
    throw Exception('Failed to load weather data');
  }
}
  // if (response.statusCode == 200) {
  //   return Weathermodel.fromJson(json.decode(response.body));
  // } else {
  //   throw Exception('Failed to load weather data');
  // }


