class CategoryModel {
  String? categoryId;
  String? categoryImg;
  String? categoryTitle;

  CategoryModel({
    required this.categoryId,
    required this.categoryImg,
    required this.categoryTitle,
  });

  ///from json to model
  CategoryModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryImg = json['categoryImg'];
    categoryTitle = json['categoryTitle'];
  }

  ///from model to json
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['categoryId'] = categoryId;
    json['categoryImg'] = categoryImg;
    json['categoryTitle'] = categoryTitle;
    return json;
  }
}
