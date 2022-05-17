class json_model{
  int id;
  String date;
  String modified;
  String status;
  String link;
  String source_url;
  int author;
  Title title;
  Content content;
  String better_featured_image;
  Embedded embedded;
  Featuredmedia featuredmedia;
    String  credit;

  json_model({
    this.id,
    this.date,
    this.modified,
    this.status,
    this.link,
    this.author,
    this.title,
    this.content,
    this.better_featured_image,
    this.embedded,
    this.featuredmedia,
    this.source_url,
    this.credit

  });
  List <json_model> jmodel;
  static json_model filterList(json_model users, String filterString) {
    json_model tempUsers = users;
    List<json_model> _users = tempUsers.jmodel
        .where((u) =>
    (u.title.rendered.toLowerCase().contains(filterString.toLowerCase())) ||
        (u.content.rendered.toLowerCase().contains(filterString.toLowerCase())))
        .toList();
    users.jmodel = _users;
    return users;
  }
  factory json_model.fromJson(Map<String, dynamic> parsedJson){
    return json_model(
        id: parsedJson['id'],
       date: parsedJson == null ? 'NO DATE' :parsedJson['date'],
        modified: parsedJson == null ? 'NO MDATE' :parsedJson['modified'],
        status: parsedJson == null ? 'NO STATUS' :parsedJson['status'],
        link: parsedJson == null ? 'NO LINK' :parsedJson['link'],
        author: parsedJson == null ? 'NO AUTHOR' :parsedJson['author'],
        title: Title.fromJson(parsedJson['title']??''),
        content: Content.fromJson(parsedJson['content']??''),
        better_featured_image: parsedJson['_embedded']['wp:featuredmedia'] != null
        ? parsedJson['_embedded']['wp:featuredmedia'][0]['source_url']
        : null
        //  embedded:Embedded.fromJson(parsedJson["_embedded"]??''),
        // featuredmedia:Featuredmedia.fromJson(parsedJson["wp:featuredmedia"]??''),
        // source_url: parsedJson == null ? 'NO LINK' :parsedJson['source_url'],
        //source_url:parsedJson["source_url"]??''
         //better_featured_image:parsedJson == null ? 'NOIMG' : parsedJson["_embedded"]["wp:featuredmedia"][0]["source_url"]
        // better_featured_image: Embedded.fromJson(parsedJson["_embedded"]??''),
      //better_featured_image: parsedJson["_embedded"]["wp:featuredmedia"]["source_url"]??'NOIMG',
      //better_featured_image: Embedded.fromJson(parsedJson["_embedded"]??''),

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
  Featuredmedia featuredmedia;
  Embedded({
    this.featuredmedia
  });
  factory Embedded.fromJson(Map<String, dynamic> json){
    return Embedded(
      //source_url: json['source_url']
      featuredmedia: json == null ? 'NO FM' :json["wp:featuredmedia"][0]
        //term: json == [] ? 'NO_term' :json["wp:term"][0]
    );
  }
}
class Featuredmedia{
  String source_url;
  Featuredmedia({
    this.source_url
  });
  factory Featuredmedia.fromJson(Map<String, dynamic> json){
    return Featuredmedia(
      //source_url: json['source_url']
      source_url: json == null ? 'NOIMG' :json["source_url"],
      //term: json == [] ? 'NO_term' :json["wp:term"][0]
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
String getFromList(Map<String, dynamic> json, String key) {
  return json != null ? json[key] : "";
}