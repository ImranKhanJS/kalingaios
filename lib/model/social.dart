class social {
  String id ;
  final String name;
  final String icon;
  final String link;
  final String status;
  social({this.id,this.name,this.icon,this.link,this.status});
  factory social.fromJson(Map<String, dynamic> json) {
    return social(
      id: json['id'] as String,
        name: json['name'] as String,
        icon: json['icon'] as String,
        link: json['link'] as String,
      status: json['status'] as String
    );
  }
}