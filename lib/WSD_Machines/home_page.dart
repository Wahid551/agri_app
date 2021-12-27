import 'package:agri_app/Farmer/categories.dart';

import 'package:agri_app/WSD_Machines/Buy/buy.dart';
import 'package:agri_app/WSD_Machines/drawer.dart';
import 'package:agri_app/WSD_Machines/weather_update.dart';
import 'package:flutter/material.dart';



class MachinesHomePage extends StatefulWidget {
  const MachinesHomePage({Key? key}) : super(key: key);

  @override
  _MachinesHomePageState createState() => _MachinesHomePageState();
}

class _MachinesHomePageState extends State<MachinesHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer:  MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        elevation: 2.0,
        centerTitle: true,
        title: Text('Machines Whole Sale Dealer'),
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
                        title: "Buy Machines",
                        image: "assets/images/machines.png",
                        press: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>SmartConnect()));
                        },
                      ),
                      CategoryCard(
                        title: "Mandi Updates",
                        image: "assets/images/mandi.png",
                        press: () {
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) => SmartConnect(user: "fertilizers")));
                        },
                      ),
                      CategoryCard(
                        title: "Weather Updates",
                        image: "assets/images/weather.png",
                        press: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => WeatherUpdates()));
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
