import 'package:flutter/material.dart';
import 'package:locket_mockup/components/BottomSheet/DeleteFriendSheet.dart';
import 'package:locket_mockup/components/BottomSheet/DeleteSheet.dart';

class FriendListTile extends StatefulWidget {
  Map friend_info;
  final Function(String) deleteFriend;

  FriendListTile({required this.friend_info, required this.deleteFriend});

  @override
  State<FriendListTile> createState() => _FriendListTileState();
}

class _FriendListTileState extends State<FriendListTile> {
  @override
  Widget build(BuildContext context) {
    void _isShowBottom = false;

    void deleteFriend() {
      widget.deleteFriend(widget.friend_info["uid"]);
    }

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.friend_info["profile"]),
        radius: 20,
      ),
      title: Text(widget.friend_info["name"],
          style: TextStyle(color: Colors.black, fontSize: 16)),
      subtitle: Text(
        widget.friend_info["uid"],
        style: TextStyle(fontSize: 12),
      ),
      trailing: IconButton(
          onPressed: () {
            String title =
                "Are you sure to delete ${widget.friend_info["name"]} out of your friend list ?";
            String snackMsg =
                "Unfriend ${widget.friend_info["name"]} Successfully";
            DeleteFriendSheet(
              title: title,
              prop_function: deleteFriend,
              snackMessage: snackMsg,
            ).showDeleteConfirmationBottomSheet(context);
          },
          icon: Icon(Icons.close, color: Colors.redAccent)),
    );
  }
}
