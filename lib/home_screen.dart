import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlinedButton(
              child: Text('Get Address'),
              onPressed: () {
                Navigator.pushNamed(context, '/get_address');
              },
            ),
            OutlinedButton(
              child: Text('Search Address'),
              onPressed: () {
                Navigator.pushNamed(context, '/search_address');
              },
            ),
            OutlinedButton(
              child: Text('Get City'),
              onPressed: () {
                Navigator.pushNamed(context, '/get_city');
              },
            ),
          ],
        ),
      ),
    );
  }
}
