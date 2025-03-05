import 'package:flutter/material.dart';

class FriendListTile extends StatefulWidget {
  Map friend_info;

  FriendListTile({required this.friend_info});

  @override
  State<FriendListTile> createState() => _FriendListTileState();
}

class _FriendListTileState extends State<FriendListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(widget.friend_info["icon"], color: Colors.black , size: 43,),
      title: Text(widget.friend_info["name"], style: TextStyle(color: Colors.black , fontSize: 16)),
      trailing: Icon(Icons.close, color: Colors.redAccent),
    );
  }
}
