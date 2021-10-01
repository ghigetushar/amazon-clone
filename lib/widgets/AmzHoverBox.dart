import 'package:flutter/material.dart';

class AmzHoverBox extends StatefulWidget {
  final Function()? onTap;
  final Widget? child;
  const AmzHoverBox({Key? key, this.onTap, this.child}) : super(key: key);

  @override
  _AmzHoverBoxState createState() => _AmzHoverBoxState();
}

class _AmzHoverBoxState extends State<AmzHoverBox> {
  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: (value) {
        setState(() {
          isHovering = value;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: isHovering ? Border.all(color: Colors.white, width: 0) : null,
          borderRadius: BorderRadius.circular(2),
        ),
        child: widget.child,
      ),
    );
  }
}
