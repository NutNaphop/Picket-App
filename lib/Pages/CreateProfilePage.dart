import 'package:flutter/material.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({super.key});

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Text(
                  "Create Profile",
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                 SizedBox(
                  height: 30,
                ),
                Stack(
                  alignment: Alignment.center, // จัดให้ทุกอย่างอยู่ตรงกลาง
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.group,
                      size: 60,
                      color: Color(0xFF271943),
                    ),
                  ],
                ),
                SizedBox(
                  width: 30,
                  height: 10,
                ),
                Form(
                  child: Column(
                    spacing: 4,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        'Username',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                            filled: true,
                            hintText: "Enter your username",
                            hintStyle: TextStyle(color: Colors.grey),
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            errorStyle: TextStyle(
                                color: Colors.yellow,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                        validator: (value) {
                          if (value!.isEmpty)
                            return 'Please enter your username';
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 350,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                    child: Text(
                      "Confirm",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                      fixedSize: WidgetStateProperty.all(Size(280, 50)),
                      backgroundColor:
                          WidgetStateProperty.all(Color(0xFFF281C1)),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
