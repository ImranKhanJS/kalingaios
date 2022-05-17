import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kalingatv4/model/json_model.dart';
import 'package:share/share.dart';
import 'package:intl/intl.dart';
import 'articleDetail.dart';

class TopNewsOne1 extends StatelessWidget {
  TopNewsOne1(this.index1, {this.cat,this.item, List<json_model> items2,this.id});
  String category='top',id,cat,index1;
  final json_model item;
  static String stripHtmlIfNeeded(String text) {
    return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
  }
  Widget build(BuildContext context) {
    if(item.better_featured_image=='NOIMG')
      return Container(
        child: Visibility(
          visible: false,
          child: Text("Gone"),
        ),
      );
    else {
      var parsedDate = DateTime.parse(item.modified.replaceAll(RegExp('T'),' '));
      String formattedDate = DateFormat('MMMM d, y', 'en_US' ).format(parsedDate);
      //print('TOP_DATA : Title '+item.title.rendered+' '+item.link+' '+item.content.rendered);
      return Stack(
          children: <Widget>[
            checkImage(context, item.better_featured_image,
                item.title.rendered,formattedDate, item.link,item.content.rendered,item.author.toString(),id,item.credit),
            // Container(
            //   child:InkWell(
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => ArticleDetail(item.better_featured_image.source_url,item.title.rendered,item.content.rendered,category),
            //         ),
            //       );
            //     }, // Handle your callback
            //   ),
            // ),

            Positioned(
                left: 15,
                bottom: 15,
              child:GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArticleDetail(index1,cat,item.better_featured_image,
                            item.title.rendered,formattedDate,item.content.rendered,item.link,item.author.toString(),id,item.credit),
                      ),
                    );
                  },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.5)
                  ),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      width: 340.0,
                      height: 70.0,
                      child:Center(
                        child: Text(
                          stripHtmlIfNeeded(item.title.rendered),
                          maxLines: 3,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        //child: getHtml(item.title.rendered)
                      ),
                      // child:new Html(
                      //   data:item.title.rendered??'',
                      //     style:{
                      //       'h2': Style(fontSize: FontSize(20),color:Colors.white,fontWeight: FontWeight.bold,maxLines: 3, textOverflow: TextOverflow.ellipsis),
                      //     }
                      //   //defaultTextStyle: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w500,fontFamily: 'Roboto'),
                      // ),
                      // child: AutoSizeText(
                      //   ConvertHtml(item.title.rendered),
                      //   style: TextStyle(fontFamily: 'Roboto',fontSize: 30.0, color: Colors.white),
                      //   maxLines: 3,
                      // ),
                    ),
                  ),
                )
            ),
            ),
            // Align(
            //   alignment: Alignment.topRight,
            //   child: IconButton(
            //     icon: const Icon(Icons.share),
            //     color: Colors.grey,
            //     onPressed: () {
            //       _onShareLink(context);
            //     },
            //   ),
            // ),
            // Column(
            //   children: <Widget>[
            //     Icon(
            //       Icons.share,
            //       color: Colors.grey,
            //       size: 20.0,
            //     ),
            //     SizedBox(
            //       width: 5,
            //     ),
            //     // Icon(
            //     //   Icons.keyboard_arrow_right,
            //     //   color: Colors.grey,
            //     //   size: 30.0,
            //     // ),
            //   ],
            // ),
          ]
      );
    }

      //checkImage(context, item.better_featured_image.source_url);
    // return Container(
    //     padding: EdgeInsets.all(2),
    //     height: 250,
    //     width: MediaQuery.of(context).size.width,
    //   decoration: BoxDecoration(
    //     image: DecorationImage(
    //       fit: BoxFit.fill,
    //       image: NetworkImage("https://picsum.photos/250?image=9"),
    //     ),
    //   ),
        // child: Card(
        //   elevation: 5,
        //   child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: <Widget>[
        //         checkImage(item.better_featured_image.source_url),
        //         Expanded(
        //             child: Container(
        //                 padding: EdgeInsets.all(5),
        //                 child: Column(
        //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                   children: <Widget>[
        //                     //Text(this.item.title.rendered,
        //                     //style: TextStyle(fontWeight: FontWeight.bold)),
        //                     Text("id:${this.item.id}"),
        //                     //Text("title:${this.item.title.rendered}"),
        //                   ],
        //                 )))
        //       ]),
        // )
    // );
  }
  Widget checkImage(BuildContext context,String image,String title, String date,String link,String content,String author, String id,String credit) {
      return  Container(
        padding: EdgeInsets.all(2),
        height: 200,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(image),
          ),
        ),
        child:InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticleDetail(index1,cat,image,title,date,content,link,author,id,credit),
              ),
            );
          }, // Handle your callback
        ),
      );
    }
  _onShareLink(BuildContext context) async {
    await Share.share(item.link);
  }
  }