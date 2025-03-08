import 'package:flutter/material.dart';

class FriendListTile extends StatefulWidget {
  Map friend_info;
  final Function(String) deleteFriend;

  FriendListTile({required this.friend_info, required this.deleteFriend});

  @override
  State<FriendListTile> createState() => _FriendListTileState();
}

class _FriendListTileState extends State<FriendListTile> {
  void _showDeleteConfirmationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                  "Are you sure to delete ${widget.friend_info["name"]} out of your friend list ?",
                  style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 30,
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
                      Navigator.of(context).pop(); // Handle Delete
                      widget.deleteFriend(widget.friend_info["uid"]);
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
    return ListTile(
      leading: Icon(
        widget.friend_info["icon"],
        color: Colors.black,
        size: 43,
      ),
      title: Text(widget.friend_info["name"],
          style: TextStyle(color: Colors.black, fontSize: 16)),
      subtitle: Text(
        widget.friend_info["uid"],
        style: TextStyle(fontSize: 12),
      ),
      trailing: IconButton(
          onPressed: () {
            _showDeleteConfirmationBottomSheet(context);
          },
          icon: Icon(Icons.close, color: Colors.redAccent)),
    );
  }
}
