import 'package:flutter/material.dart';
import 'package:kalingatv4/model/json_model.dart';
import 'package:intl/intl.dart';
import 'package:kalingatv4/ui/NewsItem.dart';
import 'TopNewsOne1.dart';
import 'articleDetail.dart';
import 'news_card.dart';
import 'package:flutter_html/flutter_html.dart';
class ArticleDetailsGrid extends StatelessWidget {
  final List<json_model> items;
  String id,cat,index;
  ArticleDetailsGrid({Key key,this.index,this.cat, this.items,this.id});
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 8.0,
        children: List.generate(items.length, (index) {
      return Center(
        child: SelectCard(index:index.toString(),cat:cat,item: items[index],id:id),
      );
    }
    ),
    );
  }
}

class SelectCard extends StatelessWidget {
  SelectCard({Key key, this.index,this.cat,this.item,this.id}) : super(key: key);
  final json_model item;
  String id,cat,index;
  static String stripHtmlIfNeeded(String text) {
    return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
  }
  @override
  Widget build(BuildContext context) {
    //final TextStyle textStyle = Theme.of(context).textTheme.display1;
    var parsedDate = DateTime.parse(item.modified.replaceAll(RegExp('T'),' '));
    String formattedDate = DateFormat('MMMM d, y', 'en_US' ).format(parsedDate);
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ArticleDetail(index,cat,item.better_featured_image,
                      item.title.rendered,formattedDate, item.content.rendered,item.link,item.author.toString(), this.id,item.credit),
            ),
          );
    },
      child: Container(
        height: double.infinity,
      width: 150,
      child:Card(
        elevation: 0,
        color: Colors.white,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
             // Expanded(
                //child:Container(
              Container(
                margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                  width: double.infinity,
                  height: 90,
                  decoration: BoxDecoration(color: Colors.red,
                      image: DecorationImage(
                        //image: NetworkImage(_news_model.better_featured_image.source_url,),
                        image: NetworkImage(
                            item.better_featured_image),
                        fit: BoxFit.cover,
                      )),
                ),
              SizedBox(
                height: 3,
              ),
              //),
              Container(
                //height: double.infinity,
                margin: const EdgeInsets.only(left: 5.0, right: 5.0),
              // child: new Html(
              //   data:item.title.rendered,
              //   style: {
              //     // p tag with text_size
              //     "p": Style(
              //       fontSize: FontSize(16),fontWeight: FontWeight.bold
              //     ),
              //   },
              // ),
              child:Text(
                stripHtmlIfNeeded(item.title.rendered),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 14,
                  color: const Color(0xff080f18),
                  fontWeight: FontWeight.w500,
                ),),
              ),
            ]
        ),
        )
    ),),
    );
  }
}