class ProductModel {
  late String productId;
  late String productName;
  late String? productDescription;
  late num productPrice;
  late int productQuantity;
  late String productCategoryType;
  late List<dynamic> productImg;
  late String vendorName;

  ProductModel({
    required this.productId,
    required this.productName,
    this.productDescription,
    required this.productPrice,
    this.productQuantity = 1,
    required this.productImg,
    required this.productCategoryType,
    required this.vendorName,
  });
}
