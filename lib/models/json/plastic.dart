import 'package:s1_waste_management/constants.dart';

class Plastic {

  // PROPERTIES
  final double? pET;
  final double? pVC;
  final double? pC;
  final double? pEHD;

  // CONSTRUCTOR
  Plastic({this.pET, this.pVC, this.pC, this.pEHD});

  // FACTORY CONSTRUCTOR
  factory Plastic.fromJson(Map<String, dynamic> parsedJson) {
    return Plastic(
      pET: parsedJson[kPETKey],
      pVC: parsedJson[kPVCKey],
      pC: parsedJson[kPCKey],
      pEHD: parsedJson[kPEHDKey],
    );
  }

}