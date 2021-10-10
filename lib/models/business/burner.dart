import 'package:s1_waste_management/models/business/business.dart';

class Burner {

  // PROPERTIES
  double capacity;

  // CONSTRUCTOR
  Burner({required this.capacity});

  // METHODS
  double burnWaste (double wasteQuantity, Waste waste) {
    if (wasteQuantity <= capacity) {
      /// Update burner capacity
      capacity = capacity - wasteQuantity;
      /// Get generated Co2
      var generatedCo2 = wasteQuantity * waste.burningCo2Rate;
      return generatedCo2;
    } else {
      var generatedCo2 = capacity * waste.burningCo2Rate;
      capacity = 0.0;
      return generatedCo2;
    }



  }

}