import 'package:flutter/material.dart';
import 'package:tembakul_mobile/features/auth/login_screen.dart';
import 'package:tembakul_mobile/features/auth/register_screen.dart';

void showCustomDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 700),
    pageBuilder: (_, __, ___) {
      return AlertDialog(
        title: Text("Silahkan Login"),
        content: Text(
            "Fitur ini bisa diakses jika anda telah memiliki akun, silahkan login atau registrasi terlebih dahulu!"),
        actions: [
          TextButton(
            child: Text("Registrasi"),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterScreen()),
                  (route) => false);
            },
          ),
          TextButton(
            child: Text("Login"),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false);
            },
          )
        ],
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
      } else {
        tween = Tween(begin: Offset(1, 0), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}
