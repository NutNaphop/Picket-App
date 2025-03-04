import 'package:flutter/material.dart';
import 'package:locket_mockup/components/Appbar/CustomAppbar.dart';

class FriendImageListPage extends StatefulWidget {
  const FriendImageListPage({super.key});

  @override
  State<FriendImageListPage> createState() => _FriendImageListPageState();
}

class _FriendImageListPageState extends State<FriendImageListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: GridView.builder(
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, crossAxisSpacing: 8, mainAxisSpacing: 9),
          padding: EdgeInsets.all(8),
          itemCount: 28,
          itemBuilder: (context, index) {
            return Container(
              width: 92,
              height: 92,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.pop(context) ; 
        },
        child: Icon(
          Icons.favorite,
          size: 40,
          color: Color(0xFFF281C1),
        ),
      ),
    );
  }
}
