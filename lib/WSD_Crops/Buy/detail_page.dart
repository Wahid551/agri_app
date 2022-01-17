import 'package:agri_app/Farmer/cart/cartScreen.dart';
import 'package:agri_app/model/Product_Model.dart';
import 'package:agri_app/provider/product_provider.dart';
import 'package:agri_app/provider/review_cart_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

enum SignleCharacter { fill, outline }
class DetailPage extends StatefulWidget {
  ProductModel data;

  DetailPage({required this.data});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late ProductProvider productProvider;

  SignleCharacter _character = SignleCharacter.fill;
  late ReviewProvider reviewProvider;
  bool isAdd=false;
  getReviewData()async{
    await FirebaseFirestore.instance
        .collection('ReviewCart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('YourReviewCart')
        .doc(widget.data.userDocId).get().then((value){
      if (this.mounted)
      {
        if (value.exists)
        {
          setState(
                () {
              isAdd = value.get("isAdd");
            },
          );
        }
      }
    } );
  }

  Widget bonntonNavigatorBar({
    required Color iconColor,
    required Color backgroundColor,
    required Color color,
    required String title,
    required IconData iconData,
    required void Function() onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(20),
          color: backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 20,
                color: iconColor,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                title,
                style: TextStyle(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context);
    reviewProvider = Provider.of(context);
    getReviewData();
    return Scaffold(
      bottomNavigationBar: Row(
        children: [
          bonntonNavigatorBar(
              backgroundColor: Color(0xffd1ad17),
              color: Colors.black87,
              iconColor: Colors.white70,
              title: "Go To Cart",
              iconData: Icons.shop_outlined,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>  CartScreen(),
                ));
              }),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black87),
        title: Text(
          'Product Overview',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  ListTile(
                    title: Text(widget.data.productName),
                    subtitle: Text("\Rs" + widget.data.productPrice.toString()),
                  ),
                  Container(
                    height: 250.0,
                    padding: EdgeInsets.all(40.0),
                    child: Image.network(widget.data.productImage),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Check Availability',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 3.0,
                              backgroundColor: Colors.green[700],
                            ),
                            Radio(
                              value: SignleCharacter.fill,
                              groupValue: _character,
                              activeColor: Colors.green[700],
                              onChanged: (value) {
                                setState(() {
                                  //  _character = value;
                                });
                              },
                            ),
                          ],
                        ),
                        Text('\Rs${widget.data.productPrice}'),
                        InkWell(
                          onTap: () {
                            reviewProvider.addReviewCartData(
                              context: context,
                              cartPrice: widget.data.productPrice,
                              cartCategory: widget.data.category,
                              cartDesc: widget.data.productDesc,
                              cartId: widget.data.userDocId,
                              cartImage: widget.data.productImage,
                              cartName: widget.data.productName,
                             OwnerId: widget.data.userUid,
                            );
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height *
                                0.10 /
                                2,
                            width:
                            MediaQuery.of(context).size.width * 0.20,
                            decoration: BoxDecoration(
                              //color: Colors.red,
                              border: Border.all(color: Colors.orange),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Center(
                              child: isAdd==true?Icon(FontAwesomeIcons.check,color: Colors.orange,): Text("ADD",
                                  style:
                                  TextStyle(color: Colors.black45)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About This Product',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    widget.data.productDesc,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
