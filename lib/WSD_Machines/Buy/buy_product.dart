
import 'package:agri_app/WSD_Machines/Buy/detail_page.dart';
import 'package:agri_app/colors/appcolors.dart';
import 'package:agri_app/model/Product_Model.dart';
import 'package:agri_app/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuyProduct extends StatefulWidget {
  // String category;
  // BuyProduct({required this.category});

  @override
  _BuyProductState createState() => _BuyProductState();
}

class _BuyProductState extends State<BuyProduct> {
  late ProductProvider productProvider;
  List<ProductModel> productData = [];

  @override
  void initState() {
    ProductProvider _productProvider = Provider.of(context, listen: false);
    _productProvider.getAllProducts();
    // TODO: implement initState
    super.initState();
  }

  getMachines(){
    List<ProductModel> products =
    productProvider.getAllProductsList.where((element) {
      return element.category.contains("Machines");
    }).toList();
    return products;
  }
  @override
  Widget build(BuildContext context) {
    productProvider=Provider.of(context);
    productData=getMachines();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        elevation: 2.0,
        centerTitle: true,
        title: Text('Machines List'),
      ),
      body:productData.isEmpty?Center(child:Container(
        child: Center(child: Text("No Data"),),
      )): Padding(
        padding: EdgeInsets.only(top: 10,left: 10,right: 10),
        child: GridView.builder(
          itemCount: productData.length,
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            ProductModel data = productData[index];
            return GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                    DetailPage(data: data,)
                ));
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.55,
                width: MediaQuery.of(context).size.width * 0.25,
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green,
                      width: 5,
                    ),
                    borderRadius:
                    BorderRadius.all(Radius.circular(20))),
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(20.0),
                //     color: AppColors.platiniumColor,
                //     boxShadow: [
                //       BoxShadow(
                //           color: Colors.grey, offset: Offset(1, 1), blurRadius: 5),
                //     ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 10.0,),
                    Expanded(
                      flex: 2,
                      child: Image(
                        image: NetworkImage(data.productImage),
                        fit: BoxFit.fitWidth,

                      ),
                    ),
                    Text(
                      data.productName,
                      style: TextStyle(
                          color: AppColors.trueBlueColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ) ,
    );
  }
}
