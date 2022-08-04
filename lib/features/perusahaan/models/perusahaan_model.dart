class PerusahaanModel {
  int? status;
  String? message;
  List<Data>? data;

  PerusahaanModel({this.status, this.message, this.data});

  PerusahaanModel.fromJson(Map<String, dynamic> json) {
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
  int? idBantuan;
  String? description;
  String? address;
  String? dateCreated;
  String? title;
  String? jenisBantuan;

  Data(
      {this.id,
      this.idBantuan,
      this.description,
      this.address,
      this.dateCreated,
      this.title,
      this.jenisBantuan});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idBantuan = json['id_bantuan'];
    description = json['description'];
    address = json['address'];
    dateCreated = json['date_created'];
    title = json['title'];
    jenisBantuan = json['jenis_bantuan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_bantuan'] = idBantuan;
    data['description'] = description;
    data['address'] = address;
    data['date_created'] = dateCreated;
    data['title'] = title;
    data['jenis_bantuan'] = jenisBantuan;
    return data;
  }
}
