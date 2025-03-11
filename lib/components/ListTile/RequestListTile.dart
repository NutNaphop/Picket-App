import 'package:flutter/material.dart';
import 'package:locket_mockup/components/BottomSheet/DeleteFriendSheet.dart';
import 'package:locket_mockup/helper/Dateformat.dart';

class RequestListTile extends StatefulWidget {
  final Function(String, String, bool, String) handleAcceptEvent;
  Map req_info;

  RequestListTile({required this.req_info, required this.handleAcceptEvent});

  @override
  State<RequestListTile> createState() => _RequestListTileState();
}

class _RequestListTileState extends State<RequestListTile> {
  
  @override
  Widget build(BuildContext context) {
    void deleteRequest() {
      widget.handleAcceptEvent(widget.req_info["from"], widget.req_info["rid"],
          false, widget.req_info["from_username"]);
    }
    print(widget.req_info) ; 
    return ListTile(
      key: ValueKey(widget.req_info["rid"]),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.req_info["profile"]),
        radius: 20,
      ) ,
      title: Text(
        widget.req_info["from_username"],
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
      subtitle: Text(
        "${formatTimestamp(widget.req_info["date"])}",
        style: TextStyle(fontSize: 12),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min, // ป้องกันการขยายเต็มพื้นที่
        children: [
          IconButton(
            icon: Icon(Icons.check, color: Colors.white, size: 24),
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.green)),
            onPressed: () {
              widget.handleAcceptEvent(
                  widget.req_info["from"],
                  widget.req_info["rid"],
                  true,
                  widget.req_info["from_username"]);
            },
          ),
          SizedBox(width: 8), // เว้นระยะห่างระหว่างปุ่ม
          IconButton(
            icon: Icon(Icons.close, color: Colors.white, size: 24),
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.red)),
            onPressed: () {
              var title = "Are you sure you want to delete this request?";
              var snackMsg = "";
              DeleteFriendSheet(
                title: title,
                prop_function: deleteRequest,
                snackMessage: snackMsg,
              ).showDeleteConfirmationBottomSheet(context);
            },
          ),
        ],
      ),
    );
  }
}
