import 'package:agri_app/Farmer/Buy/Add.dart';
import 'package:agri_app/Farmer/Buy/buy.dart';
import 'package:agri_app/Farmer/Buy/buy_product.dart';
import 'package:agri_app/Farmer/drawer.dart';
import 'package:agri_app/Farmer/mandi_updates.dart';
import 'package:agri_app/Farmer/weather_update.dart';
import 'package:agri_app/provider/user_provider.dart';
import 'package:agri_app/ui/Climatefile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'categories.dart';

class FarmerHomePage extends StatefulWidget {
  const FarmerHomePage({Key? key}) : super(key: key);

  @override
  _FarmerHomePageState createState() => _FarmerHomePageState();
}

class _FarmerHomePageState extends State<FarmerHomePage> {
  late UserProvider userData;
  @override
  Widget build(BuildContext context) {
    userData=Provider.of<UserProvider>(context);
    userData.getUserData();

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer:  MyDrawer(userProvider: userData,),
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        elevation: 2.0,
        centerTitle: true,
        title: Text('Farmer Panel'),
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
                                  builder: (context) =>BuyProduct(category: "seeds",)));
                        },
                      ),
                      CategoryCard(
                        title: "Buy Fertilizers",
                        image: "assets/images/fertilizers.png",
                        press: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => BuyProduct(category: "fertilizers")));
                        },
                      ),
                      CategoryCard(
                        title: "Buy Machines",
                        image: "assets/images/machines.png",
                        press: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => BuyProduct(category: "machines")));
                        },
                      ),
                      CategoryCard(
                        title: "Mandi Updates",
                        image: "assets/images/mandi.png",
                        press: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => MandiUpdates()));
                        },
                      ),
                      CategoryCard(
                        title: "Weather Updates",
                        image: "assets/images/weather.png",
                        press: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => climate()));
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
