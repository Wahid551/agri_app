import 'package:flutter/material.dart';


class MandiUpdates extends StatefulWidget {
  const MandiUpdates({Key? key}) : super(key: key);

  @override
  _MandiUpdatesState createState() => _MandiUpdatesState();
}

class _MandiUpdatesState extends State<MandiUpdates> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer:  MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        elevation: 2.0,
        centerTitle: true,
        title: Text('Mandi Updates'),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 150.0,),
        child: Card(
          color: Colors.green.shade200,
          elevation: 10.0,
          child: Padding(
            padding: EdgeInsets.only(left: 8.0,right: 8.0,),
            child: Text('60+ gram cage eggs available for Rs.4450/crate,'
                ' at your door step in Lahore.Minimum order of 10 crates.'
                'White Potato available for sale @Rs.2500/bag at our field '
                'office in Hujra Shah Muqeem.Orders open for Maize crop: Rs.1650/mond(40kg)'
                ' for 12% moisture and Rs.1400/mond(40kg) for 16-18% moisture.Now facilitating'
                ' investors and traders in investment and storage of crops!',style: TextStyle(fontSize: 20.0,),),

          ),
        ),
      ),
    );
  }
}
