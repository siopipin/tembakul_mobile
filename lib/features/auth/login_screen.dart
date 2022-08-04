import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tembakul_mobile/features/auth/providers/login_provider.dart';
import 'package:tembakul_mobile/features/auth/register_screen.dart';
import 'package:tembakul_mobile/features/auth/widgets/home_header_widget.dart';
import 'package:tembakul_mobile/widgets/textfield_widget.dart';
import 'package:tembakul_mobile/features/home/home_screen.dart';
import 'package:tembakul_mobile/utils/config.dart';
import 'package:tembakul_mobile/widgets/button_widget.dart';
import 'package:tembakul_mobile/widgets/title_section_widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<LoginProvider>().initial());
  }

  @override
  Widget build(BuildContext context) {
    final watchLogin = context.watch<LoginProvider>();
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(
            top: 0, left: Config().padding * 2, right: Config().padding * 2),
        children: [
          SizedBox(height: Config().padding * 5),
          //header banner
          LoginHeaderWidget(),

          //form
          SizedBox(height: Config().padding * 2),
          TitleSectionWidget(title: "Login", icon: Icons.login),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(right: Config().padding / 2),
                  child: Icon(Icons.phone_android_outlined)),
              Expanded(
                  child: TextFieldWidget(
                ctrl: watchLogin.ctrlHP,
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
                ctrl: watchLogin.ctrlPassword,
                textHint: "Isi Password",
                textLabel: "Password",
                obsecure: true,
              ))
            ],
          ),

          //action
          SizedBox(height: Config().padding),
          ButtonWidget(
              text: watchLogin.loginState == LoginState.Loading
                  ? "Loading..."
                  : "Masuk",
              function: watchLogin.loginState == LoginState.Loading
                  ? () {}
                  : () async {
                      if (watchLogin.ctrlHP.text.isEmpty ||
                          watchLogin.ctrlPassword.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: 'HP dan Password tidak boleh kosong!');
                      } else {
                        await watchLogin.postLogin(
                            hp: watchLogin.ctrlHP.text,
                            password: watchLogin.ctrlPassword.text);
                        //Jika login berhasil
                        if (watchLogin.loginState == LoginState.Loaded) {
                          // ignore: use_build_context_synchronously
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()),
                              (route) => false);
                        }
                      }
                    }),
          SizedBox(height: Config().padding),
          Align(
            alignment: Alignment.center,
            child: Text.rich(TextSpan(children: [
              TextSpan(text: "Belum memiliki akun?"),
              TextSpan(
                  text: " Daftar Sekarang!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Config().fontBlue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const RegisterScreen()))))
            ])),
          )
        ],
      ),
    );
  }
}
