import 'package:agri_app/model/User_Data_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';



class UserProvider extends ChangeNotifier{

  late UserModel currentData;

  void getUserData() async {
    UserModel userModel;
    var value = await FirebaseFirestore.instance
        .collection("UsersData")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (value.exists) {
      userModel = UserModel(
        userEmail: value.get("Email"),
        firstName: value.get("FirstName"),
        lastName: value.get('LastName'),
        role: value.get("Role"),
      );
      currentData = userModel;
      notifyListeners();
    }
  }

  UserModel get currentUserData {
    return currentData;
  }

//   Future<void> updateData(mapData,uid)async{
//     await FirebaseFirestore.instance.collection('UserRecord').doc(uid).update(mapData);
//     notifyListeners();
//   }
//
// List<UserModel> tailorsData=[];
//   void getAllTailors()async{
//     UserModel userModel;
//     List<UserModel> _newList=[];
//     QuerySnapshot value = await FirebaseFirestore.instance
//         .collection("UserRecord")
//         .get();
//
//     value.docs.forEach((element) {
//       userModel=UserModel(shopName:element.get("ShopName"),userEmail: element.get("Email"), userImage:element.get("userImage"), firstName:element.get("FirstName"), address:element.get("Address"), gender:element.get("Gender"), lastName:element.get("LastName"), phone:element.get("phone"), uid:element.get("userUid"),);
//        _newList.add(userModel);
//     });
//     tailorsData=_newList;
//     notifyListeners();
//
//   }
//   List<UserModel> get getTailorsProfile{
//     return tailorsData;
//   }
}