import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locket_mockup/components/Snackbars/Snackbar.dart';

class ResetForm extends StatefulWidget {
  const ResetForm({super.key});

  @override
  State<ResetForm> createState() => _ResetFormState();
}

class _ResetFormState extends State<ResetForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

 
  Future<void> resetPassword() async {
    String email = _emailController.text.trim();
    if (email.isEmpty) {
      showErrorSnackbar(context , "Please enter an email.");
      return;
    }

    try {
      await _auth.sendPasswordResetEmail(email: email);
      showSucessSnackbar(context , "Reset link sent! Check your email.");
    } catch (e) {
      showErrorSnackbar(context , "Error: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextFormField(
                controller: _emailController,
                autofocus: false,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  errorStyle: TextStyle(
                    color: Colors.yellow,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter your email';
                  return null;
                },
              ),
            ],
          ),
          SizedBox(height: 300),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  resetPassword();
                }
              },
              child: Text(
                "Send Reset Link",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(280, 50),
                backgroundColor: Color(0xFFF281C1),
                foregroundColor: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
