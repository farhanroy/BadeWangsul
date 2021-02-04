import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseTextInput extends StatelessWidget {
  final String hintText;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final bool obscure;

  const BaseTextInput({Key key,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.obscure = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3.0,
      borderRadius: BorderRadius.circular(5.0),
      shadowColor: Colors.blue.withOpacity(0.7),
      child: TextField(
        obscureText: obscure,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          hintText: hintText,
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        ),
      ),
    );
  }
}

class TextInputWithTitle extends StatelessWidget {
  final String title;
  final String errorText;
  final Function(String) onChanged;
  final TextEditingController controller;
  final TextInputType inputType;

  TextInputWithTitle({Key key,
    @required this.title,
    @required this.onChanged,
    this.controller,
    this.inputType = TextInputType.text, this.errorText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: Get.textTheme.headline6,),
        TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
              hintText: title,
              errorText: errorText),
          keyboardType: inputType,
        )
      ],
    );
  }
}

class BaseDropdown extends StatefulWidget {
  final Widget hint;
  final List<String> list;
  final String value;
  final Function(String) onChanged;
  final String title;

  const BaseDropdown({
    Key key,
    this.hint,
    this.list,
    this.onChanged,
    this.value,
    this.title,
  }) : super(key: key);

  @override
  _BaseDropdownState createState() => _BaseDropdownState();
}

class _BaseDropdownState extends State<BaseDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(widget.title, style: Get.textTheme.headline6,),
        DropdownButton(
          items: widget.list.map((val) {
            return DropdownMenuItem(
              child: Text(val),
              value: val,
            );
          }).toList(),
          isExpanded: true,
          onChanged: (String val) {
            widget.onChanged(val);
            setState(() => val = val);
          },
          hint: widget.hint,
          value: widget.value,
        ),
      ],
    );
  }
}
