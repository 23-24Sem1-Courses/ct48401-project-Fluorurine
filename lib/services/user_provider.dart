import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:ct484_final/models/user_model.dart';

class UserProvider with ChangeNotifier {
  void addUserData({
    required currentUser,
    String? userName,
    String? userImage,
    String? userEmail,
  }) async {
    await FirebaseFirestore.instance
        .collection("usersData")
        .doc(currentUser.uid)
        .set(
      {
        "userName": userName,
        "userEmail": userEmail,
        "userImage": userImage,
        "userUid": currentUser.uid,
      },
    );
  }

  late UserModel currentData;

  void getUserData() async {
    UserModel userModel;
    // check current user not null to get it uid, if yes then eixt the function
    User? userdata = FirebaseAuth.instance.currentUser;
    if (userdata == null) {
      return;
    }
    var value = await FirebaseFirestore.instance
        .collection("usersData")
        .doc(userdata.uid)
        .get();
    if (value.exists) {
      userModel = UserModel(
        userEmail: value.get("userEmail"),
        userImage: value.get("userImage"),
        userName: value.get("userName"),
        userUid: value.get("userUid"),
      );
      currentData = userModel;
      notifyListeners();
    }
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    currentData = UserModel(
      userEmail: "",
      userImage: "",
      userName: "",
      userUid: "",
    );
    notifyListeners();
  }

  UserModel get currentUserData {
    return currentData;
  }
}
