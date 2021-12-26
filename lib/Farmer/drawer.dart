import 'package:agri_app/Farmer/Buy/Add.dart';
import 'package:agri_app/Farmer/home_page.dart';
import 'package:agri_app/colors/appcolors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class MyDrawer extends StatefulWidget {
  // late userData userProvider;
  // MyDrawer({required this.userProvider});

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {


  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.grey.shade400,
                Colors.green,
              ]
          ),
        ),
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.grey.shade400,
                        AppColors.whiteSmokeColor,
                      ]
                  )
              ),
              accountName: Text(
                'ABCD',
                // widget.userProvider.currentUserData.firstName+" "+widget.userProvider.currentUserData.lastName,
                style: GoogleFonts.titanOne(
                  textStyle: TextStyle(
                      color: Colors.black,fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              accountEmail: Text(
                'email@gmail.com',
                // widget.userProvider.currentUserData.userEmail,
                style: TextStyle(color: Colors.black87),
              ),
              currentAccountPicture: CircleAvatar(
                 backgroundImage: NetworkImage('https://static.remove.bg/remove-bg-web/6cc620ebfb5922c21227f533a09d892abd65defa/assets/start_remove-c851bdf8d3127a24e2d137a55b1b427378cd17385b01aec6e59d5d4b5f39d2ec.png'),
                // backgroundImage: NetworkImage(widget.userProvider.currentUserData.userImage),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context) => FarmerHomePage()
                ));
              },
              child: ListTile(
                selectedTileColor: AppColors.apricotColor,
                title: Text(
                  "Home",
                  style: TextStyle(color: Colors.black87, fontSize: 15),
                ),
                leading: Icon(CupertinoIcons.home, color: Colors.black87,),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context) => AddProduct(title:"Add Crops")
                ));
              },
              child: ListTile(
                selectedTileColor: AppColors.coralColor,
                title: Text(
                  "Sell Crops",
                  style: TextStyle(color: Colors.black87, fontSize: 15),
                ),
                leading: Icon(CupertinoIcons.profile_circled, color: Colors.black87,),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> AddProduct(title: "Add Machines",)));
              },
              child: ListTile(
                selectedTileColor: AppColors.apricotColor,
                selected: true,
                title: Text(
                  "Sell Machines",
                  style: TextStyle(color: Colors.black87, fontSize: 15),
                ),
                leading: Icon(CupertinoIcons.add_circled, color: Colors.black87,),
              ),
            ),
            GestureDetector(
              onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProduct(title:"Add Machines",)));
              },
              child: ListTile(
                selectedTileColor: AppColors.apricotColor,
                selected: true,
                title: Text(
                  "Customer Orders",
                  style: TextStyle(color: Colors.black87, fontSize: 15),
                ),
                leading: Icon(CupertinoIcons.add_circled, color: Colors.black87,),
              ),
            ),
            GestureDetector(
              onTap: (){
                // Navigator.push(context, MaterialPageRoute(builder: (context)=> CustomerOrderLists()));
              },
              child: ListTile(
                selectedTileColor: AppColors.apricotColor,
                selected: true,
                title: Text(
                  "Orders List",
                  style: TextStyle(color: Colors.black87, fontSize: 15),
                ),
                leading: Icon(CupertinoIcons.list_bullet_below_rectangle, color: Colors.black87,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(thickness: 2, color: Colors.white),
            ),
            ListTile(
              onTap: ()async{
                // await FirebaseAuth.instance.signOut().then((value) {
                //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>WelcomeScreen()));
                // });

              },
              selectedTileColor: AppColors.apricotColor,
              selected: true,
              title: Text(
                "Logout",
                style: TextStyle(color: Colors.black87, fontSize: 15),
              ),
              leading: Icon(Icons.logout_outlined, color: Colors.black87,),
            ),
          ],
        ),
      ),
    );
  }
}

