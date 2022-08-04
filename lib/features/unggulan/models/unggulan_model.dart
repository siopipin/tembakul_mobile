class UnggulanModel {
  int? status;
  String? message;
  List<Data>? data;

  UnggulanModel({this.status, this.message, this.data});

  UnggulanModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? description;
  String? img;
  String? dateCreated;

  Data({this.id, this.title, this.description, this.img, this.dateCreated});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    img = json['img'];
    dateCreated = json['date_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['img'] = img;
    data['date_created'] = dateCreated;
    return data;
  }
}
