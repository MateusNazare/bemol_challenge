import 'package:flutter/material.dart';

import '../../../../modules/settings/colors.dart';

class InputWidget extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final String labelText;
  final bool isObscureText;
  final Function validator;
  final int maxLength;
  final bool enabled;
  final Function onChanged;

  const InputWidget({
    Key? key,
    required this.controller,
    required this.keyboardType,
    required this.hintText,
    required this.labelText,
    required this.validator,
    required this.maxLength,
    required this.onChanged,
    this.enabled = true,
    this.isObscureText = false,
  }) : super(key: key);

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) => widget.onChanged(value),
      validator: (value) => widget.validator(value),
      enabled: widget.enabled,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.isObscureText,
      cursorColor: AppColors.secondary,
      maxLength: widget.maxLength,
      style: const TextStyle(color: AppColors.clear, fontSize: 14.0),
      decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: AppColors.clear.withOpacity(0.05),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.secondary, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.secondary, width: 1.5),
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.error, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.secondary, width: 1.5),
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppColors.clear.withOpacity(0.05), width: 1.5),
              borderRadius: const BorderRadius.all(Radius.circular(15.0))),
          hintText: widget.hintText,
          hintStyle: TextStyle(
              color: AppColors.clear.withOpacity(0.5), fontSize: 14.0),
          labelText: widget.labelText,
          labelStyle: const TextStyle(color: AppColors.clear, fontSize: 14.0),
          focusColor: Colors.white),
    );
  }
}
