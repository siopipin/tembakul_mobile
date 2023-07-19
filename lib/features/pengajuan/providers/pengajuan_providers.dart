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
    ctrlJumlahAnggota.clear();
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
  TextEditingController ctrlJumlahAnggota = TextEditingController();
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

  //file proposal multi select

  String _fileName2 = '';
  String get fileName2 => _fileName2;
  set setFileName2(val) {
    _fileName2 = val;
    notifyListeners();
  }

  //SelectFile
  FilePickerResult? _file2;
  FilePickerResult get fileResult2 => _file2!;
  set setFile2(val) {
    _file2 = val;
    if (val != null) {
      PlatformFile file = fileResult2.files.first;
      setFileName2 = file.name;
    }
    notifyListeners();
  }

  Future<dynamic> postPengajuan(
      {required String nama,
      required String asal,
      required String alamat,
      required String jumlahAnggota,
      required String email,
      required String hp}) async {
    try {
      final uri = Uri.parse("${Config().urlApi}tembakul/pengajuan/$idUser");
      var request = http.MultipartRequest('POST', uri);
      request.fields['name'] = nama;
      request.fields['asal_kelompok_tani'] = asal;
      request.fields['jumlah_anggota'] = jumlahAnggota;
      request.fields['address'] = alamat;
      request.fields['email'] = email;
      request.fields['hp'] = hp;

      final mimeTypeData = lookupMimeType(fileResult.files.first.path!,
          headerBytes: [0xFF, 0xD8])?.split('/');

      request.files.add(await http.MultipartFile.fromPath(
          'file', fileResult.files.first.path!,
          contentType: MediaType(mimeTypeData![0], mimeTypeData[1])));

      if (fileResult2.count != 0) {
        print('ada banyak file ======= ');
        await Future.forEach(
            fileResult2.files,
            (file) async => {
                  request.files.add(await http.MultipartFile.fromPath(
                      'file', file.path!,
                      contentType:
                          MediaType(mimeTypeData![0], mimeTypeData[1]))),
                });

        // await fileResult2.files.forEach((element) async {
        //   request.files.add(await http.MultipartFile.fromPath(
        //       'file', element.path!,
        //       contentType: MediaType(mimeTypeData![0], mimeTypeData[1])));
        // });
      }
      // request.files.add(httpImage);
      print(request.fields);
      print(request.files);
      final response = await request.send();
      print(response.stream.toString());
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Berkas Berhasil disimpan');
        ctrlAddress.clear();
        ctrlAsalPokTan.clear();
        ctrlJumlahAnggota.clear();
        ctrlEmail.clear();
        ctrlHP.clear();
        ctrlNama.clear();
        fileResult.files.clear();
        fileResult2.files.clear();
        setFile = null;
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: 'Gagal memuat berkas, silahkan pilih lagi!');
    }
  }
}
