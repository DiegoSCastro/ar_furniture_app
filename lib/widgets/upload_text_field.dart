import 'package:flutter/material.dart';

class UploadTextField extends StatelessWidget {
  final IconData icon;
  final TextEditingController? controller;
  final String? hintText;
  const UploadTextField({
    Key? key,
    required this.icon,
    this.controller,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: SizedBox(
        width: 250,
        child: TextField(
          style: const TextStyle(color: Colors.grey),
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
