import 'package:robot_dreams_logi/domain/models/location.dart';

class Order {
  final String _strNumber;
  final String _strBroker;
  final double _dWeight;
  final Location _lPickUp;
  final Location _lDrop;
  late String status;

  Order(this._strNumber, this._strBroker, this._dWeight, this._lPickUp,
      this._lDrop)
      : status = 'Waiting for Vehicle';

  String get number => _strNumber;

  String get broker => _strBroker;

  double get weight => _dWeight;

  Location get pickup => _lPickUp;

  Location get drop => _lDrop;
}
