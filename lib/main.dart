import 'package:flutter/material.dart';
import 'package:s1_waste_management/constants.dart';
import 'package:s1_waste_management/models/business/business.dart';
import 'package:s1_waste_management/models/business/plastic_recycler.dart';
import 'package:s1_waste_management/services/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // INIT
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _calculateGlobalCo2();
  }


  // BUILD
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  // METHODS

  void _calculateGlobalCo2() async {
    /// Get data from json inputs
    final DataService dataService = DataService();
    final Co2Service co2service = Co2Service();
    final data = await dataService.loadData();
    final co2 = await co2service.loadCo2();

    /// Initialize wastes and services map with key:value pairs
    Map<String, double> wasteMap = _initializeMap(kWasteKeys);
    Map<String, double> serviceMap = _initializeMap(kServiceKeys);

    /// Sum and store waste data
    for (var district in data.districts!) {
      wasteMap.update(kPETKey, (value) => value + district.plastics!.pET!);
      wasteMap.update(kPVCKey, (value) => value + district.plastics!.pVC!);
      wasteMap.update(kPCKey, (value) => value + district.plastics!.pC!);
      wasteMap.update(kPEHDKey, (value) => value + district.plastics!.pEHD!);
      wasteMap.update(kPaperKey, (value) => value + district.paper!);
      wasteMap.update(kOrganicKey, (value) => value + district.organic!);
      wasteMap.update(kGlassKey, (value) => value + district.glass!);
      wasteMap.update(kMetalKey, (value) => value + district.metal!);
      wasteMap.update(kOtherKey, (value) => value + district.other!);
    }

    /// Sum and store services data
    for (var service in data.services!) {
      switch (service.type) {
        case kBurnerKey: {
          serviceMap.update(
              kBurnerKey, (value) => value + service.furnaceLines! * service.lineCapacity!);
          break;
        }
        case kPlasticRecyclerKey: {
          serviceMap.update(
              kPlasticRecyclerKey, (value) => value + service.capacity!);
          break;
        }
        case kPaperRecyclerKey: {
          serviceMap.update(
              kPaperRecyclerKey, (value) => value + service.capacity!);
          break;
        }
        case kGlassRecyclerKey: {
          serviceMap.update(
              kGlassRecyclerKey, (value) => value + service.capacity!);
          break;
        }
        case kMetalRecyclerKey: {
          serviceMap.update(
              kMetalRecyclerKey, (value) => value + service.capacity!);
          break;
        }
        case kComposterKey: {
          serviceMap.update(
              kComposterKey, (value) => value + service.foyer! * service.capacity!);
          break;
        }
      }
    }

    /// Check process
    print(wasteMap);
    print(serviceMap);

    /// Init Burner, grey waste & Waste Manager
    Burner burner = Burner(capacity: serviceMap[kBurnerKey]!);
    Waste greyWaste = Waste(type: kOtherKey, quantity: wasteMap[kOtherKey]!, burningCo2Rate: co2.other!.burningCo2Rate!);
    WasteManager wasteManager = WasteManager(burner: burner, greyWaste: greyWaste);


    /// Init waste & service
    /// Plastics
    Recyclable pET = Recyclable(type: kPETKey, quantity: wasteMap[kPETKey]!, recyclingCo2Rate: co2.plastic!.pET!.recyclingCo2Rate!, burningCo2Rate: co2.plastic!.pET!.burningCo2Rate!);
    Recyclable pVC = Recyclable(type: kPVCKey, quantity: wasteMap[kPVCKey]!, recyclingCo2Rate: co2.plastic!.pVC!.recyclingCo2Rate!, burningCo2Rate: co2.plastic!.pVC!.burningCo2Rate!);
    Recyclable pC = Recyclable(type: kPCKey, quantity: wasteMap[kPCKey]!, recyclingCo2Rate: co2.plastic!.pC!.recyclingCo2Rate!, burningCo2Rate: co2.plastic!.pC!.burningCo2Rate!);
    Recyclable pEHD = Recyclable(type: kPEHDKey, quantity: wasteMap[kPEHDKey]!, recyclingCo2Rate: co2.plastic!.pEHD!.recyclingCo2Rate!, burningCo2Rate: co2.plastic!.pEHD!.burningCo2Rate!);
    wasteManager.addRecyclablePlastic(pET);
    wasteManager.addRecyclablePlastic(pVC);
    wasteManager.addRecyclablePlastic(pC);
    wasteManager.addRecyclablePlastic(pEHD);

    for (var service in data.services!) {
      if (service.type == kPlasticRecyclerKey) {
        List<String> acceptedPlastics = service.acceptedPlastics!.map((e) => e.toString()).toList();
        PlasticRecycler plasticRecycler = PlasticRecycler(type: kRecyclingKey, capacity: service.capacity!.toDouble(), acceptedWastes: acceptedPlastics);
        wasteManager.addPlasticRecycler(plasticRecycler);
      }
    }


    /// Paper
    Recyclable paper = Recyclable(type: kPaperKey, quantity: wasteMap[kPaperKey]!, recyclingCo2Rate: co2.paper!.recyclingCo2Rate!, burningCo2Rate: co2.paper!.burningCo2Rate!);
    Recycler paperRecycler = Recycler(type: kPaperRecyclerKey, capacity: serviceMap[kPaperRecyclerKey]!);
    wasteManager.addRecyclable(paper);
    wasteManager.assignRecyclerToRecyclable(paperRecycler, paper);
    /// Glass
    Recyclable glass = Recyclable(type: kGlassKey, quantity: wasteMap[kGlassKey]!, recyclingCo2Rate: co2.glass!.recyclingCo2Rate!, burningCo2Rate: co2.glass!.burningCo2Rate!);
    Recycler glassRecycler = Recycler(type: kGlassRecyclerKey, capacity: serviceMap[kGlassRecyclerKey]!);
    wasteManager.addRecyclable(glass);
    wasteManager.assignRecyclerToRecyclable(glassRecycler, glass);
    /// Metal
    Recyclable metal = Recyclable(type: kMetalKey, quantity: wasteMap[kMetalKey]!, recyclingCo2Rate: co2.metal!.recyclingCo2Rate!, burningCo2Rate: co2.metal!.burningCo2Rate!);
    Recycler metalRecycler = Recycler(type: kMetalRecyclerKey, capacity: serviceMap[kMetalRecyclerKey]!);
    wasteManager.addRecyclable(metal);
    wasteManager.assignRecyclerToRecyclable(metalRecycler, metal);
    /// Compost
    Recyclable organic = Recyclable(type: kOrganicKey, quantity: wasteMap[kOrganicKey]!, recyclingCo2Rate: co2.organic!.compostingCo2Rate!, burningCo2Rate: co2.organic!.burningCo2Rate!);
    Recycler composter = Recycler(type: kComposterKey, capacity: serviceMap[kComposterKey]!);
    wasteManager.addRecyclable(organic);
    wasteManager.assignRecyclerToRecyclable(composter, organic);


    /// Launch waste management operation
    wasteManager.manageBatch();


  }



  /// Initialize map with key:value pairs based on list
  Map<String, double> _initializeMap(List<String> list) {
    Map<String, double> map = Map<String, double>();
    for (var element in list) {
      map[element] = 0;
    }
    return map;
  }

}


