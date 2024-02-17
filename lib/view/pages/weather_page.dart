import 'package:flutter/material.dart';

import '../../model/weather_model.dart';
import '../../view-model/services/weather_services.dart';


class WeatherContainer extends StatefulWidget {
  const WeatherContainer({super.key});

  @override
  State<WeatherContainer> createState() => _WeatherContainerState();
}

class _WeatherContainerState extends State<WeatherContainer> {
  ///weather api

  final _weatherService = WeatherService("64451215b2a5c4cb8e183187e9ba4c32");

  Weather? _weather;

  fetchWeather() async {
    String cityName = await _weatherService.getCity();

    try {
      final weather = await _weatherService.getData(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    fetchWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      _weather==null ? const CircularProgressIndicator():

      ///weather container

      Container(
        height: 240,
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _weather?.cityname ?? "Connect to Wifi...",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.w700),
              ),
              Row(
                children: [
                  Text(
                    "Feels like",
                    style: TextStyle(fontSize: 30, color: Colors.grey.shade50),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "${_weather?.temprature.round().toString()}°C",
                    style: TextStyle(fontSize: 30, color: Colors.grey.shade900),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.thermostat_outlined,
                    size: 30,
                    color: Colors.grey.shade900,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    _weather?.condition ?? "",
                    style: const TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.wb_cloudy_outlined,
                    color: Colors.blueGrey,
                    size: 100,
                  )
                ],
              )
            ],
          ),
        ),
      );
  }
}
