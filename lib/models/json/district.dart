import 'package:s1_waste_management/constants.dart';
import 'package:s1_waste_management/models/json/json.dart';

class District {

  // PROPERTIES
  final int? population;
  final Plastic? plastics;
  final double? paper;
  final double? organic;
  final double? glass;
  final double? metal;
  final double? other;

  // CONSTRUCTOR
  District({this.population, this.plastics, this.paper, this.organic, this.glass, this.metal, this.other});

  // FACTORY CONSTRUCTOR
  factory District.fromJson(Map<String, dynamic> parsedJson) {
    return District(
      plastics: Plastic.fromJson(parsedJson[kPlasticKey]),
      paper: parsedJson[kPaperKey],
      organic: parsedJson[kOrganicKey],
      glass: parsedJson[kGlassKey],
      metal: parsedJson[kMetalKey],
      other: parsedJson[kOtherKey],
    );
  }

}