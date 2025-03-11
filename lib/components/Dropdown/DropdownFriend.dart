import 'package:flutter/material.dart';
import 'package:locket_mockup/providers/FriendDataProvider.dart';
import 'package:locket_mockup/providers/FriendImageProvider.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart'; // ✅ ใช้ DropdownButton2

class DropDownFriend extends StatefulWidget {
  const DropDownFriend({super.key});

  @override
  State<DropDownFriend> createState() => _DropDownFriendState();
}

class _DropDownFriendState extends State<DropDownFriend> {
  String? dropdownValue;
  String? dropdownSelectNameValue;

  @override
  Widget build(BuildContext context) {
    var friendProvider = Provider.of<FriendProvider>(context);
    var imgProvider = Provider.of<ImageFriendProvider>(context);
    var friendList = friendProvider.friends;

    void handleChange(String? newValue) {
      setState(() {
        print(newValue);
        dropdownValue = newValue;
      });

      if (newValue != null) {
        print(friendProvider.friends) ; 
        var selectedFriend = friendProvider.friends
            .firstWhere((friend) => friend["uid"] == newValue);
        imgProvider.setFilter(selectedFriend["uid"]);
        print('Selected Friend ID: ${selectedFriend["uid"]}');
      } else {
        imgProvider.clearFilter();
      }
    }

    if (friendProvider.friends.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return Container(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          value: dropdownValue ?? imgProvider.filterBy,
          isExpanded: true,
          style: const TextStyle(color: Colors.deepPurple, fontSize: 15),
          menuItemStyleData: MenuItemStyleData(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          ),
          onChanged: handleChange,
          buttonStyleData: ButtonStyleData(
            height: 37,
            width: 170,
            padding: EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.black26,
              ),
              color: Colors.grey[300],
            ),
            elevation: 2,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.grey[300],
            ),
            offset: const Offset(-70, 0),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: WidgetStateProperty.all(6),
              thumbVisibility: WidgetStateProperty.all(true),
            ),
          ),
          selectedItemBuilder: (BuildContext context) {
            var a = [
              {"name": "All Friend"}
            ];

            return [
              ...a.map<Widget>((item) => Center(
                    // ✅ ครอบด้วย Center
                    child: Text(
                      item["name"]!,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  )),
              ...friendList.map<Widget>((friend) => Center(
                    // ✅ ครอบด้วย Center
                    child: Text(
                      friend["name"],
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  )),
            ];
          },
          items: [
            DropdownMenuItem<String>(
              value: null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    child: Icon(Icons.group , size: 30, color: Colors.black,),
                    backgroundColor: Colors.white,
                  ),
                  Text("All Friend" , style: TextStyle(fontSize: 16),),
                  Icon(Icons.arrow_right, color: Colors.deepPurple),
                ],
              ),
            ),
            ...friendList.map<DropdownMenuItem<String>>((friend) {
              return DropdownMenuItem<String>(
                value: friend["uid"],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                     backgroundImage: NetworkImage(friend["profile"]),
                      radius: 20,
                    ),
                    Text(friend["name"], style: TextStyle(fontSize: 16)),
                    Icon(Icons.arrow_right, color: Colors.deepPurple),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
