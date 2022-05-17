class news_model {
  int id;
  String description;
  String title;
  String image_url;
  String image;
  String type;
  String publish_date;
  String news_category;

  news_model({this.image_url,this.title,this.description,});

  // Return object from JSON //
  factory news_model.fromJson(Map<String, dynamic> json) {
    return news_model(
        image_url: json['image_url'] as String,
        title: json['title'] as String,
        description: json['description'] as String);
  }
}