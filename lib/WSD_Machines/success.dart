
import 'package:agri_app/WSD_Machines/home_page.dart';

import 'package:agri_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Success extends StatefulWidget {


  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  late UserProvider _data;
  @override
  Widget build(BuildContext context) {
    _data=Provider.of(context);
    var data=_data.currentUserData;
    return Scaffold(
      backgroundColor:  Color(0xFFFFFFFF),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/success.gif'),
                  height: 150.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Successful !!",
                    style:TextStyle(
                      fontSize: 20.0,
                      color:Color(0xFF303030),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 24.0, vertical: 10.0),
            child: Text(
              "Place Order Successfully",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                color: Color(0xFF808080),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(vertical: 24.0),
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: FlatButton(
              padding: EdgeInsets.symmetric(vertical:10.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              color:  Color(0xFFFF8084),
              textColor:Color(0xFFFFFFFF),
              highlightColor:Colors.transparent,
              onPressed: (){
               Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => MachinesHomePage(),
                  ),
                );
              },
              child: Text("Ok".toUpperCase()),
            ),
          )

        ],
      ),
    );
  }
}