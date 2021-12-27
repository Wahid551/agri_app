import 'package:agri_app/Farmer/categories.dart';
import 'package:agri_app/WSD_Crops/Buy/buy.dart';
import 'package:agri_app/WSD_Crops/drawer.dart';
import 'package:agri_app/WSD_Crops/weather_update.dart';
import 'package:flutter/material.dart';



class CropsHomePage extends StatefulWidget {
  const CropsHomePage({Key? key}) : super(key: key);

  @override
  _CropsHomePageState createState() => _CropsHomePageState();
}

class _CropsHomePageState extends State<CropsHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer:  MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        elevation: 2.0,
        centerTitle: true,
        title: Text('Crops Whole Sale Dealer'),
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
                        title: "Buy Crops",
                        image: "assets/images/crops.png",
                        press: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>SmartConnect(user: "crops",)));
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
                           MaterialPageRoute(builder: (context) => WeatherUpdates());
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
