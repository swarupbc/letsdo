import 'package:flutter/material.dart';

class InputFromField extends StatelessWidget {
  final String hintText;
  final IconData fIcon;
  final bool isPass;
  final TextEditingController tController;
  const InputFromField({
    Key key,
    this.hintText,
    this.fIcon,
    this.isPass = false,
    this.tController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      child: TextFormField(
        controller: tController,
        obscureText: isPass,
        decoration: InputDecoration(
          hintText: hintText,
          icon: Icon(fIcon),
        ),
      ),
    );
  }
}
