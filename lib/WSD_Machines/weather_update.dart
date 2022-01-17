import 'package:agri_app/Farmer/drawer.dart';
import 'package:flutter/material.dart';


class WeatherUpdates extends StatefulWidget {
  const WeatherUpdates({Key? key}) : super(key: key);

  @override
  _WeatherUpdatesState createState() => _WeatherUpdatesState();
}

class _WeatherUpdatesState extends State<WeatherUpdates> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer:  MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        elevation: 2.0,
        centerTitle: true,
        title: Text('Weather Updates'),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 150.0,),
        child: Card(
          color: Colors.green.shade200,
          elevation: 10.0,
          child: Padding(
            padding: EdgeInsets.only(left: 8.0,right: 8.0,),
            child: Text('Rain/snow is expected in Islamabad, upper Khyb'
                'er Pakhtunkhwa, upper Punjab, lower Balochistan, lower Si'
                'ndh, Gilgit-Baltistan and Kashmir. Dry/Partly cloudy weather i'
                's expected in other parts of the country. Fog/ smog is likely t'
                'o prevail in central/south parts of Punjab.',style: TextStyle(fontSize: 20.0,),),
          ),
        ),
      ),
    );
  }
}
