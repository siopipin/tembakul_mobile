import 'package:shared_preferences/shared_preferences.dart';

class SharedData {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  saveLogin(
      {required String id, required String nama, required String token}) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('id', id);
    await prefs.setString('nama', nama);
    await prefs.setString('token', token);
  }

  Future<String> showId() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('id') ?? "";
  }

  Future<String> showNama() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('nama') ?? "-";
  }

  Future<dynamic> showToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('token');
  }
}
