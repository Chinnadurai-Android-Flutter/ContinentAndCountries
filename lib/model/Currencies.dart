
class Currencies {
  String code;
  String name;
  String symbol;

  Currencies({this.code, this.name, this.symbol});

  Currencies.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    symbol = json['symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    return data;
  }
}