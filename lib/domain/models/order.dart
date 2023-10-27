import 'package:robot_dreams_logi/domain/models/location.dart';

class Order {
  late String _strNumber;
  late String _strBroker;
  late double _dWeight;
  late Location _lPickUp;
  late Location _lDrop;
  late String status;

  Order(String number, String broker, double weight, Location pickup,
      Location drop) {
    _strNumber = number;
    _strBroker = broker;
    _dWeight = weight;
    _lPickUp = pickup;
    _lDrop = drop;
    status = 'Waiting for Vehicle';
  }

  String get number => _strNumber;

  String get broker => _strBroker;

  double get weight => _dWeight;

  Location get pickup => _lPickUp;

  Location get drop => _lDrop;
}
