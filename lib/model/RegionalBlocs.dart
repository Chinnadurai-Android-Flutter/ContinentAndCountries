class RegionalBlocs {
  String acronym;
  String name;
  List<String> otherAcronyms;
  List<String> otherNames;

  RegionalBlocs({this.acronym, this.name, this.otherAcronyms, this.otherNames});

  RegionalBlocs.fromJson(Map<String, dynamic> json) {
    acronym = json['acronym'];
    name = json['name'];
    otherAcronyms = json['otherAcronyms'].cast<String>();
    otherNames = json['otherNames'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['acronym'] = this.acronym;
    data['name'] = this.name;
    data['otherAcronyms'] = this.otherAcronyms;
    data['otherNames'] = this.otherNames;
    return data;
  }
}
