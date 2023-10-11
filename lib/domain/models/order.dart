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

/*
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      _
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
    );
  }
  */
}
