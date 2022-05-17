class link_model {
  int id;
  String link;

  link_model({this.id,this.link});

  // Return object from JSON //
  factory link_model.fromJson(Map<String, dynamic> json) {
    return link_model(
        id: json['id'] as int,
        link: json['link'] as String);
  }
}