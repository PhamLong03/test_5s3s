import 'package:flutter/material.dart';

class FunctionButton extends StatefulWidget {
  const FunctionButton(
      {super.key,
      required this.text,
      this.onPressed,
      this.isFavorite = false,
      this.color});
  final String text;
  final Function()? onPressed;
  final bool isFavorite;
  final Color? color;
  @override
  State<FunctionButton> createState() => _FunctionButtonState();
}

class _FunctionButtonState extends State<FunctionButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        margin: const EdgeInsets.only(right: 2),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: widget.color ?? const Color.fromARGB(255, 9, 173, 170),
        child: Text(widget.text),
      ),
    );
  }
}
