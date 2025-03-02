import 'package:cloud_firestore/cloud_firestore.dart';

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

  return documentSnapshot.data() ;
}

