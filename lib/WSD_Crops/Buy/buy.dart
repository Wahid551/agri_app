
import 'package:agri_app/WSD_Crops/Buy/bid_page.dart';
import 'package:agri_app/WSD_Crops/drawer.dart';
import 'package:flutter/material.dart';


// ignore: camel_case_types
class SmartConnect extends StatefulWidget{
    String user;
    SmartConnect({required this.user});
  @override
  _smartConnectState createState() => _smartConnectState();
}

// ignore: camel_case_types
class _smartConnectState extends State<SmartConnect> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer:  MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        elevation: 2.0,
        centerTitle: true,
        title: Text("Buy Crops"),
      ),

      body: Container(
        // color: Colors.green,
        padding: EdgeInsets.only(
          left: 10.0,
          right: 20.0,
        ),
        width: double.infinity,
        height: size.height,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: size.height * 0.03),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: .70,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: <Widget>[
                Container(
                        height: 230,
                        width: 150,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.green,
                              width: 5,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              child: Container(
                                  width: 70,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.amber,
                                      width: 4,
                                    ),
                                  ),
                                  child: ClipOval(
                                      child: Image.network(
                                    "https://static.hanos.com/sys-master/productimages/h3e/h60/9264319365150/34191901.jpg_914Wx914H",
                                    fit: BoxFit.cover,
                                    width: 50,
                                    height: 60,
                                  ))),
                            ),
                            Container(
                              height: 60,
                              width: 120,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Product Description"),
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Container(
                                width: 50,
                                height: 20,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(
                                      "MSP",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            RaisedButton(
                              color: Colors.blue,
                              elevation: 3,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BidPage(
                                         "https://static.hanos.com/sys-master/productimages/h3e/h60/9264319365150/34191901.jpg_914Wx914H",
                                          "MSP",
                                          "Desc","wheat")),
                                );
                              },
                              child: new Text(
                                'BID',
                                style: new TextStyle(
                                    fontSize: 12.0, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                  Container(
                    height: 230,
                    width: 150,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.green,
                          width: 5,
                        ),
                        borderRadius:
                        BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Container(
                              width: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.amber,
                                  width: 4,
                                ),
                              ),
                              child: ClipOval(
                                  child: Image.network(
                                    "https://static.hanos.com/sys-master/productimages/h3e/h60/9264319365150/34191901.jpg_914Wx914H",
                                    fit: BoxFit.cover,
                                    width: 50,
                                    height: 60,
                                  ))),
                        ),
                        Container(
                          height: 60,
                          width: 120,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Product Description"),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                              borderRadius:
                              BorderRadius.all(Radius.circular(5))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Container(
                            width: 50,
                            height: 20,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  "MSP",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        RaisedButton(
                          color: Colors.blue,
                          elevation: 3,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BidPage(
                                      "https://static.hanos.com/sys-master/productimages/h3e/h60/9264319365150/34191901.jpg_914Wx914H",
                                      "MSP",
                                      "Desc","wheat")),
                            );
                          },
                          child: new Text(
                            'BID',
                            style: new TextStyle(
                                fontSize: 12.0, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}