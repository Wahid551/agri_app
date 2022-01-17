import 'package:agri_app/model/cutomer_order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';


class CustomerOrdersProvider extends ChangeNotifier {
  List<CustomerOrderModel> _customerOrders = [];

  void getCustomerOrders() async {
    CustomerOrderModel _orderModel;
    List<CustomerOrderModel> _newList = [];
    QuerySnapshot data =
        await FirebaseFirestore.instance.collection("CustomerOrders").where("OwnerId",isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();

    data.docs.forEach((element) {
      _orderModel = CustomerOrderModel(
        totalAmount: element.get("TotalAmount"),
        ItemsList: element.get("ItemsList"),
        city: element.get("city"),
        area:  element.get("area"),
        pincode:  element.get("pinCode"),
        society:  element.get("society"),
        street:  element.get("street"),
        customerId: element.get("CustomerId"),
      );
      _newList.add(_orderModel);
      notifyListeners();
    });
    _customerOrders=_newList;
    notifyListeners();
  }


  List<CustomerOrderModel> get getCustomerOrdersList{
    return _customerOrders;
  }
}
