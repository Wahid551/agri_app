

import 'package:agri_app/model/notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';



class Notification_provider extends ChangeNotifier{
  FirebaseFirestore _user=FirebaseFirestore.instance;

 bool isLoading=false;
  void addData(UserId,mapdata)async{
    isLoading=true;
    notifyListeners();
    await FirebaseFirestore.instance.collection("Notifications").doc(UserId).collection("MyNotifications").add(
      mapdata,
    );
    isLoading=false;
    notifyListeners();
  }

  List<NotifyModel> _notifyData=[];
  void getData()async{
    NotifyModel _notifyModel;
    List<NotifyModel> _newList=[];
    QuerySnapshot data=await  _user.collection("Notifications").doc(FirebaseAuth.instance.currentUser!.uid).collection("MyNotifications").orderBy("time").get();

    data.docs.forEach((element) {
      _notifyModel=NotifyModel(notification: element.get("msg"));
      _newList.add(_notifyModel);
    });
    _notifyData=_newList;
    notifyListeners();

  }

  List<NotifyModel> get getnotifyData{
    return _notifyData;
  }

}