class Order {

  final String _strNumber;
  final String _strName;
  final String _strNote;

  Order (this._strNumber, this._strName, this._strNote);

  String get number => _strNumber;
  String get name => _strName;
  String get note => _strNote;

}