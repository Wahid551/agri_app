import 'package:flutter/material.dart';


class SingleDeliveryItem extends StatelessWidget {
  final String title;
  final String address;
  final String number;
  final String addressType;
  SingleDeliveryItem(
      {required this.title,
      required this.addressType,
      required this.address,
      required this.number});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Container(
                width: 60,
                padding: EdgeInsets.all(1),
                height: 20,
                decoration: BoxDecoration(
                    color: Color(0xFFFF7643),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    addressType,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          leading: CircleAvatar(
            radius: 8,
            backgroundColor:Color(0xFFFF7643),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(address),
              SizedBox(
                height: 5,
              ),
              Text(number),
            ],
          ),
        ),
        Divider(
          height: 35,
        ),
      ],
    );
  }
}
