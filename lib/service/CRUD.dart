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
    'profile': user["url"]
  });
}

Future<Object?> getUser(String uid) async {
  DocumentSnapshot documentSnapshot =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();

  return documentSnapshot.data();
}

Future<void> updateUser(var user) async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(user["uid"])
      .update({'name': user["name"], 'profile': user["profile"]});
}

Future<void> deleteUserAccount() async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    
    if (user != null) {
      String uid = user.uid;

      // ลบข้อมูลผู้ใช้จาก Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).delete();

      // ลบผู้ใช้จาก Firebase Authentication
      await user.delete();

      print("User account deleted successfully!");
    } else {
      print("No user is currently signed in.");
    }
  } catch (e) {
    print("Failed to delete user: $e");
  }
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
    String status;
    if (requestedUserIds.contains(user_id)) {
      print('Set Pending');
      status = "Pending";
    } else if (friendUserIds.contains(user_id)) {
      print("Set Friend");
      status = "Friend";
    } else {
      status = "Add";
    }

    user_info.add({
      "uid": user_id,
      "name": doc["name"],
      "profile": doc["profile"],
      "status": status
    });
  }

  return user_info;
}
