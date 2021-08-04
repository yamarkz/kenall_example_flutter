import 'package:dart_kenall/dart_kenall.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetAddressScreen extends StatefulWidget {
  GetAddressScreen({Key? key}) : super(key: key);

  @override
  _GetAddressScreenState createState() => _GetAddressScreenState();
}

class _GetAddressScreenState extends State<GetAddressScreen> {
  final textController = TextEditingController();

  final _addressList = <Address>[];

  final kenallClient = KenallClient(
    Config(apiKey: ''),
    http.Client(),
  );

  Future<void> _submit() async {
    setState(() {
      _addressList.clear();
    });
    final postalCode = textController.text;
    try {
      final response = await kenallClient.getAddress(postalCode: postalCode);
      setState(() {
        _addressList.addAll(response.addresses);
      });
    } catch (error) {
      // TODO: Error handle
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Address'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    autofocus: true,
                    maxLength: 7,
                    decoration: InputDecoration(
                      labelText: 'PostalCode',
                      hintText: '1000001',
                    ),
                  ),
                ),
                SizedBox(width: 4),
                TextButton(
                  child: Text('submit'),
                  onPressed: _submit,
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey, height: 0),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: ListView.builder(
                itemCount: _addressList.length,
                itemBuilder: (BuildContext context, int index) {
                  final address = _addressList[index];
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('jisx0402: ${address.jisx0402}'),
                          Text('oldCode: ${address.oldCode}'),
                          Text('postalCode: ${address.postalCode}'),
                          Text('prefecture: ${address.prefecture}'),
                          Text('prefectureKana: ${address.prefectureKana}'),
                          Text('city: ${address.city}'),
                          Text('cityKana: ${address.cityKana}'),
                          Text('town: ${address.town}'),
                          Text('townKana: ${address.townKana}'),
                          Text('townRaw: ${address.townRaw}'),
                          Text('townKanaRaw: ${address.townKanaRaw}'),
                          Text('koaza: ${address.koaza}'),
                          Text('kyotoStreet: ${address.kyotoStreet}'),
                          Text('building: ${address.building}'),
                          Text('floor: ${address.floor}'),
                          Text('townPartial: ${address.townPartial}'),
                          Text(
                              'townAddressedKoaza: ${address.townAddressedKoaza}'),
                          Text('townMulti: ${address.townMulti}'),
                          Text('townChome: ${address.townChome}'),
                          Text('corporation: ${address.corporation}'),
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
