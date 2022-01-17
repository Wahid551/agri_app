import 'dart:io';

import 'package:agri_app/colors/appcolors.dart';
import 'package:agri_app/provider/product_provider.dart';
import 'package:agri_app/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';


class AddProduct extends StatefulWidget {
  String title;
  AddProduct({required this.title});

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final productNameController = TextEditingController();
  final productPriceController=TextEditingController();
  final productDescController = TextEditingController();
  late UserProvider userData;
  File? selectedImage;
  final picker = ImagePicker();
  bool _isLoading = false;
  late ProductProvider _productProvider;

  // Get Image from Gallery
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  // Upload image to Cloud Storage then Add Data To Firestore
  uploadProduct() async {
    if (formKey.currentState!.validate() && selectedImage != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: new Row(
                children: [
                  new CircularProgressIndicator(),
                  SizedBox(
                    width: 25.0,
                  ),
                  new Text("Loading, Please wait"),
                ],
              ),
            ),
          );
        },
      );

      /// uploading image to firebase storage
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child("ProductImages")
          .child("${randomAlphaNumeric(9)}.jpg");

      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);

      task.whenComplete(() async {
        try {
          var downloadURL = await firebaseStorageRef.getDownloadURL();
          print("this is url $downloadURL");
          Map<String, dynamic> productMap = {
            "ProductImage": downloadURL,
            "ProductPrice": int.parse(productPriceController.text),
            "ProductName": productNameController.text,
            "ProductDesc": productDescController.text,
            "userDocId": "${randomAlphaNumeric(9)}${FirebaseAuth.instance.currentUser!.uid}",
            "userUid":FirebaseAuth.instance.currentUser!.uid,
            'DateTime': DateTime.now().toIso8601String(),
            "category":widget.title=="Add Seeds"?"Seeds":"Fertilizers",
            "sellerName":userData.currentUserData.firstName+" "+userData.currentUserData.lastName,
          };

          /// Add Data to Firestore
          _productProvider.addProduct(productMap).then((result) {
            Navigator.of(context).pop();
            // Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(
                  "Product Added Successfully",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            );
          });
        } catch (onError) {
          print("Error");
        }
      });
      // var downloadUrl =
      //     await (await task.whenComplete(() => null)).ref.getDownloadURL();

    } else {}
  }

  // var _value = 0;
  // var valueChoose;
  List listItems = ["Crops","Machine"];
  @override
  Widget build(BuildContext context) {
    _productProvider = Provider.of(context);
    userData=Provider.of(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 30),
              child: Text(
                "Seeds WHD",
                textScaleFactor: 1.3,
                style: GoogleFonts.abel(
                  textStyle: TextStyle(
                      color: Colors.green.shade600,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                  letterSpacing: 1.2,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 12.0),
              child: Text(
                widget.title,
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: AppColors.eigengrauColor,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    ListTile(
                      leading: Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Name",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      trailing: Container(
                        padding: EdgeInsets.only(right: 10),
                        child: SizedBox(
                          width: 130,
                          height: 45,
                          child: TextFormField(
                            controller: productNameController,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                fillColor:Colors.green.shade200,
                                filled: true,
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                )),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Name of Product';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ListTile(
                      leading: Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Price",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      trailing: Container(
                        padding: EdgeInsets.only(right: 10),
                        child: SizedBox(
                          width: 130,
                          height: 45,
                          child: TextFormField(
                            controller:productPriceController ,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Price';
                              }
                              return null;
                            },
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                fillColor: Colors.green.shade200,
                                filled: true,
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                )),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            "Add Picture",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        GestureDetector(
                            onTap: (){
                              getImage();
                            },
                            child: selectedImage != null?Container(
                              margin: EdgeInsets.only(right: 18),
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: AppColors.welcomeTextFieldColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.file(
                                  selectedImage!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ):
                            Container(
                              margin: EdgeInsets.only(right: 18),
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.green.shade200,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(Icons.add_photo_alternate,
                                size: 35, color: Colors.green.shade900,),
                            )
                        )
                      ],
                    ),
                    SizedBox(height: 25),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        "Description",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        controller: productDescController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Description';
                          }
                          return null;
                        },
                        maxLines: 5,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            fillColor: Colors.green.shade200,
                            filled: true,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: (){
                        uploadProduct();
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 75),
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white54,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.green.shade200,
                                  spreadRadius: 1,
                                  offset: Offset(1, 0),
                                  blurRadius: 8)
                            ]),
                        child: Center(
                          child: Text("Submit",
                              style: GoogleFonts.knewave(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20))),
                        ),
                      ),
                    ),
                    SizedBox(height: 60),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
