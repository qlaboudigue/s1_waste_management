import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:s1_waste_management/models/json/json.dart';


class DataService {

  Future _loadADataAsset() async {
    return await rootBundle.loadString('assets/data.json');
  }

  Future<Data> loadData() async {
    String jsonString = await _loadADataAsset();
    final jsonResponse = json.decode(jsonString);
    Data data = Data.fromJson(jsonResponse);
    return data;
  }


}