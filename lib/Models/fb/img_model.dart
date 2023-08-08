class ImgModel {
  String? link;
  String? path;

  ImgModel({
    this.link,
    this.path,
  });

  ImgModel.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['link'] = link;
    json['path'] = path;
    return json;
  }
}
