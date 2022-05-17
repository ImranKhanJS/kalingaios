import 'package:flutter/material.dart';
import 'package:kalingatv4/model/json_model.dart';
import 'package:kalingatv4/ui/NewsItem.dart';
import 'TopNewsOne1.dart';
import 'news_card.dart';

class CategoryNewsList extends StatelessWidget {
  List<json_model> items=[];
  final String id;
  String cat,index1;
  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }
  CategoryNewsList(this.index1, {Key key, this.cat,this.items,this.id});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length??0,
      itemBuilder: (context, index) {
      //Map wppost = items[index] as Map;
        //return NewsItem(item: items[index]);
        //return TopNewsOne1(item: items[index]);
        if(index % 5 == 0) {
          return TopNewsOne1(index1,cat:cat,item: items[index],id:id);
        }
        else
        {
          return NewsItem(index1,cat:cat,item: items[index],id:id);
        }
        }
    );
  }
}