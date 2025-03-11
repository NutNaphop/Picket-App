import 'package:flutter/material.dart';
import 'package:locket_mockup/Pages/MainSection/WelcomePage.dart';

class DeleteFriendSheet extends StatelessWidget {
  String title;
  String snackMessage;
  Function prop_function;

  DeleteFriendSheet(
      {required this.title,
      required this.prop_function,
      required this.snackMessage});

  void showDeleteConfirmationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            height: 300,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                Icon(
                  Icons.delete,
                  size: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Icon(Icons.error_outline,
                        color: Colors.grey[600], size: 30),
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
                          backgroundColor:
                              const Color.fromARGB(255, 233, 88, 88),
                          foregroundColor: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop(); // Handle Delete

                        prop_function();

                        if (snackMessage != "") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                duration: Duration(seconds: 2),
                                content: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        snackMessage,
                                        style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 28, 181, 89),
                                          fontSize: 18,
                                        ),
                                      ),
                                      Icon(
                                        Icons.check_circle_outline,
                                        color: const Color.fromARGB(
                                            255, 28, 181, 89),
                                      ),
                                    ],
                                  ),
                                ),
                                backgroundColor:
                                    const Color.fromARGB(255, 248, 249, 250),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          );
                        }
                      },
                      child: Text("Delete"),
                    ),
                  ],
                ),
              ],
            ),
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
