import 'package:flutter/material.dart';

class FunctionButtonIcon extends StatefulWidget {
  const FunctionButtonIcon(
      {super.key,
      required this.text,
      required this.icon,
      required this.isRow,
      this.onPressed,
      this.isFavorite = false,
      this.color});
  final String text;
  final IconData icon;
  final bool isRow;
  final Function()? onPressed;
  final bool isFavorite;
  final Color? color;

  @override
  State<FunctionButtonIcon> createState() => _FunctionButtonIconState();
}

class _FunctionButtonIconState extends State<FunctionButtonIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: widget.isRow
          ? Container(
              margin: const EdgeInsets.only(right: 2),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: widget.color != null
                  ? widget.color
                  : const Color.fromARGB(255, 9, 173, 170),
              child: Row(children: [
                Icon(
                  widget.icon,
                  size: 20,
                ),
                const SizedBox(width: 5),
                Text(widget.text)
              ]),
            )
          : Container(
              height: 90,
              width: 130,
              color: widget.color,
              margin: EdgeInsets.only(left: 10),
              child: Container(
                margin: const EdgeInsets.only(top: 25),
                child: Column(
                  children: [
                    Icon(
                      widget.icon,
                      color: Colors.white,
                    ),
                    Text(
                      widget.text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
