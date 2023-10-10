class Driver {

  final String _strKey;
  final String _strName;
  final String _strEmail;
  final String _strPassword;

  Driver (this._strKey, this._strName, this._strEmail, this._strPassword);

  String get key => _strKey;
  String get name => _strName;
  String get email => _strEmail;
  String get pass => _strPassword;

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      json['key'],
      json['name'],
      json['email'],
      json['pass']
    );
  }

}
