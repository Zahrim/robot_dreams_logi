import 'package:robot_dreams_logi/data/models/location.dart';

class OrderData {
  late final String _strNumber;
  late final String _strBroker;
  late final double _dWeight;
  late final LocationData _lPickUp;
  late final LocationData _lDrop;

  String get number => _strNumber;

  String get broker => _strBroker;

  double get weight => _dWeight;

  LocationData get pickup => _lPickUp;

  LocationData get drop => _lDrop;

  OrderData.fromAPI(Map<String, dynamic> item) {
    _strNumber = item['number'];
    _strBroker = item['broker'];
    _dWeight = double.parse(item['weight']);
    _lPickUp = LocationData.fromAPI(item["pick_up"]);
    _lDrop = LocationData.fromAPI(item["drop"]);
  }
}
