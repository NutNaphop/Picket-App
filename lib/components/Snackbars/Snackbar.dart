import 'package:flutter/material.dart';

void showErrorSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: 2),
      content: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              message,
              style: TextStyle(
                color: const Color.fromARGB(255, 255, 3, 3),
                fontSize: 18,
              ),
            ),
            Icon(
              Icons.cancel,
              color: const Color.fromARGB(255, 255, 3, 3),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 248, 249, 250),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );
}

 void showSucessSnackbar(BuildContext context , String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          duration: Duration(seconds: 2),
          content: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  message,
                  style: TextStyle(
                    color: const Color.fromARGB(255, 28, 181, 89),
                    fontSize: 18,
                  ),
                ),
                Icon(
                  Icons.check_circle_outline,
                  color: const Color.fromARGB(255, 28, 181, 89),
                ),
              ],
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 248, 249, 250),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    );
  }