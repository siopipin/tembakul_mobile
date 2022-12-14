import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tembakul_mobile/features/auth/login_screen.dart';
import 'package:tembakul_mobile/features/auth/providers/register_provider.dart';
import 'package:tembakul_mobile/features/auth/widgets/home_header_widget.dart';
import 'package:tembakul_mobile/widgets/textfield_widget.dart';
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
          const LoginHeaderWidget(),

          //form
          SizedBox(height: Config().padding * 2),
          const TitleSectionWidget(
              title: "Registrasi", icon: Icons.app_registration),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(right: Config().padding / 2),
                  child: const Icon(Icons.person_pin_rounded)),
              Expanded(
                  child: TextFieldWidget(
                ctrl: watchRegister.ctrlNama,
                textHint: "Isi Nama Sesuai KTP",
                textLabel: "Nama",
              ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(right: Config().padding / 2),
                  child: const Icon(Icons.phone_android_outlined)),
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
                  child: const Icon(Icons.key)),
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
          ButtonWidget(
              text: "Registrasi",
              function: () async {
                if (watchRegister.ctrlHP.text.isEmpty ||
                    watchRegister.ctrlNama.text.isEmpty ||
                    watchRegister.ctrlPassword.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: 'HP, Nama dan Password tidak boleh kosong!');
                } else {
                  await watchRegister.postRegister(
                      hp: watchRegister.ctrlHP.text,
                      nama: watchRegister.ctrlNama.text,
                      password: watchRegister.ctrlPassword.text);
                  //Jika login berhasil
                  if (watchRegister.stateRegister == StateRegister.loaded) {
                    // ignore: use_build_context_synchronously
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        (route) => false);
                  }
                }
              }),
          SizedBox(height: Config().padding),
          Align(
            alignment: Alignment.center,
            child: Text.rich(TextSpan(children: [
              const TextSpan(text: "Sudah memiliki akun?"),
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
