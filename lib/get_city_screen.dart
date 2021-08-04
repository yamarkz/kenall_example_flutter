import 'package:dart_kenall/dart_kenall.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetCityScreen extends StatefulWidget {
  GetCityScreen({Key? key}) : super(key: key);

  @override
  _GetCityScreenState createState() => _GetCityScreenState();
}

class _GetCityScreenState extends State<GetCityScreen> {
  final _cityList = <City>[];

  Prefecture? _selectedPrefecture;

  final prefectures = <Prefecture>[];

  final kenallClient = KenallClient(
    Config(apiKey: ''),
    http.Client(),
  );

  void initState() {
    prefectureCode.entries.forEach((e) => prefectures.add(
          Prefecture(name: e.key, code: e.value),
        ));
    super.initState();
  }

  Future<void> _submit() async {
    setState(() {
      _cityList.clear();
    });
    try {
      final response = await kenallClient.getCities(
        prefectureCode: _selectedPrefecture!.code,
      );
      setState(() {
        _cityList.addAll(response.cities);
      });
    } catch (error) {
      print(error);
      // TODO: Error handle
    }
  }

  void select(Prefecture? prefecture) {
    if (prefecture == null) return;
    setState(() {
      _selectedPrefecture = prefecture;
    });
    _submit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get City'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(
                  onChanged: select,
                  value: _selectedPrefecture,
                  selectedItemBuilder: (context) {
                    return prefectures.map((e) {
                      return Text(
                        e.name,
                      );
                    }).toList();
                  },
                  items: prefectures.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(
                        e.name,
                      ),
                    );
                  }).toList(),
                  underline: Container(height: 0),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  iconSize: 24,
                  itemHeight: 50.0,
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey, height: 0),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: ListView.builder(
                itemCount: _cityList.length,
                itemBuilder: (BuildContext context, int index) {
                  final city = _cityList[index];
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('jisx0402: ${city.jisx0402}'),
                          Text('prefectureCode: ${city.prefectureCode}'),
                          Text('cityCode: ${city.cityCode}'),
                          Text('prefectureKana: ${city.prefectureKana}'),
                          Text('cityKana: ${city.cityKana}'),
                          Text('prefecture: ${city.prefecture}'),
                          Text('city: ${city.city}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Prefecture {
  final String name;
  final String code;

  const Prefecture({required this.name, required this.code});
}
