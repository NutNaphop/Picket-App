  import 'dart:io';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:locket_mockup/service/CRUD.dart';
import 'package:locket_mockup/service/Friend/CRUD_friend.dart';

Future<String?> uploadImageToCloudinary(File imageFile) async {
    
    final cloudName = "dzfeowrkg"; // ใส่ชื่อ Cloudinary ของคุณ
    final uploadPreset =
        "locket"; // ใช้ Upload Preset ที่ตั้งค่าไว้

    final url =
        Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/image/upload");

    var request = http.MultipartRequest("POST", url)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();
    final responseData = await response.stream.bytesToString();
    final jsonResponse = json.decode(responseData);

    if (response.statusCode == 200) {
      return jsonResponse['secure_url']; // คืนค่า URL ของภาพที่อัปโหลดแล้ว
    } else {
      print("Upload failed: ${jsonResponse['error']['message']}");
      return null;
    }
  }


Future saveImageFireStore(Map data)async{

  var userInfo = await getUser(data["by"]) as Map<String, dynamic>;
  print(userInfo) ; 

  await FirebaseFirestore.instance.collection('pics').add({
    "by" : data["by"] , 
    "caption" : data["caption"] ,
    "date" : data["date"] , 
    "url" : data["url"] , 
    "username" :  userInfo["name"] 
  }) ;
}

Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getImageFriend() async*{
  var userId = FirebaseAuth.instance.currentUser!.uid; 
  var friendList = await getFriendArray({
    "uid" : userId 
  }) as List;
  friendList.add(userId) ; 
  
  yield* FirebaseFirestore.instance
      .collection('pics')
      .where('by', whereIn: friendList)
      .snapshots()
      .map((snapshot) {
        var docs = snapshot.docs;
        docs.sort((a, b) {
          Timestamp timestampA = a['date'];
          Timestamp timestampB = b['date'];
          return timestampB.compareTo(timestampA); // เรียงจากใหม่ไปเก่า
        });

        if (docs.length > 0){
          return docs ;
        }
        return [];
      });
}
