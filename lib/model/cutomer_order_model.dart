class CustomerOrderModel{

  List<dynamic> ItemsList;
  double totalAmount;
  String area;
  String street;
  String pincode;
  String city;
  String society;
  String customerId;

  CustomerOrderModel({required this.customerId, required this.area,required this.pincode,required this.street,required this.city,required this.society,required this.totalAmount,required this.ItemsList});
}