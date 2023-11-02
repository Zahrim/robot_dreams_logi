class LocationData {
  late final String _strZip;
  late final String _strState;
  late final String _strCity;
  late final String _strAddress;
  late final double _dLat;
  late final double _dLng;

  String get zip => _strZip;

  String get state => _strState;

  String get city => _strCity;

  String get address => _strAddress;

  double get lat => _dLat;

  double get lng => _dLng;

  LocationData.fromAPI(Map<String, dynamic> item) {
    _strZip = item['zip'];
    _strState = item['state'];
    _strCity = item['city'];
    _strAddress = item['address'];
    _dLat = double.parse(item['lat']);
    _dLng = double.parse(item['lng']);
  }
}
