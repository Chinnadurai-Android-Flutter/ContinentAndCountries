class Translations {
  String de;
  String es;
  String fr;
  String ja;
  String it;
  String br;
  String pt;
  String nl;
  String hr;
  String fa;

  Translations(
      {this.de,
        this.es,
        this.fr,
        this.ja,
        this.it,
        this.br,
        this.pt,
        this.nl,
        this.hr,
        this.fa});

  Translations.fromJson(Map<String, dynamic> json) {
    de = json['de'];
    es = json['es'];
    fr = json['fr'];
    ja = json['ja'];
    it = json['it'];
    br = json['br'];
    pt = json['pt'];
    nl = json['nl'];
    hr = json['hr'];
    fa = json['fa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['de'] = this.de;
    data['es'] = this.es;
    data['fr'] = this.fr;
    data['ja'] = this.ja;
    data['it'] = this.it;
    data['br'] = this.br;
    data['pt'] = this.pt;
    data['nl'] = this.nl;
    data['hr'] = this.hr;
    data['fa'] = this.fa;
    return data;
  }
}