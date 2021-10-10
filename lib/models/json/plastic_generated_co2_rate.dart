import 'package:s1_waste_management/constants.dart';
import 'package:s1_waste_management/models/json/json.dart';

class PlasticGeneratedCo2Rate {

  // PROPERTIES
  final GeneratedCo2Rate? pET;
  final GeneratedCo2Rate? pVC;
  final GeneratedCo2Rate? pC;
  final GeneratedCo2Rate? pEHD;

  // CONSTRUCTOR
  PlasticGeneratedCo2Rate({this.pET, this.pVC, this.pC, this.pEHD});

  // FACTORY
  factory PlasticGeneratedCo2Rate.fromJson(Map<String, dynamic> parsedJson) {
    return PlasticGeneratedCo2Rate(
        pET: GeneratedCo2Rate.fromJson(parsedJson[kPETKey]),
        pVC: GeneratedCo2Rate.fromJson(parsedJson[kPVCKey]),
        pC: GeneratedCo2Rate.fromJson(parsedJson[kPCKey]),
        pEHD: GeneratedCo2Rate.fromJson(parsedJson[kPEHDKey])
    );
  }



}