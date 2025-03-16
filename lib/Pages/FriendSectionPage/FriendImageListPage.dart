import 'package:flutter/material.dart';
import 'package:locket_mockup/components/Appbar/CustomAppBarWithFilter.dart';
import 'package:locket_mockup/providers/CameraProvider.dart';
import 'package:locket_mockup/providers/ControlPageProvider.dart';
import 'package:locket_mockup/providers/FriendImageProvider.dart';
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
          child: _buildBody(imageProvider, pageProvider, context)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.pop(context);
          cameraProvider.initializeCamera();
          pageProvider.jumpPage(0);
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

Widget _buildBody(ImageFriendProvider imageProvider,
    ControlPageProvider pageProvider, BuildContext context) {
  if (imageProvider.images.isEmpty || imageProvider.images[0]["noImage"] == true) {
    return Center(
      child: Container(
        width: 300,
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.photo_library_outlined,
              size: 100,
              color: Colors.white,
            ),
            Text(
              "No sended image",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "There is no image here hmmm... Let's take a photo !",
              style: TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ); // ✅ กรณีไม่มีข้อมูล
  }

  return GridView.builder(
    // ✅ กรณีมีข้อมูล
    physics: AlwaysScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
      crossAxisSpacing: 8,
      mainAxisSpacing: 9,
    ),
    padding: EdgeInsets.all(8),
    itemCount: imageProvider.images.length,
    itemBuilder: (context, index) {
      var imageData = imageProvider.images[index];

      if (imageData == null ||
          imageData["image"] == null ||
          imageData["image"]["url"] == null) {
        return Container(
          color: Colors.grey, // หรือใส่ Icon หรือ Text แจ้งเตือน
          child: Icon(Icons.image_not_supported, size: 50, color: Colors.white),
        );
      }

      return GestureDetector(
        onTap: () {
          Navigator.pop(context);
          pageProvider.jumpPage(index + 1);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(imageData["image"]["url"], fit: BoxFit.cover),
        ),
      );
    },
  );
}
