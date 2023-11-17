import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/presentation/widgets/widgets.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({
    super.key,
    required this.label,
    this.controller,
    this.onChanged,
    this.validator
  });

  final String label;
  final TextEditingController? controller;
  final void Function(String value)? onChanged;
  final String? Function(String? value)? validator;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return BasicInput(
      label: widget.label,
      obscureText: obscureText,
      controller: widget.controller,
      onChanged: widget.onChanged,
      validator: widget.validator,
      suffixIcon: IconButton(
        splashRadius: 15,
        onPressed: (){
          setState(() {
            obscureText = !obscureText;
          });
        },
        icon: Icon(
          obscureText
          ? CupertinoIcons.eye
          : CupertinoIcons.eye_slash
        )
      ),
    );
  }
}
