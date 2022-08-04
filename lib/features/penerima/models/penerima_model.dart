class PenerimaModel {
  int? status;
  String? message;
  List<Data>? data;

  PenerimaModel({this.status, this.message, this.data});

  PenerimaModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  String? name;
  String? asalKelompokTani;
  String? address;
  String? email;
  String? hp;
  String? file;
  int? status;
  String? tahunAnggaran;
  dynamic nilai;
  dynamic lat;
  dynamic latLong;
  String? dateCreated;
  List<JenisBantuan>? jenisBantuan;

  Data(
      {this.id,
      this.userId,
      this.name,
      this.asalKelompokTani,
      this.address,
      this.email,
      this.hp,
      this.file,
      this.status,
      this.tahunAnggaran,
      this.nilai,
      this.lat,
      this.latLong,
      this.dateCreated,
      this.jenisBantuan});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    name = json['name'];
    asalKelompokTani = json['asal_kelompok_tani'];
    address = json['address'];
    email = json['email'];
    hp = json['hp'];
    file = json['file'];
    status = json['status'];
    tahunAnggaran = json['tahun_anggaran'];
    nilai = json['nilai'];
    lat = json['lat'];
    latLong = json['lat_long'];
    dateCreated = json['date_created'];
    if (json['jenis_bantuan'] != null) {
      jenisBantuan = <JenisBantuan>[];
      json['jenis_bantuan'].forEach((v) {
        jenisBantuan!.add(new JenisBantuan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['userId'] = userId;
    data['name'] = name;
    data['asal_kelompok_tani'] = this.asalKelompokTani;
    data['address'] = this.address;
    data['email'] = this.email;
    data['hp'] = hp;
    data['file'] = file;
    data['status'] = status;
    data['tahun_anggaran'] = tahunAnggaran;
    data['nilai'] = nilai;
    data['lat'] = lat;
    data['lat_long'] = latLong;
    data['date_created'] = dateCreated;
    if (jenisBantuan != null) {
      data['jenis_bantuan'] = jenisBantuan!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JenisBantuan {
  String? jenisBantuan;
  String? satuan;
  int? unit;

  JenisBantuan({this.jenisBantuan, this.satuan, this.unit});

  JenisBantuan.fromJson(Map<String, dynamic> json) {
    jenisBantuan = json['jenis_bantuan'];
    satuan = json['satuan'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jenis_bantuan'] = jenisBantuan;
    data['satuan'] = satuan;
    data['unit'] = unit;
    return data;
  }
}
