import 'package:s1_waste_management/models/business/business.dart';

class PlasticRecycler extends Recycler {

  // PROPERTIES
  final String type;
  double capacity;
  List<String> acceptedWastes;

  // CONSTRUCTOR
  PlasticRecycler({required this.type, required this.capacity, required this.acceptedWastes}) : super(type: type, capacity: capacity);

  // METHODS
  void updateCapacity(Recyclable plastic) {
    if (plastic.quantity <= capacity) {
      capacity = capacity - plastic.quantity;
    } else {
      capacity = 0.0;
    }
  }

}