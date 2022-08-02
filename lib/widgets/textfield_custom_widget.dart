import 'package:flutter/material.dart';
import 'package:tembakul_mobile/utils/config.dart';

class TextFieldCustomWidget extends StatelessWidget {
  final String textHint;
  final bool isNumber;
  final IconData icon;
  final TextEditingController? ctrl;
  const TextFieldCustomWidget({
    Key? key,
    required this.ctrl,
    required this.textHint,
    required this.icon,
    this.isNumber = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.left,
      controller: ctrl,
      keyboardType:
          isNumber == true ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        hintText: textHint,
        hintStyle: TextStyle(fontSize: Config().fontSizeH2),
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        contentPadding: const EdgeInsets.all(16),
        fillColor: Config().colorItem,
      ),
    );
  }
}
