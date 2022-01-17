import 'package:agri_app/provider/check_out_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../custom_text_field.dart';

class AddDeliverAddress extends StatefulWidget {
  @override
  _AddDeliverAddressState createState() => _AddDeliverAddressState();
}

enum AddressTypes {
  Home,
  Work,
  Other,
}

class _AddDeliverAddressState extends State<AddDeliverAddress> {
  var myType = AddressTypes.Home;
  // late TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Add Delivery Address",
          style: TextStyle(fontSize: 18,color:Color(0xFFFF7643),fontWeight: FontWeight.bold ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 48,
        child: checkoutProvider.isloadding == false
            ? MaterialButton(
                onPressed: () {
                  checkoutProvider.validator(context, myType);
                },
                child: Text(
                  "Add Address",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Color(0xFFFF7643),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: ListView(
          children: [
            CostomTextField(
              labText: "First name",
              controller: checkoutProvider.firstName,
              keyboardType: TextInputType.text,
            ),
            CostomTextField(
              labText: "Last name",
              controller: checkoutProvider.lastName,
              keyboardType: TextInputType.text,
            ),
            CostomTextField(
              labText: "Mobile No",
              controller: checkoutProvider.mobileNo,
              keyboardType: TextInputType.phone,
            ),
            CostomTextField(
              labText: "Alternate Mobile No",
              controller: checkoutProvider.alternateMobileNo,
              keyboardType: TextInputType.phone,
            ),
            CostomTextField(
              labText: "Society",
              controller: checkoutProvider.scoiety,
              keyboardType: TextInputType.text,
            ),
            CostomTextField(
              labText: "Street",
              controller: checkoutProvider.street,
              keyboardType: TextInputType.text,
            ),
            CostomTextField(
              labText: "Landmark",
              controller: checkoutProvider.landmark,
              keyboardType: TextInputType.text,
            ),
            CostomTextField(
              labText: "City",
              controller: checkoutProvider.city,
              keyboardType: TextInputType.text,
            ),
            CostomTextField(
              labText: "Area",
              controller: checkoutProvider.aera,
              keyboardType: TextInputType.text,
            ),
            CostomTextField(
              labText: "Pin Code",
              controller: checkoutProvider.pincode,
              keyboardType: TextInputType.number,
            ),
            // Divider(
            //   color: Colors.black,
            // ),
            ListTile(
              title: Text("Address Type*"),
            ),
            RadioListTile(
              activeColor: Color(0xFFFF7643),
              value: AddressTypes.Home,
              groupValue: myType,
              title: Text("Home"),
              onChanged: (AddressTypes? value) {
                setState(() {
                  myType = value!;
                });
              },
              secondary: Icon(
                Icons.home,
                color:Color(0xFFFF7643),
              ),
            ),
            RadioListTile(
              activeColor: Color(0xFFFF7643),
              value: AddressTypes.Work,
              groupValue: myType,
              title: Text("Work"),
              onChanged: (AddressTypes? value) {
                setState(() {
                  myType = value!;
                });
              },
              secondary: Icon(
                Icons.work,
                color:Color(0xFFFF7643),
              ),
            ),
            RadioListTile(
              activeColor: Color(0xFFFF7643),
              value: AddressTypes.Other,
              groupValue: myType,
              title: Text("Other"),
              onChanged: (AddressTypes? value) {
                setState(() {
                  myType = value!;
                });
              },
              secondary: Icon(
                Icons.devices_other,
                color:Color(0xFFFF7643),
              ),
            )
          ],
        ),
      ),
    );
  }
}
