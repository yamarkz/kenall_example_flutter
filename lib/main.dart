import 'package:flutter/material.dart';
import 'package:kenall_example_flutter/get_address_screen.dart';
import 'package:kenall_example_flutter/get_city_screen.dart';
import 'package:kenall_example_flutter/home_screen.dart';
import 'package:kenall_example_flutter/search_address_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Kenall Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
      routes: {
        '/get_address': (context) => GetAddressScreen(),
        '/get_city': (context) => GetCityScreen(),
        '/search_address': (context) => SearchAddressScreen(),
      },
    );
  }
}
