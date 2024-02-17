import "dart:convert";

import "package:geocoding/geocoding.dart";
import "package:geolocator/geolocator.dart";
import "package:http/http.dart" as http;

import "../../model/weather_model.dart";

///weather api function

class WeatherService {
  static const Url = "http://api.openweathermap.org/data/2.5/weather";
  final String apikey;

  WeatherService(this.apikey);

  Future<Weather> getData(String cityName) async {
    final response = await http
        .get(Uri.parse("$Url?q=$cityName&appid=$apikey&units=metric"));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("failed");
    }
  }

  Future<String> getCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);

    String? city = placemarks[0].locality;
    return city ?? "";
  }
}
