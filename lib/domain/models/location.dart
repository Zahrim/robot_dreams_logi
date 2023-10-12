class Location {
  late final String _strZip;
  late final String _strState;
  late final String _strCity;
  late final String _strAddress;
  late final double _dLat;
  late final double _dLng;

  Location(String zip, String state, String city, String address, double lat, double lng) {
    _strZip = zip;
    _strState = state;
    _strCity = city;
    _strAddress = address;
    _dLat = lat;
    _dLng = lng;
  }

  String get zip => _strZip;

  String get state => _strState;

  String get city => _strCity;

  String get address => _strAddress;

  double get lat => _dLat;

  double get lng => _dLng;

  factory Location.fromJson(Map<String, dynamic> item) {
    return Location(item['zip'], item['state'], item['city'], item['address'], double.parse(item['lat']), double.parse(item['lng']));
  }
}
