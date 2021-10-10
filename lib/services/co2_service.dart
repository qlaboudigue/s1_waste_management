import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:s1_waste_management/models/json/json.dart';

class Co2Service {

  Future _loadACo2Asset() async {
    return await rootBundle.loadString('assets/co2.json');
  }

  Future<Co2> loadCo2() async {
    String jsonString = await _loadACo2Asset();
    final jsonResponse = json.decode(jsonString);
    Co2 co2 = Co2.fromJson(jsonResponse);
    return co2;
  }


}