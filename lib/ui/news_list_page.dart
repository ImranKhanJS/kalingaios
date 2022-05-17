import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kalingatv4/model/json_model.dart';
import 'package:kalingatv4/services/Services.dart';
import 'package:kalingatv4/ui/CategoryNewsList.dart';

import 'NewsList.dart';

class news_list_page extends StatefulWidget {
  String category,id,index;
  news_list_page(this.index,this.category,this.id) : super();

  @override
  news_list_pageState createState() => news_list_pageState(index,category,id);
}

class news_list_pageState extends State<news_list_page> {
  String category,id,index;
  Color kalinga_color_code = const Color(0xff9b2219);
  news_list_pageState(this.index,this.category,this.id);
   Future<List<json_model>> _futureData;
  //
  StreamController<int> streamController = new StreamController<int>();
  Future<void> _refreshProducts(BuildContext context) async {
    return Services.getDynCatNews(category,id);
  }
  @override
  void initState(){
    _futureData = Services.getDynCatNews(category,id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: RefreshIndicator(
            onRefresh: () => _refreshProducts(context),
            child: FutureBuilder<List<json_model>>(
              future: _futureData,
              //initialData: [],
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                if (snapshot.data == null)
                 return Container(
                   child:Center(
                   child:Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       CircularProgressIndicator(
                         valueColor: new AlwaysStoppedAnimation<Color>(kalinga_color_code),
                       ),
                       SizedBox(
                         height: 10,
                       ),
                       Text('Loading...',
                         style: TextStyle(fontSize: 14,color: kalinga_color_code),
                       )
                     ],
                   )));
                                    //return CategoryNewsList(items: snapshot.data,id:id);
                // print('DATA URL '+id);
                // print('DATA LENGTH '+snapshot.data.length.toString());
                return snapshot.hasData
                    ? CategoryNewsList(index,cat:category,items: snapshot.data,id:id)
                    : Center(child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(kalinga_color_code),
                ));

              },
            )
          ),
        )
    );
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }
}




// import 'dart:async';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:odisha/model/json_model.dart';
// import 'package:odisha/model/news_model.dart';
// import 'package:odisha/services/Services.dart';
// import 'package:odisha/ui/TopNewsOne.dart';
// import 'package:odisha/ui/news_card.dart';
//
// import 'articleDetail.dart';
// import 'news_card2.dart';
//
// class news_list_page extends StatefulWidget {
//   String category,id;
//   news_list_page(this.category,this.id) : super();
//
//   @override
//   GridViewDemoState createState() => GridViewDemoState(id);
// }
//
// class GridViewDemoState extends State<news_list_page> {
//   String category,id;
//   GridViewDemoState(this.id);
//   //
//   StreamController<int> streamController = new StreamController<int>();
//
//   gridview(AsyncSnapshot<List<json_model>> snapshot) {
//     return Padding(
//       padding: EdgeInsets.all(1.0),
//       child: GridView.count(
//         crossAxisCount: 1,
//         childAspectRatio: 3.3,
//         children: snapshot.data.map(
//               (sub_cat) {
//             return GestureDetector(
//               child: GridTile(
//                 child: news_card(context,sub_cat),
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ArticleDetail(sub_cat.better_featured_image.source_url,sub_cat.title.rendered,sub_cat.content.rendered,category),
//                   ),
//                 );
//               },
//             );
//           },
//         ).toList(),
//       ),
//     );
//   }
//   // gridview2(AsyncSnapshot<List<news_model>> snapshot) {
//   //   return Padding(
//   //     padding: EdgeInsets.all(1.0),
//   //     child: GridView.count(
//   //       crossAxisCount: 2,
//   //       childAspectRatio: 2.8,
//   //       children: snapshot.data.map(
//   //             (sub_cat) {
//   //           return GestureDetector(
//   //             child: GridTile(
//   //               child: news_card2(context,sub_cat),
//   //             ),
//   //             onTap: () {
//   //               Navigator.push(
//   //                 context,
//   //                 MaterialPageRoute(
//   //                   builder: (context) => ArticleDetail(sub_cat.id,sub_cat.title,sub_cat.image_url,sub_cat.description),
//   //                 ),
//   //               );
//   //             },
//   //           );
//   //         },
//   //       ).toList(),
//   //     ),
//   //   );
//   // }
//
//   circularProgress() {
//     return Center(
//       child: const CircularProgressIndicator(),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           Container(
//             height:180,
//             width: double.infinity,
//             child:Flexible(
//               child: FutureBuilder<List<json_model>>(
//                 future: Services.getOneNews(id),
//                 builder: (context, snapshot) {
//                   // not setstate here
//                   //
//                   if (snapshot.hasError) {
//                     return Text('Error ${snapshot.error}');
//                   }
//                   if (snapshot.hasData) {
//                     streamController.sink.add(snapshot.data.length);
//                     print('TOP_LENGTH :'+snapshot.data.length.toString());
//                     // gridview
//                     //return TopNewsOne(context,snapshot.data[0].better_featured_image.source_url,snapshot.data[0].title.rendered,snapshot.data[0].content.rendered,category);
//                   }
//
//                   return circularProgress();
//                 },
//               ),
//             ),
//           ),
//           Flexible(
//             child: FutureBuilder<List<json_model>>(
//               future: Services.getNews(id),
//               builder: (context, snapshot) {
//                 // not setstate here
//                 //
//                 if (snapshot.hasError) {
//                   return Text('Error ${snapshot.error}');
//                 }
//                 if (snapshot.hasData) {
//                   streamController.sink.add(snapshot.data.length);
//                   print('LENGTH :'+snapshot.data.length.toString());
//                   // gridview
//                   return gridview(snapshot);
//                 }
//
//                 return circularProgress();
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     streamController.close();
//     super.dispose();
//   }
// }
