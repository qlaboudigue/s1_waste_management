import 'package:s1_waste_management/constants.dart';

class Service {

  // PROPERTIES
  final String? type;
  final int? furnaceLines;
  final int? lineCapacity;
  final int? capacity;
  final List<dynamic>? acceptedPlastics;
  final int? foyer;

  // CONSTRUCTOR
  Service({this.type, this.furnaceLines, this.lineCapacity, this.capacity, this.acceptedPlastics, this.foyer});

  // FACTORY
  factory Service.fromJson(Map<String, dynamic> parsedJson) {
    return Service(
      type: parsedJson[kServiceTypeKey],
      furnaceLines: parsedJson[kLinesQuantityKey],
      lineCapacity: parsedJson[kLineCapacityKey],
      capacity: parsedJson[kCapacityKey],
      acceptedPlastics: parsedJson[kPlasticKey],
      foyer: parsedJson[kFoyerKey],
    );
  }

}