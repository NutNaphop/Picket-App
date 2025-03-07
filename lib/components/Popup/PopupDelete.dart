import 'package:flutter/material.dart';

bool _showDeleteConfirmationBottomSheet(BuildContext context) {
  
  bool _isConfirm = false ; 

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Are you sure you want to delete this item?", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    _isConfirm = false ; 
                    Navigator.of(context).pop();  
                  },
                  child: Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _isConfirm = true ; 
                    Navigator.of(context).pop();  // Handle Delete                  
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

  return _isConfirm ; 
}
