import 'dart:convert';

import 'package:robot_dreams_logi/domain/models/location.dart';

class Order {
  late final String _strNumber;
  late final String _strBroker;
  late final double _dWeight;
  late final Location _lPickUp;
  late final Location _lDrop;

  Order(String number, String broker, double weight, Location pickup, Location drop) {
    _strNumber = number;
    _strBroker = broker;
    _dWeight = weight;
    _lPickUp = pickup;
    _lDrop = drop;
  }

  String get number => _strNumber;

  String get broker => _strBroker;

  double get weight => _dWeight;

  Location get pickup => _lPickUp;

  Location get drop => _lDrop;

  factory Order.fromJson(Map<String, dynamic> item) {
    String ste = "";

    final locationPickUp = Location.fromJson(item["pick_up"]);
    final locationDrop = Location.fromJson(item["drop"]);

    return Order(item['number'], item['broker'], double.parse(item['weight']), locationPickUp, locationDrop);
  }
}
