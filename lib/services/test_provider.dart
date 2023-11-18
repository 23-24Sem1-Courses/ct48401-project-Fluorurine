import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
// import 'package:ct484_final/models/user_model.dart';

class TestProvider with ChangeNotifier {
  void test() async {
    FirebaseFirestore.instance.collection("test").get().then(
      (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
          print("This is testing 2");
          print(docSnapshot.get("test1"));
          print(docSnapshot.get("test2"));
          print("This is testing 3");
          print(docSnapshot.get("test3"));
          print(docSnapshot.get("test4"));
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
}
