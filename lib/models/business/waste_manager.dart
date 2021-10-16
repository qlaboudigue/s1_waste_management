import 'package:s1_waste_management/models/business/business.dart';
import 'package:s1_waste_management/models/business/plastic_recycler.dart';

class WasteManager {

  // PROPERTIES
  Burner burner;
  Waste greyWaste;

  List<Recycler> recyclers = [];
  List<Recyclable> recyclables = [];

  List<Recyclable> recyclablePlastics = [];
  List<PlasticRecycler> plasticRecyclers = [];

  Map<String, double> results = {};
  double globalCo2 = 0.0;

  // CONSTRUCTOR
  WasteManager({required this.burner, required this.greyWaste});

  // METHODS
  void addRecyclable (Recyclable recyclable) {
    recyclables.add(recyclable);
  }

  void addRecyclablePlastic (Recyclable plastic) {
    recyclablePlastics.add(plastic);
  }

  void addPlasticRecycler (PlasticRecycler plasticRecycler) {
    plasticRecyclers.add(plasticRecycler);
  }

  void assignRecyclerToRecyclable(Recycler recycler, Recyclable recyclable) {
    recyclable.recycler = recycler;
  }

  void manageBatch() {
    /// Manage plastics
    /// First : Try to recycle
    for (var plastic in recyclablePlastics) {
      // Init map key:value pair
      results[plastic.type] = 0.0;
      for (var plasticRecycler in plasticRecyclers) {
        if (plasticRecycler.acceptedWastes.contains(plastic.type)) {
          if (plastic.quantity <= plasticRecycler.capacity) {
            /// The whole quantity can be recycled
            var generatedCo2 = plastic.quantity * plastic.recyclingCo2Rate;
            plasticRecycler.updateCapacity(plastic);
            plastic.updateQuantity(0.0);
            results.update(plastic.type, (value) => value + generatedCo2);
            globalCo2 = globalCo2 + generatedCo2;
          } else {
            /// The recycler reaches its limits, the rest has to be tracked for the next recycler or the final burn
            var generatedCo2 = plasticRecycler.capacity * plastic.recyclingCo2Rate;
            plasticRecycler.updateCapacity(plastic);
            plastic.updateQuantity(plastic.quantity - plasticRecycler.capacity);
            results.update(plastic.type, (value) => value + generatedCo2);
            globalCo2 = globalCo2 + generatedCo2;
          }
        }
      }
    }
    /// Second : Burn the rest
    for (var plastic in recyclablePlastics) {
      var additionalCo2 = burner.burnWaste(plastic.quantity, plastic);
      results.update(plastic.type, (value) => value + additionalCo2);
      globalCo2 = globalCo2 + additionalCo2;
    }

    /// Manage others recyclables
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

  Map<String, double> showCo2ByWasteType() {
    Map<String, double> co2Results = {};
    results.forEach((key, value) {
      co2Results[key] = double.parse(value.toStringAsFixed(2));
    });
    return co2Results;
  }



}






