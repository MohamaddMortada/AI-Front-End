import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String text;
  final Image image;
  final double height;
  final int maxLines;
  final TextEditingController controller;

  const Input({
    super.key,
    required this.text,
    required this.image,
    required this.height,
    required this.maxLines,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      height: height,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor,
            spreadRadius: 0,
            blurRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).secondaryHeaderColor,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: image,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: controller,
              maxLines: maxLines,
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Theme.of(context).secondaryHeaderColor,
                labelText: text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
