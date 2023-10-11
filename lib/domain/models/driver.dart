class Driver {
  late final String _strKey;
  late final String _strName;
  late final String _strEmail;
  late final String _strPassword;

  Driver(String key, String name, String email, String pass) {
    _strKey = key;
    _strName = name;
    _strEmail = email;
    _strPassword = pass;
  }

  String get key => _strKey;

  String get name => _strName;

  String get email => _strEmail;

  String get pass => _strPassword;

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(json['key'], json['name'], json['email'], json['pass']);
  }
}
