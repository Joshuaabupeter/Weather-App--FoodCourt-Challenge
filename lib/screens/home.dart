import 'package:flutter/material.dart';
import 'package:foodcourt/model/cities.dart';
import 'package:foodcourt/model/weather.dart';
import 'package:foodcourt/screens/weatherdata.dart';
import 'package:foodcourt/utils/cities_provider.dart';
import 'package:foodcourt/utils/http_utils.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<WeatherResponse> productsFuture;
  List<String> cityNames = citiesMap.keys.toList();
  String? selectedCity = "Lagos";
  final TextEditingController _citySearchController = TextEditingController();
  late Future<List<WeatherResponse>> weatherListFuture;

  @override
  void initState() {
    super.initState();
    _citySearchController.text = selectedCity!;
    weatherListFuture = loadWeatherForCities(Provider.of<CitiesProvider>(context, listen: false).cities);
  }

  Future<List<WeatherResponse>> loadWeatherForCities(
      List<String> cityList,
      ) async {
    return Future.wait(
      cityList.map((cityName) {
        final city = citiesMap[cityName]!;
        return HttpUtils.getWeatherDetails(city.lat, city.long);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final city = citiesMap[selectedCity];
    productsFuture = HttpUtils.getWeatherDetails(city!.lat, city.long);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 100),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: TextButton(
                                    onPressed: () {  },
                                    child: Text('Find My Weather Report')),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'FoodCourt',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Text(
                                    'Weather App',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),

                      // Search
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 20,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Autocomplete<String>(
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            if (textEditingValue.text.isEmpty) {
                              return const Iterable<String>.empty();
                            }
                            return cityNames
                                .where((String option) {
                              return option.toLowerCase().contains(
                                textEditingValue.text.toLowerCase(),
                              );
                            })
                                .take(5);
                          },
                          optionsViewBuilder: (context, onSelected, options) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                color: Colors.transparent,
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 32,
                                  margin: EdgeInsets.only(top: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.1),
                                        blurRadius: 15,
                                        offset: Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  constraints: BoxConstraints(maxHeight: 200),
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemCount: options.length,
                                    itemBuilder: (context, index) {
                                      final option = options.elementAt(index);
                                      return InkWell(
                                        onTap: () => onSelected(option),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 12,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.grey.withValues(alpha: 0.8),
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.location_city,
                                                color: Colors.grey[600],
                                                size: 18,
                                              ),
                                              SizedBox(width: 12),
                                              Text(
                                                option,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                          onSelected: (String selection) {
                            setState(() {
                              selectedCity = selection;
                              _citySearchController.text = selection;
                            });
                            FocusScope.of(context).unfocus();
                          },
                          fieldViewBuilder: (
                              context,
                              textEditingController,
                              focusNode,
                              onFieldSubmitted,
                              ) {
                            textEditingController.addListener(() {
                              _citySearchController.text = textEditingController.text;
                            });

                            return TextField(
                              controller: textEditingController,
                              focusNode: focusNode,
                              textInputAction: TextInputAction.search,
                              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                              decoration: InputDecoration(
                                hintText: 'Search your city current weather report...',
                                hintStyle: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 16,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ),
                                prefixIcon: Container(
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                suffixIcon: textEditingController.text.isNotEmpty
                                    ? GestureDetector(
                                  onTap: () {
                                    textEditingController.clear();
                                    _citySearchController.clear();
                                    setState(() {
                                      selectedCity = null;
                                    });
                                  },
                                  child: Icon(
                                    Icons.clear,
                                    color: Colors.grey[500],
                                  ),
                                )
                                    : null,
                              ),
                              onSubmitted: (value) {
                                if (value.isNotEmpty) {
                                  final matchingCity = cityNames.firstWhere(
                                        (city) => city.toLowerCase().contains(
                                      value.toLowerCase(),
                                    ),
                                    orElse: () => '',
                                  );
                                  if (matchingCity.isNotEmpty) {
                                    setState(() {
                                      selectedCity = matchingCity;
                                      _citySearchController.text = matchingCity;
                                    });
                                  }
                                }
                              },
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 20),

                      // Weather Display
                      FutureBuilder<WeatherResponse>(
                        future: productsFuture,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.cloud),
                                      SizedBox(width: 5),
                                      Text(snapshot.data!.name),
                                      SizedBox(width: 5),
                                      Text(snapshot.data!.sys!.country),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  SizedBox(
                                    height: 200,
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                            color: Colors.blue[100],
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(18),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              SizedBox(height: 40),
                                              Text(
                                                "${snapshot.data!.main.temp}°C",
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(Icons.location_on_outlined),
                                                  SizedBox(width: 5),
                                                  Text(snapshot.data!.name),
                                                  SizedBox(width: 5),
                                                  Text(snapshot.data!.sys!.country),
                                                ],
                                              ),
                                              Text(
                                                snapshot.data!.weather[0].description,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          right: 40,
                                          bottom: 60,
                                          child: Icon(
                                            Icons.cloud,
                                            size: 100,
                                            color: Colors.lightBlueAccent,
                                          ),
                                        ),
                                        Positioned(
                                          right: 6,
                                          bottom: 110,
                                          child: Icon(
                                            Icons.sunny,
                                            size: 70,
                                            color: Colors.yellow,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),

                                  // Weather Stats Cards
                                  SizedBox(
                                    height: 100,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: WeatherStatCard(
                                            title: 'Min Temp',
                                            icon: Icons.thermostat,
                                            value: "${snapshot.data!.main.tempMin?.toStringAsFixed(1)}°C",
                                          ),
                                        ),
                                        Expanded(
                                          child: WeatherStatCard(
                                            title: 'Humidity',
                                            icon: Icons.water_drop,
                                            value: "${snapshot.data!.main.humidity}%",
                                          ),
                                        ),
                                        Expanded(
                                          child: WeatherStatCard(
                                            title: 'Max Temp',
                                            icon: Icons.thermostat_auto_outlined,
                                            value: "${snapshot.data!.main.tempMax?.toStringAsFixed(1)}°C",
                                          ),
                                        ),
                                        Expanded(
                                          child: WeatherStatCard(
                                            title: 'Wind Speed',
                                            icon: Icons.air_outlined,
                                            value: "${snapshot.data!.wind.speed} Km/h",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return SizedBox(
                              height: 50,
                              child: Center(child: Text('${snapshot.error}')),
                            );
                          }
                          return SizedBox(
                            height: 50,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        },
                      ),

                      SizedBox(height: 10),

                      // City Tabs
                   SizedBox(
                        height: 200,
                        child: FutureBuilder<List<WeatherResponse>>(
                          future: weatherListFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              final weatherList = snapshot.data!;
                              return DefaultTabController(
                                length: weatherList.length,
                                child: Column(
                                  children: [

                                      TabBar(
                                        dividerColor: Colors.blue[100],
                                        isScrollable: true,
                                        indicatorColor: Colors.blue,
                                        tabs: weatherList
                                            .map((weather) => Tab(text: weather.name))
                                            .toList(),
                                      ),
                                    Expanded(
                                      child: TabBarView(
                                        children: weatherList.map((weather) {
                                          return Center(
                                            child: Text(
                                              '${weather.name}: ${weather.main.temp?.toStringAsFixed(1)}°C\n${weather.weather.first.description}',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom positioned widget
            Positioned(
              bottom: 20,
              left: 16,
              right: 16,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.black.withValues(alpha: 0.2),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.cloud_queue_rounded, color: Colors.black, size: 22),
                        SizedBox(width: 8),
                        Text(
                          "Add City",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withValues(alpha: 0.3),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () => showCitySelector(context),
                      icon: Icon(Icons.location_city_rounded),
                      label: Text(
                        "Choose",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showCitySelector(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Select up to 15 cities"),
          content: SingleChildScrollView(
            child: Column(
              children: cityNames.map((city) {
                return CheckboxListTile(
                  title: Text(city),
                  value: Provider.of<CitiesProvider>(context, listen: false).cities.contains(city),
                  onChanged: (bool? selected) {
                    setState(() {
                      if (selected == true) {
                        if (Provider.of<CitiesProvider>(context, listen: false).cities.length < 15 ||
                            !Provider.of<CitiesProvider>(context, listen: false).cities.contains(city)) {
                          Provider.of<CitiesProvider>(context, listen: false).addCity(city);
                        }
                      } else {
                        Provider.of<CitiesProvider>(context, listen: false).removeCity(city);
                      }
                      weatherListFuture = loadWeatherForCities(
                          Provider.of<CitiesProvider>(context, listen: false).cities);
                    });
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Done"),
            )
          ],
        );
      },
    );
  }
}