import 'package:flutter/material.dart';

class SearchUsernameForm extends StatefulWidget {
  final Function(String) onSearch; // ✨ Callback function

  const SearchUsernameForm({super.key, required this.onSearch});

  @override
  State<SearchUsernameForm> createState() => _SearchUsernameFormState();
}

class _SearchUsernameFormState extends State<SearchUsernameForm> {
  final queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: queryController,
      autofocus: false,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.search, color: Color(0xFF736D6D)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        hintText: "Search by username",
        hintStyle: TextStyle(color: Color(0xFF736D6D)),
      ),
      onChanged: widget.onSearch, // ✨ เรียก callback เมื่อมีการพิมพ์
    );
  }
}
