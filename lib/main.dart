import 'package:flutter/material.dart';
import 'package:foodcourt/screens/home.dart';
import 'package:foodcourt/utils/cities_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (context) => CitiesProvider())],
  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of my application.
  @override
  Widget build(BuildContext context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'FoodCourt Weather App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
               primary: Colors.lightBlueAccent,
              //secondary: Colors.redAccent,
            ),
          ),
          home: const MyHomePage(),
        );
        
  }
}
