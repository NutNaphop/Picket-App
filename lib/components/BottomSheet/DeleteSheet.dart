import 'package:flutter/material.dart';
import 'package:locket_mockup/Pages/MainSection/WelcomePage.dart';

class DeleteSheet extends StatelessWidget {
  String title;
  Function prop_function;

  DeleteSheet({required this.title, required this.prop_function});

  void showDeleteConfirmationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: TextStyle(fontSize: 20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  Icon(Icons.error_outline, color: Colors.grey[600], size: 30),
                  Text(
                    "This Action cannot be undone",
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: <Widget>[
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(
                              color: Color.fromARGB(255, 196, 196, 196),
                              width: 1,
                            )),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Handle Cancel
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 124, 124, 124)),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 233, 88, 88),
                        foregroundColor: Colors.white),
                    onPressed: () {
                      prop_function();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WelcomePage(),
                          ),
                          (route) => false);
                    },
                    child: Text("Delete"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
