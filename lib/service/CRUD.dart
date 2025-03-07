import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:locket_mockup/service/Friend/CRUD_friend.dart';

Future<void> createUser(Map user) async {
  await FirebaseFirestore.instance.collection('users').doc(user["uid"]).set({
    'name': user["username"],
    'email': user["email"],
    'uid': user["uid"],
    'friends': [],
    'friends_request': [],
  });
}

Future<Object?> getUser(String uid) async {
  DocumentSnapshot documentSnapshot =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();

  return documentSnapshot.data();
}

Future<List> getListOfUser(String uid) async {
  ;
  var snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where("uid", isNotEqualTo: uid)
      .get();

  List<String> allUserIds =
      snapshot.docs.map((doc) => doc["uid"] as String).toList();

  // 🔥 Query หา friend_requests ที่มี uid อยู่ใน allUserIds
  var friendRequestSnapshot = await FirebaseFirestore.instance
      .collection('friend_requests')
      .where('to', whereIn: allUserIds)
      .where('from', isEqualTo: uid)
      .get();

  var friendListSnapshot =
      await FirebaseFirestore.instance.collection('users').get();

  var userInfo = await getUser(uid) as Map<String, dynamic>;
  var friendUserIds =
      userInfo["friends"] as List<dynamic>; // ดึงค่า "friends" ออกมาเป็น List

  // 📝 แปลงเป็น Set เพื่อเช็คง่ายขึ้น
  Set<String> requestedUserIds =
      friendRequestSnapshot.docs.map((doc) => doc["to"] as String).toSet();

  List user_info = [

  ] ;

  print(requestedUserIds);
  print(friendUserIds);
  // วนลูปแสดงข้อมูลของแต่ละเอกสาร
  for (var doc in snapshot.docs) {
    var user_id = doc["uid"];
    print('userId : $user_id') ; 
    String status;
    if (requestedUserIds.contains(user_id)) {
      print('Set Pending') ; 
      status = "Pending";
    } else if (friendUserIds.contains(user_id)) {
      print("Set Friend") ; 
      status = "Friend";
    } else {
       status = "Add";
    }

    user_info.add({
      "uid": user_id,
      "name": doc["name"],
      "profile": "null",
      "status": status
    });
  }

  return user_info;
}
