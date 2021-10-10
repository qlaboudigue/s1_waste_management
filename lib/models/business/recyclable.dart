import 'package:s1_waste_management/models/business/business.dart';

class Recyclable extends Waste {

  // PROPERTIES
  final String type;
  final double quantity;
  final int recyclingCo2Rate;
  Recycler? recycler;
  final int burningCo2Rate;

  // CONSTRUCTOR
  Recyclable({required this.type, required this.quantity, required this.recyclingCo2Rate, required this.burningCo2Rate}) : super(type: type, quantity: quantity, burningCo2Rate: burningCo2Rate);

}