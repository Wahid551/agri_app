class ProductModel{

  String productName;
  String productDesc;
  String productImage;
  String sellerName;
  int productPrice;
  String userUid;
  String category;
  String userDocId;

  ProductModel({required this.userDocId, required this.userUid,required this.productDesc,required this.productImage,required this.productName,required this.productPrice,required this.category,required this.sellerName});


}