import 'package:flutter/material.dart';
import 'package:kalingatv4/model/json_model.dart';
import 'package:kalingatv4/ui/NewsItem.dart';
import 'TopNewsOne1.dart';
import 'news_card.dart';

class NewsList extends StatelessWidget {
  final List<json_model> items;
  String index1;
  NewsList({Key key, this.items});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        //return TopNewsOne1(item: items[index]);
      if(index % 5 == 0) {
        return TopNewsOne1(index1,item: items[index]);
      }
      else
        {
          return NewsItem(index1,item: items[index]);
        }
      },
    );
  }
}