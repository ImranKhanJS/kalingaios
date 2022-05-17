import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kalingatv4/MyTabs.dart';
import 'package:kalingatv4/model/json_model.dart';
import 'package:kalingatv4/services/Services.dart';

import 'ArticleDetailsGrid.dart';
import 'article1.dart';
import 'news_list_page.dart';

class SearchArticleDetail extends StatefulWidget {
  // final id;
  String title,image_url,description,id;
  //ArticleDetail(this.id,this.title,this.image_url,this.description);
  SearchArticleDetail(this.image_url,this.title,this.description,this.id);
  @override
  // _ArticleDetailState createState() => _ArticleDetailState(id,title,image_url,description);
  _ArticleDetailState createState() => _ArticleDetailState(image_url,title,description,id);
}

class _ArticleDetailState extends State<SearchArticleDetail> {
  //int id;
  String title,image_url,description,link,id;
  // _ArticleDetailState(this.id,this.title,this.image_url,this.description);
  _ArticleDetailState(this.image_url,this.title,this.description,this.id);
  Color kalinga_color_code = const Color(0xff9b2219);
  StreamController<int> streamController = new StreamController<int>();
  // Dynamic Link
  String desc1;
  final myUrl = "http://kalingatv.com";
  double custFontSize = 16;

  void changeFontSizeInc() async{
    setState(() {
      custFontSize+=2;
    });
  }
  void changeFontSizeDec() async{
    setState(() {
      custFontSize-=2;
    });
  }
  circularProgress() {
    return Center(
      child: const CircularProgressIndicator(),
    );
  }
  // gridview(AsyncSnapshot<List<json_model>> snapshot) {
  //   return Padding(
  //     padding: EdgeInsets.all(1.0),
  //     child: GridView.count(
  //       crossAxisCount: 1,
  //       childAspectRatio: 3.3,
  //       children: snapshot.data.map(
  //             (sub_cat) {
  //           return GestureDetector(
  //             child: GridTile(
  //               child: news_card(context,sub_cat),
  //             ),
  //             onTap: () {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => ArticleDetail(sub_cat.better_featured_image.source_url,sub_cat.title.rendered,sub_cat.content.rendered,category),
  //                 ),
  //               );
  //             },
  //           );
  //         },
  //       ).toList(),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          // icon: Icon(Icons.arrow_back, color: Colors.white),
          // onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>AllNews1()),
          ),
        ),
        backgroundColor: kalinga_color_code,
        elevation: 0,
        iconTheme: IconThemeData(color: kalinga_color_code),
        title: Row(
          children: [
            Image.asset(
              'images/kalinga_tv.png',
              fit: BoxFit.contain,
              height: 50,
            ),
          ],

        ),
        //title: Text("KalingaTV"),
        ),
      // body:WebView(
      //   initialUrl: link,
      //   onWebViewCreated: (WebViewController webViewController) {
      //     _controller.complete(webViewController);
      //   },
      // ),
      body: Container(
        // padding: EdgeInsets.only(top: 5.0),
        alignment: Alignment.center,
        child: Expanded(
        child: ListView(
          // shrinkWrap: true,
          children: <Widget>[
            //Back arrow
            // Container(
            //   alignment: Alignment.topLeft,
            //   child: IconButton(
            //     icon: Icon(Icons.arrow_back),
            //     onPressed: () => Navigator.of(context).pop(),
            //   ),
            // ),
            // Image
            Container(
              alignment: Alignment.center,
              // padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: Stack(
                children: <Widget>[
                  Hero(
                    //tag: widget.articles['title'],
                    tag:title,
                    child: FadeInImage.assetNetwork(
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                      height: 280.0,
                      // width: MediaQuery.of(context).size.width,
                      placeholder: 'images/loading.gif',
                      image: image_url == null
                          ? Image.asset(
                              'images/imgPlaceholder.png',
                            ).toString()
                          : image_url,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.0),
            // Title
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
              child: Text(
                "${title == null ? 'Title Here' : title}",
                //style: Theme.of(context).textTheme.headline,
              ),
            ),
             Divider(),
            // Padding(
            //   padding: EdgeInsets.only(bottom: 10.0),
            // ),


               Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    child: new Icon(Icons.font_download_rounded,size: 25, color: Colors.grey,),
                    onTap: () {
                      changeFontSizeInc();
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    child: new Icon(Icons.font_download_rounded,size: 20,color: Colors.grey,),
                    onTap: () {
                      changeFontSizeDec();
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  // new IconButton(
                  //   icon: new Icon(Icons.font_download_rounded,size: 25),
                  //   onPressed: changeFontSizeInc(),
                  // ),
                  // new IconButton(
                  //   icon: new Icon(Icons.font_download_rounded,size: 20),
                  //   onPressed: changeFontSizeDec(),
                  // ),
                ],
              ),
            Divider(),
// Description
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
              child: Text(
                  "${removeAllHtmlTags(description) == null ? 'Description of Article' : removeAllHtmlTags(description)}",
                  style: TextStyle(fontFamily: 'Roboto',fontSize: custFontSize)),
            ),
            Divider(),
            // Center(
            //     child: FutureBuilder<List<json_model>>(
            //       future: Services.getTopTenNews(this.id),
            //       builder: (context, snapshot) {
            //         if (snapshot.hasError) print(snapshot.error);
            //         print('ARTICLE DATA '+snapshot.data[2].title.rendered);
            //         return snapshot.hasData
            //             ? ArticleDetailsGrid(items: snapshot.data)
            //             : Center(child: CircularProgressIndicator());
            //
            //       },
            //     ),
            // )
          ],
        ),
   ),
      ),
    );
  }
  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(
        r"<[^>]*>",
        multiLine: true,
        caseSensitive: true
    );
    return htmlText.replaceAll(exp, '');
  }
}
