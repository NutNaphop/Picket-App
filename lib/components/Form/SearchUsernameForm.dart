import 'package:flutter/material.dart';

class SearchUsernameForm extends StatefulWidget {
  const SearchUsernameForm({super.key});

  @override
  State<SearchUsernameForm> createState() => _SearchUsernameFormState();
}

class _SearchUsernameFormState extends State<SearchUsernameForm> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final queryController = TextEditingController();

    return Form(
        child: Column(
      children: [
        TextFormField(
          controller: queryController,
          autofocus: true,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.search , color: Color(0xFF736D6D),),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: "Search by username",
              hintStyle: TextStyle(color: Color(0xFF736D6D)),
              errorStyle: TextStyle(
                  color: Colors.yellow,
                  fontSize: 14,
                  fontWeight: FontWeight.bold)),
          validator: (value) {
            if (value!.isEmpty) return 'Please enter your email';
          },
        )
      ],
    ));
  }
}
