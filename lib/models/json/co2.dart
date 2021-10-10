import 'package:s1_waste_management/constants.dart';
import 'package:s1_waste_management/models/json/json.dart';

class Co2 {

  // PROPERTIES
  final PlasticGeneratedCo2Rate? plastic;
  final GeneratedCo2Rate? paper;
  final GeneratedCo2Rate? organic;
  final GeneratedCo2Rate? glass;
  final GeneratedCo2Rate? metal;
  final GeneratedCo2Rate? other;

  // CONSTRUCTOR
  Co2({this.plastic, this.paper, this.organic, this.glass, this.metal, this.other});

  // FACTORY
  factory Co2.fromJson(Map<String, dynamic> parsedJson) {
    return Co2(
      plastic: PlasticGeneratedCo2Rate.fromJson(parsedJson[kPlasticKey]),
      paper: GeneratedCo2Rate.fromJson(parsedJson[kPaperKey]),
      organic: GeneratedCo2Rate.fromJson(parsedJson[kOrganicKey]),
      glass: GeneratedCo2Rate.fromJson(parsedJson[kGlassKey]),
      metal: GeneratedCo2Rate.fromJson(parsedJson[kMetalKey]),
      other: GeneratedCo2Rate.fromJson(parsedJson[kOtherKey]),
    );
  }

}