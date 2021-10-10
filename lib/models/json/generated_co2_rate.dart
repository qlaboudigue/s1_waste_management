import 'package:s1_waste_management/constants.dart';

class GeneratedCo2Rate {

  // PROPERTIES
  final int? burningCo2Rate;
  final int? recyclingCo2Rate;
  final int? compostingCo2Rate;

  // CONSTRUCTOR
  GeneratedCo2Rate({this.burningCo2Rate, this.recyclingCo2Rate, this.compostingCo2Rate});

  // FACTORY
  factory GeneratedCo2Rate.fromJson(Map<String, dynamic> parsedJson) {
    return GeneratedCo2Rate(
        burningCo2Rate: parsedJson[kBurningKey],
        recyclingCo2Rate: parsedJson[kRecyclingKey],
        compostingCo2Rate: parsedJson[kCompostingKey]
    );


  }

}