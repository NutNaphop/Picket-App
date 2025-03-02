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
var friendsList = userInfo["friends"] as List<dynamic>; // ดึงค่า "friends" ออกมาเป็น List

return friendsList ; 
  
  
}

Stream<QuerySnapshot> getFriendRequests(String uid) {
  return FirebaseFirestore.instance
      .collection('friend_requests')
      .where('to', isEqualTo: uid)
      .snapshots();
}

Future<void> sendFriendRequest(Map user, String friendId) async {
  bool _isExist = await checkUser(friendId);
  if (_isExist && friendId.isNotEmpty) {
    await FirebaseFirestore.instance.collection('friend_requests').add({
      'from': user['uid'],
      'from_username': user['name'],
      'to': friendId,
    });
  }
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
