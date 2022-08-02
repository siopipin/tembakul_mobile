import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tembakul_mobile/features/auth/login_screen.dart';
import 'package:tembakul_mobile/features/home/home_screen.dart';
import 'package:tembakul_mobile/features/home/providers/home_provider.dart';
import 'package:tembakul_mobile/utils/config.dart';
import 'package:tembakul_mobile/utils/shared_preferences.dart';

class LoginLogoutWidget extends StatelessWidget {
  const LoginLogoutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final watchHome = context.watch<HomeProvider>();
    if (watchHome.isLoggedIn) {
      return GestureDetector(
        onTap: (() async {
          SharedData().removeLoginData().then((value) {
            if (value) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false);
              Fluttertoast.showToast(msg: 'Berhasil SignOut');
            } else {
              Fluttertoast.showToast(msg: 'Gagal SignOut, coba lagi!');
            }
          });
        }),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.keyboard_tab_rounded,
              color: Config().colorItem,
              size: 20,
            ),
            Text(
              'keluar',
              style: TextStyle(
                  color: Config().fontPrimaryWhite,
                  fontSize: Config().fontSizeTiny),
            )
          ],
        ),
      );
    } else {
      return GestureDetector(
        onTap: (() => Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const LoginScreen())))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Config().colorItem,
              size: 20,
            ),
            Text(
              'Masuk',
              style: TextStyle(
                  color: Config().fontPrimaryWhite,
                  fontSize: Config().fontSizeTiny),
            )
          ],
        ),
      );
    }
  }
}
