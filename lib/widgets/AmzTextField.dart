import 'package:flutter/material.dart';

class AmzTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String label;
  final bool? autoFocus;
  AmzTextField(
      {Key? key,
      required this.textEditingController,
      required this.label,
      this.autoFocus})
      : super(key: key);

  final outlineBorder = OutlineInputBorder(
    borderSide: BorderSide(
      width: 0.4,
      color: Colors.black,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          this.label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        SizedBox(height: 5),
        TextField(
          controller: this.textEditingController,
          cursorColor: Colors.black,
          cursorWidth: 0.5,
          autofocus: this.autoFocus ?? false,
          decoration: InputDecoration(
            isDense: true,
            enabledBorder: outlineBorder,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Colors.orange,
              ),
            ),
            errorBorder: outlineBorder,
            contentPadding: EdgeInsets.all(10),
          ),
        ),
      ],
    );
  }
}
