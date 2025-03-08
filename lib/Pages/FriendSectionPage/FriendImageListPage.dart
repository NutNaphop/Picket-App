import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:locket_mockup/components/Appbar/CustomAppBarWithFilter.dart';
import 'package:locket_mockup/components/Appbar/CustomAppbar.dart';
import 'package:locket_mockup/providers/CameraProvider.dart';
import 'package:locket_mockup/providers/ControlPageProvider.dart';
import 'package:locket_mockup/providers/FriendImageProvider.dart';
import 'package:locket_mockup/service/Image/Image_service.dart';
import 'package:provider/provider.dart';

class FriendImageListPage extends StatefulWidget {
  const FriendImageListPage({super.key});

  @override
  State<FriendImageListPage> createState() => _FriendImageListPageState();
}

class _FriendImageListPageState extends State<FriendImageListPage> {


  @override
  Widget build(BuildContext context) {
    var pageProvider = Provider.of<ControlPageProvider>(context, listen: false);
    final cameraProvider = Provider.of<CameraProvider>(context, listen: false);
    var imageProvider = Provider.of<ImageFriendProvider>(context);

    return Scaffold(
      appBar: CustomAppBarWithFilter(),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: imageProvider.isLoading
            ? Center(child: CircularProgressIndicator()) // ✅ แสดงโหลดข้อมูล
            : imageProvider.images.isEmpty
                ? Center(child: Text('ไม่มีรูปภาพ'))
                : GridView.builder(
                    physics:
                        AlwaysScrollableScrollPhysics(), // ✅ แก้ปัญหาเลื่อนหน้าแรกไม่ได้
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 9),
                    padding: EdgeInsets.all(8),
                    itemCount: imageProvider.images.length,
                    itemBuilder: (context, index) {
                      var image = imageProvider.images[index];
                      return GestureDetector(
                        onTap: (){
                          Navigator.pop(context) ;
                          pageProvider.pageController.jumpToPage(index + 1) ; 
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            image["url"],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.pop(context);
          cameraProvider.initializeCamera() ; 
          pageProvider.pageController.jumpToPage(0);
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
