class json_model2{
  int id;
  String date;
  String modified;
  String status;
  String link;
  int author;
  Title title;
  Content content;
  Embedded better_featured_image;

  json_model2({
    this.id,
    this.date,
    this.modified,
    this.status,
    this.link,
    this.author,
    this.title,
    this.content,
    this.better_featured_image
  });
  List <json_model2> jmodel;
  static json_model2 filterList(json_model2 users, String filterString) {
    json_model2 tempUsers = users;
    List<json_model2> _users = tempUsers.jmodel
        .where((u) =>
    (u.title.rendered.toLowerCase().contains(filterString.toLowerCase())) ||
        (u.content.rendered.toLowerCase().contains(filterString.toLowerCase())))
        .toList();
    users.jmodel = _users;
    return users;
  }
  factory json_model2.fromJson(Map<String, dynamic> parsedJson){
    return json_model2(
        id: parsedJson['id'],
       date: parsedJson == null ? 'NO DATE' :parsedJson['date'],
        modified: parsedJson == null ? 'NO MDATE' :parsedJson['modified'],
        status: parsedJson == null ? 'NO STATUS' :parsedJson['status'],
        link: parsedJson == null ? 'NO LINK' :parsedJson['link'],
        author: parsedJson == null ? 'NO AUTHOR' :parsedJson['author'],
        title: Title.fromJson(parsedJson['title']),
        content: Content.fromJson(parsedJson['content']),
         //better_featured_image:parsedJson == null ? 'NOIMG' : parsedJson["_embedded"]["wp:featuredmedia"][0]["source_url"]
        better_featured_image: Embedded.fromJson(parsedJson["_embedded"])
    );
  }
}

// class Better_featured_image {
//   String source_url;
//   Better_featured_image({
//     this.source_url
//   });
//   factory Better_featured_image.fromJson(Map<String, dynamic> json){
//     return Better_featured_image(
//         //source_url: json['source_url']
//         source_url: json == null ? 'NOIMG' :json["source_url"]
//     );
//   }
// }
class Embedded {
  String source_url;
  Embedded({
    this.source_url
  });
  factory Embedded.fromJson(Map<String, dynamic> json){
    return Embedded(
      //source_url: json['source_url']
        source_url: json == null ? 'NOIMG' :json["wp:featuredmedia"][0]["source_url"]
        //source_url: json == null ? 'NOIMG' :json["source_url"]
    );
  }
}

class Content {
  String rendered;
  Content({
    this.rendered
  });
  factory Content.fromJson(Map<String, dynamic> json){
    return Content(
        rendered: json == null ? 'NOCONTENT' :json['rendered']
    );
  }
}

class Title {
  String rendered;
  Title({
  this.rendered
  });
  factory Title.fromJson(Map<String, dynamic> json){
    return Title(
        rendered: json == null ? 'NO TITLE' :json['rendered']
    );
  }
}
