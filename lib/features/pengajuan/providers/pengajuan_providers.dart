import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:tembakul_mobile/utils/config.dart';
import 'package:tembakul_mobile/utils/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';

class PengajuanProvider extends ChangeNotifier {
  initial() async {
    setFileName = '';
    setFile = null;
    ctrlAddress.clear();
    ctrlAsalPokTan.clear();
    ctrlEmail.clear();
    ctrlHP.clear();
    ctrlNama.clear();
    userInfo();
  }

  SharedData data = SharedData();
  String _id = "";
  String get idUser => _id;
  set setId(val) {
    _id = val;
    print('user ID: $val');
    notifyListeners();
  }

  userInfo() async {
    await data.showId().then((value) {
      if (value == null) {
        setId = null;
      } else {
        setId = value;
      }
    });
  }

  TextEditingController ctrlNama = TextEditingController();
  TextEditingController ctrlAsalPokTan = TextEditingController();
  TextEditingController ctrlAddress = TextEditingController();
  TextEditingController ctrlEmail = TextEditingController();
  TextEditingController ctrlHP = TextEditingController();

  String _fileName = '';
  String get fileName => _fileName;
  set setFileName(val) {
    _fileName = val;
    notifyListeners();
  }

  //SelectFile
  FilePickerResult? _file;
  FilePickerResult get fileResult => _file!;
  set setFile(val) {
    _file = val;
    if (val != null) {
      PlatformFile file = fileResult.files.first;
      setFileName = file.name;
    }
    notifyListeners();
  }

  Future<dynamic> postPengajuan(
      {required String nama,
      required String asal,
      required String alamat,
      required String email,
      required String hp}) async {
    try {
      final uri = Uri.parse("${Config().urlApi}tembakul/pengajuan/$idUser");
      var request = http.MultipartRequest('POST', uri);
      request.fields['name'] = nama;
      request.fields['asal_kelompok_tani'] = asal;
      request.fields['address'] = alamat;
      request.fields['email'] = email;
      request.fields['hp'] = hp;

      // final httpImage = http.MultipartFile(
      //   'file',
      //   File(fileResult.files.first.path!).readAsBytes().asStream(),
      //   File(fileResult.files.first.path!).lengthSync(),
      //   filename: fileResult.files.first.name,
      // );
      final mimeTypeData = lookupMimeType(fileResult.files.first.path!,
          headerBytes: [0xFF, 0xD8])?.split('/');
      request.files.add(await http.MultipartFile.fromPath(
          'file', fileResult.files.first.path!,
          contentType: MediaType(mimeTypeData![0], mimeTypeData[1])));
      // request.files.add(httpImage);
      final response = await request.send();
      print(response.stream.toString());
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Berkas Berhasil disimpan');
        ctrlAddress.clear();
        ctrlAsalPokTan.clear();
        ctrlEmail.clear();
        ctrlHP.clear();
        ctrlNama.clear();
        setFile = null;
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: 'Gagal memuat berkas, silahkan pilih lagi!');
    }
  }
}
