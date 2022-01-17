class ReviewCartModel {
  late String cartId;
  late String cartImage;
  late int cartPrice;
  late String cartName;
  late String cartCategory;
  late String cartSDesc;
  late bool isAdd;
  String OwnerId;
  ReviewCartModel({
    required this.cartId,
    required this.cartImage,
    required this.cartName,
    required this.cartPrice,required this.cartCategory,required this.cartSDesc,required this.isAdd,
    required this.OwnerId
  });
}
