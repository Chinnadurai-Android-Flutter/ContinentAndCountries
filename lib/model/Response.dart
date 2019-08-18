import 'ModelResponse.dart';

class Response {
  List<ModelResponse> response;

  Response({this.response});

  Response.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      response = new List<ModelResponse>();
      json['response'].forEach((v) {
        response.add(new ModelResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
