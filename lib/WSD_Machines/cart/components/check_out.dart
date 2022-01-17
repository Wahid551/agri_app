
import 'package:agri_app/WSD_Machines/cart/components/delivery_detail.dart';
import 'package:agri_app/provider/check_out_provider.dart';
import 'package:agri_app/provider/review_cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';






class CheckoutCard extends StatefulWidget {
  const CheckoutCard({
    Key? key,
  }) : super(key: key);

  @override
  _CheckoutCardState createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {

  late ReviewProvider reviewProvider;
  // late CheckoutProvider deliveryAddressProvider;
  String measurement="";
  @override
  Widget build(BuildContext context)
  {
    // deliveryAddressProvider = Provider.of(context);
    // deliveryAddressProvider.getDeliveryAddressData();
    reviewProvider=Provider.of(context);
    var totalPrice=reviewProvider.getTotalPrice();
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 30,
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: 40,
                  width:40,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset("assets/images/receipt.svg"),
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total:\n",
                    children: [
                      TextSpan(
                        text: "\$${totalPrice}",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 190,
                  child:SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        primary: Colors.white,
                        backgroundColor: Color(0xFFFF7643),
                      ),
                      onPressed: (){

                           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DeliveryDetails()));


                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}