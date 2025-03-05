import 'package:flutter/material.dart';

class ResultListTile extends StatefulWidget {

  Map result_info ; 

  ResultListTile({
    required this.result_info
  });
  
  @override
  State<ResultListTile> createState() => _ResultListTileState();
}

class _ResultListTileState extends State<ResultListTile> {

  void addFriend(){
    print("Add Friend Click") ; 
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 352,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 10), // ลดระยะห่างขอบ
        leading: Icon(Icons.account_circle_outlined, size: 40),
        title: Text(
          widget.result_info["name"],
          overflow: TextOverflow.ellipsis, // ป้องกันข้อความล้น
        ),
        subtitle: Text(widget.result_info["id"] , style: TextStyle(
          fontSize: 12
        ),),
        trailing: SizedBox(
          width: 133, // กำหนดความกว้างปุ่มให้แน่นอน
          child: ElevatedButton(
            onPressed: () {
              addFriend() ; 
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF65C4B4),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Add friend", style: TextStyle(fontSize: 16)),
                Icon(Icons.add_circle_outline, size: 22, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
