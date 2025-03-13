import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:locket_mockup/service/CRUD.dart';
import 'package:locket_mockup/service/auth_service.dart';

Stream<List<Map<String, dynamic>>> getFriendsStream(List<dynamic> friendList) {
  return FirebaseFirestore.instance
      .collection('users')
      .where('uid', whereIn: friendList)
      .snapshots()
      .map((snapshot) {
    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  });
}

Stream<List<Map<String, dynamic>>> getFriendList(user) {
  return getUser(user!.uid).asStream().asyncExpand((userInfo) {
    if (userInfo == null || userInfo is! Map<String, dynamic>) {
      return Stream.value([]);
    }

    List<dynamic> friendIds = userInfo["friends"] ?? [];
    if (friendIds.isEmpty) return Stream.value([]);

    // เปลี่ยนจาก `.first` เป็น return stream โดยตรง
    return getFriendsStream(friendIds);
  });
}

Future getFriendArray(user) async {
  var userInfo = await getUser(user["uid"]) as Map<String, dynamic>;
  var friendsList =
      userInfo["friends"] as List<dynamic>; // ดึงค่า "friends" ออกมาเป็น List

  return friendsList;
}

Stream<Map<String, dynamic>> getFriendRequests(String uid) async* {
  // ดึงข้อมูลโปรไฟล์ก่อน
  var user = await getUser(uid) as Map<String, dynamic>;
  var profile = user["profile"];

  // รวมข้อมูลโปรไฟล์เข้ากับสตรีมของ friend_requests
  yield* FirebaseFirestore.instance
      .collection('friend_requests')
      .where('to', isEqualTo: uid)
      .snapshots(includeMetadataChanges: true)
      .map((snapshot) {
        return {
          "profile": profile,
          "friend_requests": snapshot.docs.map((doc) {
            var data = doc.data();
            data["rid"] = doc.id;
            return data;
          }).toList(),
        };
      });
}



Future<String> sendFriendRequest(Map user, String friendId) async {
  bool _isExist = await checkUser(friendId);
  var user_info = await getUser(user["uid"]) as Map<String,dynamic>; 
  var friend_list = user_info["friends"] as List<dynamic>;

  if(friend_list.length > 20){
    return "Max";
  }

  if (_isExist && friendId.isNotEmpty) {
    var snapshot = await FirebaseFirestore.instance
        .collection('friend_requests')
        .where('from', isEqualTo: user["uid"])
        .where('to', isEqualTo: friendId)
        .get();

    if (snapshot.docs.isEmpty) {
      await FirebaseFirestore.instance.collection('friend_requests').add({
        'from': user['uid'],
        'from_username': user['name'],
        'to': friendId,
        'date': Timestamp.now()
      });
      return "Success";
    } else {
      print('Friend request already exists.');
    }
  }

  return "Fail";
}

Future<void> acceptFriend(
    String userId, String requestId, String fromUserId) async {
  if (userId != null) {
    // เพิ่มเพื่อนเข้า Firestore
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      "friends": FieldValue.arrayUnion([fromUserId])
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(fromUserId)
        .update({
      "friends": FieldValue.arrayUnion([userId])
    });

    // ลบคำขอออกจาก friend_requests
    await FirebaseFirestore.instance
        .collection('friend_requests')
        .doc(requestId)
        .delete();
  }
}

Future<void> rejectFriend(
  String requestId,
) async {
  // ลบคำขอออกจาก friend_requests
  await FirebaseFirestore.instance
      .collection('friend_requests')
      .doc(requestId)
      .delete();
}

Future<void> deleteFriend(String id, String uid) async {
  print(id);
  print(uid);
  await FirebaseFirestore.instance.collection('users').doc(uid).update({
    "friends": FieldValue.arrayRemove([id])
  });
}
