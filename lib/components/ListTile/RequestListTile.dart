import 'package:flutter/material.dart';

class RequestListTile extends StatefulWidget {
  const RequestListTile({super.key});

  @override
  State<RequestListTile> createState() => _RequestListTileState();
}

class _RequestListTileState extends State<RequestListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.account_circle,
        color: Colors.black,
        size: 43,
      ),
      title: Text(
        "Naphop",
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min, // ป้องกันการขยายเต็มพื้นที่
        children: [
          IconButton(
            icon: Icon(Icons.check, color: Colors.white, size: 24),
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.green)),
            onPressed: () {
              print("Click Accept") ; 
            },
          ),
          SizedBox(width: 8), // เว้นระยะห่างระหว่างปุ่ม
          IconButton(
            icon: Icon(Icons.close, color: Colors.white, size: 24),
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.red)),
            onPressed: () {
              print("Click Close") ; 
            },
          ),
        ],
      ),
    );
  }
}
