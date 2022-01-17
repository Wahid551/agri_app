import 'package:agri_app/Farmer/cart/components/cart_card.dart';
import 'package:agri_app/model/review_cart_model.dart';
import 'package:agri_app/provider/review_cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';


class Body extends StatefulWidget {
  ReviewProvider reviewProvider;
  Body({required this.reviewProvider});
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  late ReviewProvider _reviewProvider;
  Widget build(BuildContext context) {
    _reviewProvider=Provider.of(context);
    var data=widget.reviewProvider.getReviewCartDataList;
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index){
          ReviewCartModel model=data[index];
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Dismissible(
              key: Key(data[index].cartId.toString()) ,
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                setState(() {
                   data.removeAt(index);
                  _reviewProvider.reviewCartDataDelete(model.cartId);
                });
              },
              background: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFFFE6E6),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Spacer(),
                    SvgPicture.asset("assets/images/Trash.svg"),
                  ],
                ),
              ),
              // child:Container(),
              child: CartCard(model: model,),
            ),
          );
        }
      ),
    );
  }
}