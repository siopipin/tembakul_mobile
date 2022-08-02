import 'package:flutter/material.dart';
import 'package:tembakul_mobile/utils/config.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback? function;
  const ButtonWidget({Key? key, required this.text, this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: function!,
        style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Config().padding))),
        child: Text(text),
      ),
    );
  }
}
