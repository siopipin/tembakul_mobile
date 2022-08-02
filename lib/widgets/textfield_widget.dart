import 'package:flutter/material.dart';
import 'package:tembakul_mobile/utils/config.dart';

class TextFieldWidget extends StatelessWidget {
  final String textHint;
  final String textLabel;
  final bool obsecure;
  final bool isNumber;
  final TextEditingController? ctrl;
  const TextFieldWidget({
    Key? key,
    this.ctrl,
    required this.textHint,
    required this.textLabel,
    this.obsecure = false,
    this.isNumber = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: ctrl,
      obscureText: obsecure,
      keyboardType:
          isNumber == true ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        hintText: textHint,
        hintStyle: TextStyle(fontSize: Config().fontSizeH3),
        labelText: textLabel,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
