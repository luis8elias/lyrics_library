import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/utils/utils.dart';

class BasicInput extends StatefulWidget {
  const BasicInput({
    super.key,
    required this.label,
    this.initalValue,
    this.controller,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.suffixIcon,
    this.obscureText,
    this.focusNode,
    this.inputFormatters,
    this.textAlign = TextAlign.start,
    this.onTap,
    this.textCapitalization,
    this.hideErrorMessagees = false,
    this.fontSize = 16.0,
    this.contentPadding,
    this.isEnable = true
  });  
  final String? initalValue;
  final String label;
  final TextEditingController? controller;
  final void Function(String value)? onChanged;
  final String? Function(String? value)? validator;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final bool? obscureText;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign textAlign;
  final VoidCallback? onTap;
  final TextCapitalization? textCapitalization;
  final bool hideErrorMessagees;
  final double fontSize;
  final EdgeInsetsGeometry? contentPadding;
  final bool isEnable;

  @override
  State<BasicInput> createState() => _BasicInputState();
}

class _BasicInputState extends State<BasicInput> {


  final FocusNode _focusNode = FocusNode();
  late Color color;
  late FocusNode focusNode;

  @override
  void didChangeDependencies() {
    focusNode  = widget.focusNode ?? _focusNode ; 
    color = Theme.of(context).colorScheme.outline;
    
    focusNode.addListener(() {
      setState(() {
       color = _focusNode.hasFocus ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.outline; 
      });
    });
    super.didChangeDependencies();
  }

 


  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return TextFormField(
      initialValue: widget.initalValue,
      focusNode: focusNode,
      controller: widget.controller,
      textAlign: widget.textAlign,
      onTap: widget.onTap,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText ?? false,
      cursorColor: theme.colorScheme.secondary,
      inputFormatters: widget.inputFormatters,
      textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
      enabled: widget.isEnable,
      style: TextStyle(
        fontSize: widget.fontSize,
        color: theme.colorScheme.onSurface
      ),
      decoration: InputDecoration(
        contentPadding: widget.contentPadding,
        errorStyle: widget.hideErrorMessagees ? const TextStyle(height: 0) : null,
        hintText: widget.label,
        labelText: widget.label,
        labelStyle: theme.textTheme.bodyLarge!.copyWith(
          color: color,
        ),
        suffixIcon: widget.suffixIcon,
        hintStyle: theme.textTheme.bodyLarge!.copyWith(
          color: theme.colorScheme.outline,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.kBorderRadius),
          borderSide: BorderSide(color:  theme.colorScheme.outline ),
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: widget.onChanged,
      validator: widget.validator,
    );
  }
}