import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kalingatv4/model/json_model.dart';
import 'package:kalingatv4/ui/rounded_bordered_container.dart';
import 'package:share/share.dart';
import 'package:intl/intl.dart';
import 'articleDetail.dart';

class NewsItem extends StatelessWidget {
  NewsItem(this.index1, {this.cat,this.item,this.id});
  String category='top',id,cat,index1;
  String img;
  final json_model item;
  bool visible = false ;
  static String stripHtmlIfNeeded(String text) {
    return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
  }
  Widget build(BuildContext context) {
    // if(item.better_featured_image.source_url=='NOIMG') {
    //var parsedDate = DateTime.parse(item.modified.replaceAll(RegExp('T'),', '));
    var dateTime3 = DateFormat('MM-dd-yyyy HH:mm', 'en_US').parse(item.modified.replaceAll(RegExp('T'),' '));
    // DateFormat.yMMMEd().format(item.modified.replaceAll(RegExp('T'),' ') as DateTime);
    // final formatter = DateFormat(r'''MM dd, yyyy 'at' hh:mm:ss a Z''');
    // final dateTimeFromStr = formatter.parse(item.modified.replaceAll(RegExp('T'),' '));
    // String date = DateFormat("yyyy-MM-dd hh:mm:ss").format(dateTimeFromStr);
    print('IMAGE DATA: '+item.better_featured_image);
    if(item.better_featured_image=='NOIMG') {
      print('TOP_NO_DATA : Title '+item.title.rendered+' '+item.link+' '+item.content.rendered+'IMG_URL'+item.better_featured_image);
      return Container(
        child: Visibility(
          visible: false,
          child: Text('Link :'+item.link+'\nIMG Link :'+item.better_featured_image+'\n\n'),
        ),
      );
    }
    else {
      print('TOP_DATA_ITEM : Title '+item.title.rendered+' '+item.link+' '+item.content.rendered);
      var parsedDate = DateTime.parse(item.modified.replaceAll(RegExp('T'),' '));
      // String formattedDate = DateFormat('d MMMM, y hh:mm', 'en_US' ).format(parsedDate);
      String formattedDate = DateFormat('MMMM d, y', 'en_US' ).format(parsedDate);
      print('DT_TM :'+formattedDate);
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ArticleDetail(index1,cat,item.better_featured_image,
                      item.title.rendered,formattedDate, item.content.rendered, item.link,item.author.toString(),this.id,item.credit),
            ),
          );
        }, // Handle your callback
        child: Column(
          children: <Widget>[
            RoundedContainer(
              elevation: 1,
              color: Colors.white,
              padding: const EdgeInsets.only(left: 10,right: 10),
              margin: EdgeInsets.all(1),
              height: 110,
              child: Row(
                children: <Widget>[
                  // if(_news_model.better_featured_image.source_url==null)
                  //  Container(
                  //    width: 100,
                  //    height: 90,
                  //    decoration: BoxDecoration(color: Colors.white,
                  //        image: DecorationImage(
                  //          //image: NetworkImage(_news_model.better_featured_image.source_url,),
                  //          image: NetworkImage(_news_model.better_featured_image.source_url),
                  //          fit:BoxFit.fill,
                  //        )),
                  //  ),
                  // checkImage(context, item.better_featured_image.source_url,
                  //     item.title.rendered, item.content.rendered),
                  Container(
                    //padding: EdgeInsets.only(left: 10),
                    width: 80,
                    height: 70,
                    decoration: BoxDecoration(color: Colors.white,
                        image: DecorationImage(
                          //image: NetworkImage(_news_model.better_featured_image.source_url,),
                          image: NetworkImage(
                              item.better_featured_image
                          ),
                          fit: BoxFit.fill,
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Container(
                      height: 80,
                      //padding: const EdgeInsets.symmetric(horizontal: 1),
                      padding: EdgeInsets.only(top: 5),
                      child: Column(
                        children: <Widget>[
                          // SizedBox(
                          //   height: 5,
                          // ),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                        child: Center(
                            child: Text(
                              stripHtmlIfNeeded(item.title.rendered),
                              maxLines: 3,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          //child: getHtml(item.title.rendered)
                        ),
                          ),
                          // SizedBox(
                          //   height: 5,style: TextStyle(
                          //                                 fontFamily: 'Roboto',
                          //                                 fontSize: 16,
                          //                                 color: const Color(0xff080f18),
                          //                                 fontWeight: FontWeight.w700,
                          //                               ),
                          // ),
                          SizedBox(
                            height: 5,
                          ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child:Row(
                          children:[
                            SizedBox(
                              height: 3,
                            ),
                          // Icon(
                          //         Icons.access_time,
                          //         color: Colors.grey,
                          //         size: 12.0,
                          //       ),
                          //    SizedBox(
                          //      width: 10,
                          //    ),
                             Text(
                             formattedDate,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ]
                        ),
                      )
                          // SizedBox(
                          //   height: 5,
                          // ),
                          // Row(
                          //   children: <Widget>[
                          //     Text(_news_model.description),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
            //       Column(
            //         children: <Widget>[
            //           IconButton(
            //             icon: const Icon(Icons.share,size: 20.0,),
            //             color: Colors.grey,
            //             onPressed: () {
            //               _onShareLink(context);
            //             },
            //           ),
            //       SizedBox(
            //         width: 5,
            //       ),
            //       // Icon(
            //       //   Icons.keyboard_arrow_right,
            //       //   color: Colors.grey,
            //       //   size: 30.0,
            //       // ),
            //   ],
            // ),
                ],
              ),
            ),
            //cartItems(items.image,_items.issues,_items.price),
            // _checkoutSection()
          ],
        ),);
    }
    // return Container(
    //     padding: EdgeInsets.all(2),
    //     height: 140,
    //     child: Card(
    //       elevation: 5,
    //       child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: <Widget>[
    //             Image.network(
    //               this.item.better_featured_image.source_url,
    //               width: 200,
    //             ),
    //             Expanded(
    //                 child: Container(
    //                     padding: EdgeInsets.all(5),
    //                     child: Column(
    //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                       children: <Widget>[
    //                         //Text(this.item.title.rendered,
    //                             //style: TextStyle(fontWeight: FontWeight.bold)),
    //                         Text("id:${this.item.id}"),
    //                         //Text("title:${this.item.title.rendered}"),
    //                       ],
    //                     )))
    //           ]),
    //     ));
  }
  Widget checkImage(BuildContext context,String image,String title, String content) {

    if(image == 'NOIMG')
    {
      return Container(
        width: 100,
        height: 90,
        decoration: BoxDecoration(color: Colors.white,
            image: DecorationImage(
              //image: NetworkImage(_news_model.better_featured_image.source_url,),
              image: AssetImage(
                  'images/kalinga-tv-channel-logo.jpg'),
              fit:BoxFit.fill,
            )),
      );
    }
    else{
      return Container(
        width: 100,
        height: 90,
        decoration: BoxDecoration(color: Colors.white,
            image: DecorationImage(
              //image: NetworkImage(_news_model.better_featured_image.source_url,),
              image: NetworkImage(image),
              fit:BoxFit.fill,
            )),
      );
    }
  }
  _onShareLink(BuildContext context) async {
    await Share.share(item.link);
        }

        Widget getHtml(String data)
        {
          if(data.length<=100)
            {
              return new Html(
                data: data,
                style: {
                  // p tag with text_size
                  "strong": Style(
                    fontSize: FontSize(18),fontWeight: FontWeight.w700,fontFamily: 'Roboto',color: Colors.black
                  ),
                },
                // defaultTextStyle: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w500,fontFamily: 'Roboto',
                //     overflow: TextOverflow.clip),
              );
            }
          else{
            return new Html(
              data: data.substring(0, 100)+'..',
              style: {
                // p tag with text_size
                "strong": Style(
                  fontSize: FontSize(18),fontWeight: FontWeight.w700,fontFamily: 'Roboto',color: Colors.black
                ),
              },
              // defaultTextStyle: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w500,fontFamily: 'Roboto',
              //     overflow: TextOverflow.clip),
            );
          }
        }
}
