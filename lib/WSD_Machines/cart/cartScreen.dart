
import 'package:agri_app/WSD_Machines/cart/body.dart';
import 'package:agri_app/WSD_Machines/cart/components/check_out.dart';
import 'package:agri_app/provider/review_cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {


  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late ReviewProvider _reviewProvider;
  @override
  Widget build(BuildContext context) {
    _reviewProvider=Provider.of(context);
    _reviewProvider.getReviewCartData();
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(reviewProvider: _reviewProvider,),
      bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Column(
        children: [
          Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            _reviewProvider.getReviewCartDataList.length.toString()+" "+"Items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}