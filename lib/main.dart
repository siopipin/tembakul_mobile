import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tembakul_mobile/features/auth/providers/login_provider.dart';
import 'package:tembakul_mobile/features/auth/providers/register_provider.dart';
import 'package:tembakul_mobile/features/home/home_screen.dart';
import 'package:tembakul_mobile/features/home/providers/home_provider.dart';
import 'package:tembakul_mobile/features/news_slides/providers/news_provider.dart';
import 'package:tembakul_mobile/features/pengajuan/providers/pengajuan_providers.dart';
import 'package:tembakul_mobile/utils/config.dart';

void main() {
  return runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => NewsProvider()),
    ChangeNotifierProvider(create: (_) => LoginProvider()),
    ChangeNotifierProvider(create: (_) => RegisterProvider()),
    ChangeNotifierProvider(create: (_) => HomeProvider()),
    ChangeNotifierProvider(create: (_) => PengajuanProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Tembakul Apps',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Outfit',
        colorScheme:
            ColorScheme.fromSwatch().copyWith(primary: Config().colorPrimary),
        scaffoldBackgroundColor: Config().colorBg,
      ),
      home: const HomeScreen(),
    );
  }
}
