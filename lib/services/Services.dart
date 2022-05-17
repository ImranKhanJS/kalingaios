import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kalingatv4/model/Categories.dart';
import 'package:kalingatv4/model/categories_link_model.dart';
import 'package:kalingatv4/model/json_model.dart';
import 'package:kalingatv4/model/link_model.dart';
import 'package:kalingatv4/model/social.dart';
class Services {
  static Future<List<json_model>> getTopTenNews(String id) async {
    try {
      var response;
      if(id=='top')
        {
           response =await http.get(Uri.parse("https://kalingatv.com/wp-json/wp/v2/posts?per_page=50&_embed"));
        }
      else{
         response =await http.get(Uri.parse("https://kalingatv.com/wp-json/wp/v2/posts?categories="+id+"&per_page=50&_embed"));
      }
      //final response =await http.get("https://kalingatv.com/wp-json/wp/v2/posts?categories=19");
      if (response.statusCode == 200) {
        List<json_model> list = parseTopTenNewsData(response.body);
        //print(list[1].title.rendered);
        return list??[];
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Parse the JSON response and return list of Album Objects //
  static List<json_model> parseTopTenNewsData(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    // return parsed.map<news_model>((json) => news_model.fromJson(json)).toList();
    return parsed.map<json_model>((json) => json_model.fromJson(json)).toList();
  }
  static Future<List<json_model> > fetchPost() async {
    List<json_model> _postList =new List<json_model>();
    final response =
    await http.get(Uri.parse('https://kalingatv.com/wp-json/wp/v2/posts?per_page=20&_embed'));

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      List<dynamic> values=new List<dynamic>();
      //print('TopNews Response22 : '+response.body);
      values = json.decode(response.body);
      if(values.length>0){
        for(int i=0;i<values.length;i++){
          if(values[i]!=null){
            Map<String,dynamic> map=values[i];
            _postList .add(json_model.fromJson(map));
            //debugPrint('Id-------${map['id']}');
          }
        }
      }
      return _postList;

    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
  static Future<List<json_model>> getTopNews() async {
    try {
      final response =await http.get(Uri.parse("https://kalingatv.com/wp-json/wp/v2/posts?per_page=20&_embed"));
      //final response =await http.get("https://kalingatv.com/wp-json/wp/v2/posts?categories=19&categories=18985&categories=17870&categories=1070&categories=2938&categories=26&categories=22&categories=17872&categories=17873&categories=376&per_page=50&_embed");
       var data=response.body.replaceAll(",[]", " ");
      print('TopNews Response : '+data.toString());
      if (response.statusCode == 200) {
        List<json_model> list = parseTopNewsData(data);
        //list.removeAt(0);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Parse the JSON response and return list of Album Objects //
  static List<json_model> parseTopNewsData(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    // return parsed.map<news_model>((json) => news_model.fromJson(json)).toList();
    return parsed.map<json_model>((json) => json_model.fromJson(json)).toList();
  }


  // static Future<List<Categories>> getCategories() async {
  //   try {
  //     final response =await http.get(Uri.parse("https://kalingatv.com/wp-json/wp/v2/categories"));
  //     if (response.statusCode == 200) {
  //       List<Categories> list = parseCategoryData(response.body);
  //       return list;
  //     } else {
  //       throw Exception("Error");
  //     }
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }
  // static List<Categories> parseCategoryData(String responseBody) {
  //   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  //   return parsed.map<Categories>((json) => Categories.fromJson(json)).toList();
  // }
  static Future<List<categories_link_model>> getTabCategories() async {
    try {
      final response =await http.get(Uri.parse("https://kalingatv.com/wp-json/wp/v2/categories?per_page=100&_embed"));
      if (response.statusCode == 200) {
        List<categories_link_model> list = parseTabCategoryData(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  static List<categories_link_model> parseTabCategoryData(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<categories_link_model>((json) => categories_link_model.fromJson(json)).toList();
  }
  static Future<List<json_model>> getNews(String catrgory) async {
    try {
      //final response =await http.get("http://intentitsolutions.com/kalingatv/API/getNewsByCategory.php?category="+catrgory);
      final response =await http.get(Uri.parse("https://kalingatv.com/wp-json/wp/v2/posts?categories="+catrgory+"&per_page=100&_embed"));
      if (response.statusCode == 200) {
        List<json_model> list = parseNewsData(response.body);
        //list.removeAt(0);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<json_model>> getOneNews(String catrgory) async {
    try {
      //final response =await http.get("http://intentitsolutions.com/kalingatv/API/getNewsByCategory.php?category="+catrgory);
      final response =await http.get(Uri.parse("https://kalingatv.com/wp-json/wp/v2/posts?categories="+catrgory+"&per_page=1&_embed"));
      if (response.statusCode == 200) {
        List<json_model> list = parseNewsData(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  static List<json_model> parseNewsData(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    // return parsed.map<news_model>((json) => news_model.fromJson(json)).toList();
    return parsed.map<json_model>((json) => json_model.fromJson(json)).toList();
  }
  static Future<List<json_model>> getDynCatNews(String category,String url) async {
    List<json_model> list=[];
    try {
      var response;
      if(category=='Top News')
        {
           response =await http.get(Uri.parse(url));

        }
      else{
         response =await http.get(Uri.parse(url));
      }
      //final response =await http.get("http://intentitsolutions.com/kalingatv/API/getNewsByCategory.php?category="+catrgory);
      print('TOP NEWS DATA : '+response.body);
      if (response.statusCode == 200) {
         list = parseDynCatNewsData(response.body);
         for(int i=0; i < list.length; i++ )
           {
             if(list[i].better_featured_image==null)
             {
               list.remove(list[i]);
             }
           }
        //list.removeAt(0);
        //list.removeLast();
        //print('NEWS DATA11 : '+list.toString());
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  static List<json_model> parseDynCatNewsData(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    // return parsed.map<news_model>((json) => news_model.fromJson(json)).toList();
    return parsed.map<json_model>((json) => json_model.fromJson(json)).toList();
  }
  static Future<List<json_model>> getRelatedNews(String category,String url) async {
    try {
      var response;
      if(category=='Top News')
      {
        response =await http.get(Uri.parse(url));

      }
      else{
        response =await http.get(Uri.parse(url+'&per_page=4&_embed'));
      }
      //final response =await http.get("http://intentitsolutions.com/kalingatv/API/getNewsByCategory.php?category="+catrgory);
      //final response =await http.get(Uri.parse(url+'&per_page=4&_embed'));
      //print('TOP NEWS DATA : '+response.body);
      if (response.statusCode == 200) {
        List<json_model> list = parseRelatedData(response.body);
        //list.removeAt(0);
        //list.removeLast();
        //print('NEWS DATA11 : '+response.body.toString());
        return list.sublist(0,4);
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  static List<json_model> parseRelatedData(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    // return parsed.map<news_model>((json) => news_model.fromJson(json)).toList();
    return parsed.map<json_model>((json) => json_model.fromJson(json)).toList();
  }
  static Future<List<json_model>> getSearchNews(String keyword) async {
    try {
     // print('Keyword111 : '+keyword);
      //final response =await http.get("http://intentitsolutions.com/kalingatv/API/getNewsByCategory.php?category="+catrgory);
      final response =await http.get(Uri.parse("https://kalingatv.com/wp-json/wp/v2/posts?search="+keyword+"&per_page=6&_embed"));
      //final response =await http.get("https://kalingatv.com/wp-json/wp/v2/posts?search=naveen&per_page=10&_embed");
     //final response =await http.get("https://kalingatv.com/wp-json/wp/v2/posts?categories=19&per_page=10&_embed");
      //print('Keyword Response : '+response.body);
      if (response.statusCode == 200) {
        List<json_model> list = parseSearchNewsData(response.body);
       // print('Search List: '+list.toString());
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  static List<json_model> parseSearchNewsData(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    // return parsed.map<news_model>((json) => news_model.fromJson(json)).toList();
    return parsed.map<json_model>((json) => json_model.fromJson(json)).toList();
  }

  static Future<json_model> getSearchNews2() async {
    try {
      final response = await http.get(Uri.parse('https://kalingatv.com/wp-json/wp/v2/posts?categories=19'));
      if (200 == response.statusCode) {
        return parseUsers(response.body);
      }
      else {
        return json_model();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return json_model();
    }
  }

  static json_model parseUsers(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    List<json_model> parsedata = parsed.map<json_model>((json) => json_model.fromJson(json)).toList();
    json_model u = json_model();
    u.jmodel = parsedata;
    return u;
  }
  static Future<List<json_model>> getDetails(String id) async {
    try {
      final response =await http.get(Uri.parse("http://intentitsolutions.com/kalingatv/API/getNewsDetails.php?category="+id));
      if (response.statusCode == 200) {
        List<json_model> list = parseDetailsData(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Parse the JSON response and return list of Album Objects //
  static List<json_model> parseDetailsData(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<json_model>((json) => json_model.fromJson(json)).toList();
  }
  static Future<List<link_model>> getShareLink() async {
    try {
      final response =await http.get(Uri.parse("http://intentitsolutions.com/kalingatv/API/getLink.php"));
      if (response.statusCode == 200) {
        List<link_model> list = parseShareLink(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Parse the JSON response and return list of Album Objects //
  static List<link_model> parseShareLink(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<link_model>((json) => link_model.fromJson(json)).toList();
  }
  static Future<List<social>> getSocial() async {
    try {
      // final response =await http.get(Uri.parse(ApiConstant.api1+"getCategory.php"));
      final response =await http.get(Uri.parse("https://kalingatv.com/wp-admin/category/link/getSocial.json"));
      if (response.statusCode == 200) {
        List<social> list = parseSocial(response.body);
        print('SOCIAL '+list.toString());
        //catageryLength=list.length;
        //print('CatageryLength '+catageryLength.toString());
        return list;
        //return list;
      } else {
        throw Exception("Error");
      }
    }
    catch (e) {
      throw Exception(e.toString());
    }
  }

  // Parse the JSON response and return list of Album Objects //
  static List<social> parseSocial(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<social>((json) => social.fromJson(json)).toList();
  }
}