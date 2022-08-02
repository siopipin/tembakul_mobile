import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tembakul_mobile/features/auth/login_screen.dart';
import 'package:tembakul_mobile/features/auth/providers/register_provider.dart';
import 'package:tembakul_mobile/features/auth/widgets/header_banner_widget.dart';
import 'package:tembakul_mobile/features/auth/widgets/textfield_widget.dart';
import 'package:tembakul_mobile/utils/config.dart';
import 'package:tembakul_mobile/widgets/button_widget.dart';
import 'package:tembakul_mobile/widgets/title_section_widget.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final watchRegister = context.watch<RegisterProvider>();
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(
            top: 0, left: Config().padding * 2, right: Config().padding * 2),
        children: [
          SizedBox(height: Config().padding * 5),
          //header banner
          HeaderBannerWidget(),

          //form
          SizedBox(height: Config().padding * 2),
          TitleSectionWidget(title: "Registrasi", icon: Icons.app_registration),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(right: Config().padding / 2),
                  child: Icon(Icons.person_pin_rounded)),
              Expanded(
                  child: TextFieldWidget(
                ctrl: watchRegister.ctrlNama,
                textHint: "Isi Nama Sesuai KTP",
                textLabel: "Nama",
                isNumber: true,
              ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(right: Config().padding / 2),
                  child: Icon(Icons.phone_android_outlined)),
              Expanded(
                  child: TextFieldWidget(
                ctrl: watchRegister.ctrlHP,
                textHint: "Isi Nomor HP",
                textLabel: "Nomor HP",
                isNumber: true,
              ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(right: Config().padding / 2),
                  child: Icon(Icons.key)),
              Expanded(
                  child: TextFieldWidget(
                ctrl: watchRegister.ctrlPassword,
                textHint: "Isi Password",
                textLabel: "Password",
                obsecure: true,
              ))
            ],
          ),

          //action
          SizedBox(height: Config().padding),
          ButtonWidget(text: "Registrasi", function: () {}),
          SizedBox(height: Config().padding),
          Align(
            alignment: Alignment.center,
            child: Text.rich(TextSpan(children: [
              TextSpan(text: "Sudah memiliki akun?"),
              TextSpan(
                  text: " Masuk ke Aplikasi Tembakul!",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        (route) => false),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Config().fontBlue))
            ])),
          )
        ],
      ),
    );
  }
}
