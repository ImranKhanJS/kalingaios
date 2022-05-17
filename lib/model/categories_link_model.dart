class categories_link_model {
  String name;
  String link;
  String icon;

  categories_link_model({this.name,this.link,this.icon});

  // Return object from JSON //
  factory categories_link_model.fromJson(Map<String, dynamic> json) {
    return categories_link_model(
        name: json == null ? 'NO Categiry' :json['name'] as String,
        link: json == null ? 'NO LINK' : json['link'] as String,
        icon: json['icon'] as String);
  }
}