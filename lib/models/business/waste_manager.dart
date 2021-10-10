import 'package:s1_waste_management/models/business/business.dart';

class WasteManager {

  // PROPERTIES
  Burner burner;
  Waste greyWaste;
  List<Recycler> recyclers = [];
  List<Recyclable> recyclables = [];

  Map<String, double> results = {};
  double globalCo2 = 0.0;

  // CONSTRUCTOR
  WasteManager({required this.burner, required this.greyWaste});

  // METHODS
  void addRecyclable (Recyclable recyclable) {
    recyclables.add(recyclable);
  }

  void assignRecyclerToRecyclable(Recycler recycler, Recyclable recyclable) {
    recyclable.recycler = recycler;
  }

  void manageBatch() {
    /// Manage recyclables
    for (var recyclable in recyclables) {
      // Init map key:value pair
      results[recyclable.type] = 0.0;
      if (recyclable.quantity <= recyclable.recycler!.capacity) {
        /// Quantity is inferior to recycler capacity
        var generatedCo2 = recyclable.quantity * recyclable.recyclingCo2Rate;
        results.update(recyclable.type, (value) => value + generatedCo2);
        globalCo2 = globalCo2 + generatedCo2;
      } else {
        /// Quantity is superior to recycler capacity
        var generatedCo2 = recyclable.recycler!.capacity * recyclable.recyclingCo2Rate;
        results.update(recyclable.type, (value) => value + generatedCo2);
        globalCo2 = globalCo2 + generatedCo2;
        /// The leftOver is burned
        var leftOver = recyclable.quantity - recyclable.recycler!.capacity;
        var additionalCo2 = burner.burnWaste(leftOver, recyclable);
        results.update(recyclable.type, (value) => value + additionalCo2);
        globalCo2 = globalCo2 + additionalCo2;
      }
    }

    /// Manage others = grey waste
    results[greyWaste.type] = 0.0;
    var lastGeneratedCo2 = burner.burnWaste(greyWaste.quantity, greyWaste);
    results.update(greyWaste.type, (value) => value + lastGeneratedCo2);
    globalCo2 = globalCo2 + lastGeneratedCo2;

    /// Display results
    print(results);
    print('Global co2: $globalCo2');

  }



}






