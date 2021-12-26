import 'package:agri_app/Farmer/categories.dart';
import 'package:agri_app/WSD_Seeds/Buy/buy.dart';
import 'package:agri_app/WSD_Seeds/drawer.dart';

import 'package:flutter/material.dart';


class SeedsHomePage extends StatefulWidget {
  const SeedsHomePage({Key? key}) : super(key: key);

  @override
  _SeedsHomePageState createState() => _SeedsHomePageState();
}

class _SeedsHomePageState extends State<SeedsHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer:  MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        elevation: 2.0,
        centerTitle: true,
        title: Text('Whole Sale Dealer Seeds'),
      ),

      body: Container(
        padding: EdgeInsets.only(
          left: 10.0,
          right: 20.0,
        ),
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: size.height * 0.03),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: .85,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: <Widget>[
                      CategoryCard(
                        title: "Buy Seeds",
                        image: "assets/images/seeds.png",
                        press: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>SmartConnect(user: "seeds",)));
                        },
                      ),
                      CategoryCard(
                        title: "Buy Fertilizers",
                        image: "assets/images/fertilizers.png",
                        press: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => SmartConnect(user: "fertilizers")));
                        },
                      ),
                      // CategoryCard(
                      //   title: "Upload Document",
                      //   image: "assets/images/progress.png",
                      //   press: () {
                      //     showStatus();
                      //   },
                      // ),
                    ],
                  ),
                ),
              ],
            ),

            //child,
          ],
        ),
      ),
    );
  }
}
