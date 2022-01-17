import 'package:agri_app/model/Product_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';


class ProductProvider extends ChangeNotifier {
  Future<void> addProduct(productData) async {
    FirebaseFirestore.instance
        .collection("Products")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("MyProducts")
        .add(productData)
        .then((value) {
      FirebaseFirestore.instance
          .collection("AllProducts")
          .doc().set(productData);
    })
        .catchError((e) {
      print(e);
    });
    notifyListeners();
  }
  List<ProductModel> myProductList=[];
  late ProductModel productModel;
  void getMyProducts() async {
    ProductModel _productModel;
    List<ProductModel> _newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("Products")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("MyProducts")
        .get();
    value.docs.forEach((data) {
      _productModel = ProductModel(
          userUid: data.get("userUid"),
          category: data.get("category"),
          sellerName: data.get("sellerName"),
          productDesc: data.get("ProductDesc"),
          productImage: data.get("ProductImage"),
          productName: data.get("ProductName"),
          userDocId: data.get("userDocId"),
          productPrice: data.get("ProductPrice"));
          _newList.add(_productModel);
          notifyListeners();
    });
       myProductList=_newList;
       notifyListeners();
  }

  List<ProductModel> get getMyProductsList{
    return myProductList;
  }

  Future<void> updateProduct(productData,userDocId) async {

    FirebaseFirestore.instance
        .collection("Products")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("MyProducts")
        .where("userDocId", isEqualTo:userDocId)
        .get()
        .then((res) {
      print(res.docs.length);
      FirebaseFirestore.instance
          .collection("Products")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("MyProducts")
          .doc(res.docs[0].id)
          .update(productData);
      notifyListeners();

    });

    FirebaseFirestore.instance
        .collection("AllProducts").where("userDocId",isEqualTo:userDocId).get().then((res){
      FirebaseFirestore.instance.collection("AllProducts").doc(res.docs[0].id).update(productData);
      notifyListeners();
    });



    notifyListeners();

  }

  Future<void >deleteProduct(userDocId)async{
    FirebaseFirestore.instance
        .collection("Products")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("MyProducts")
        .where("userDocId", isEqualTo:userDocId)
        .get()
        .then((res) {
      print(res.docs.length);
      FirebaseFirestore.instance
          .collection("Products")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("MyProducts")
          .doc(res.docs[0].id).delete();
      notifyListeners();

    });

    FirebaseFirestore.instance
        .collection("AllProducts").where("userDocId",isEqualTo:userDocId).get().then((res){
      FirebaseFirestore.instance.collection("AllProducts").doc(res.docs[0].id).delete();
      notifyListeners();
    });
  }

  // get All Seeds Products
  List<ProductModel> allProductsList=[];
  late ProductModel productsModel;
  void getAllProducts() async {
    ProductModel _productsModel;
    List<ProductModel> _newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("AllProducts")
        .where("userUid",isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    value.docs.forEach((data) {
      _productsModel = ProductModel(
          userUid: data.get("userUid"),
          category: data.get("category"),
          sellerName: data.get("sellerName"),
          productDesc: data.get("ProductDesc"),
          productImage: data.get("ProductImage"),
          productName: data.get("ProductName"),
          userDocId: data.get("userDocId"),
          productPrice: data.get("ProductPrice"));
      _newList.add(_productsModel);
      notifyListeners();
    });
    allProductsList=_newList;
    notifyListeners();
  }

  List<ProductModel> get getAllProductsList{
    return allProductsList;
  }
  // List<ProductModel> list=[];
  // // late ProductModel productModel;
  // void getProducts(String uid) async {
  //   ProductModel _productModel;
  //   List<ProductModel> _newList = [];
  //   QuerySnapshot value = await FirebaseFirestore.instance
  //       .collection("Products")
  //       .doc(uid)
  //       .collection("MyProducts")
  //       .get();
  //   value.docs.forEach((data) {
  //     // print(value.docs.length);
  //     _productModel = ProductModel(
  //         userUid: data.get("userUid"),
  //         genderCategory: data.get("GenderCategory"),
  //         productCategory: data.get("ProductCategory"),
  //         productDesc: data.get("ProductDesc"),
  //         productImage: data.get("ProductImage"),
  //         productName: data.get("ProductName"),
  //         userDocId: data.get("userDocId"),
  //         productPrice: data.get("ProductPrice"));
  //     _newList.add(_productModel);
  //     notifyListeners();
  //   });
  //   list=_newList;
  //   notifyListeners();
  // }
  //
  // List<ProductModel> get getTailorProductsList{
  //   return list;
  // }
}
