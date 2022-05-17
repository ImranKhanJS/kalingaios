import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_social_content_share/flutter_social_content_share.dart';
import 'package:kalingatv4/MyTabs.dart';
import 'package:kalingatv4/model/json_model.dart';
import 'package:kalingatv4/services/Services.dart';
import 'package:share/share.dart';

import 'ArticleDetailsGrid.dart';
import 'article1.dart';
import 'live_video.dart';
import 'news_list_page.dart';

class NotificationArticleDetail extends StatefulWidget {
  // final id;
  String title='',image_url='',description='',id='',date='',link='',author='';
  //ArticleDetail(this.id,this.title,this.image_url,this.description);
  NotificationArticleDetail(this.image_url,this.title,this.date,this.description,this.link,this.author);
  @override
  // _ArticleDetailState createState() => _ArticleDetailState(id,title,image_url,description);
  _ArticleDetailState createState() => _ArticleDetailState(image_url,title,date,description,link,author);
}

class _ArticleDetailState extends State<NotificationArticleDetail> {
  String _platformVersion = 'Unknown';
  //int id;
  String title,image_url,description,link,id,date,author;
  // _ArticleDetailState(this.id,this.title,this.image_url,this.description);
  _ArticleDetailState(this.image_url,this.title,this.date,this.description,this.link,this.author);
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

  shareOnFacebook() async {
    String result = await FlutterSocialContentShare.share(
        type: ShareType.facebookWithoutImage,
        url: link,
        quote: "captions");
    print(result);
  }

  /// SHARE ON INSTAGRAM CALL
  shareOnInstagram() async {
    String result = await FlutterSocialContentShare.share(
        type: ShareType.instagramWithImageUrl, imageUrl:link);
    // imageUrl:
    // "https://post.healthline.com/wp-content/uploads/2020/09/healthy-eating-ingredients-732x549-thumbnail-732x549.jpg");
    print(result);
  }

  /// SHARE ON WHATSAPP CALL
  shareWatsapp() async {
    String result = await FlutterSocialContentShare.shareOnWhatsapp("7682896063", link);
    print(result);
  }
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
                'images/Kalinga-TV-Logo.png',
                fit: BoxFit.contain,
                height: 50,
              ),
              SizedBox(
                width: 50,
              ),
              Align(
                alignment: Alignment.topRight,
                child:IconButton(
                  icon: Icon(
                    Icons.live_tv,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VideoPlayerScreen()),
                    );
                  },
                ),
              ),
            ],

          )
      ),
      body: Container(
        // padding: EdgeInsets.only(top: 5.0),
        alignment: Alignment.center,
        //child: Expanded(
        child: ListView(
          // shrinkWrap: true,
          children: <Widget>[
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
              child: new Html(
                data: title+" | Edited By : "+author.toString(),
                //defaultTextStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,fontFamily: 'Roboto'),
              ),
            ),
            Divider(),
            // Padding(
            //   padding: EdgeInsets.only(bottom: 10.0),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Container(
                  //padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                  child: Text(
                    "Updated : ${date == null ? 'Date Here' : date.replaceAll(RegExp('T'),', ')}",
                    style: new TextStyle(
                      fontSize: 15.0,fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child:Row(
                    children:<Widget>[
                      GestureDetector(
                        child: new Text("+",style: new TextStyle(
                          fontSize: 30.0,fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),),
                        onTap: () {
                          changeFontSizeInc();
                        },
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        child: new Text("-",style: new TextStyle(
                          fontSize: 30.0,fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),),
                        onTap: () {
                          changeFontSizeDec();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
            Divider(),
// Description
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
              child: new Html(
                  data: description,
                  //defaultTextStyle: TextStyle(fontFamily: 'Roboto',fontSize: custFontSize)
              ),
            ),
            // child: Text(
            //     "${removeAllHtmlTags(description) == null ? 'Description of Article' : removeAllHtmlTags(description)}",
            //     style: TextStyle(fontFamily: 'Roboto',fontSize: custFontSize)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.share),
                  color: Colors.grey,
                  onPressed: () {
                    _onShareLink(context);
                  },
                ),
                IconButton(
                  icon: new Image.asset('images/facebook_256px.png'),
                  //color: Colors.grey,
                  onPressed: () {
                    shareOnFacebook();
                  },
                ),
                IconButton(
                  icon: new Image.asset('images/instagram_256px.png'),
                  //color: Colors.grey,
                  onPressed: () {
                    shareOnInstagram();
                  },
                ),
                IconButton(
                  icon: new Image.asset('images/whatsapp_256px.png'),
                  //color: Colors.grey,
                  onPressed: () {
                    shareWatsapp();
                  },
                ),
              ],
            ),
            Divider(),
            // Container(
            //   child: Column(
            //     children: <Widget>[
            //       Text('Related Articles',
            //         style: TextStyle(
            //           fontFamily: 'Roboto',
            //           fontSize: 16,
            //           color: const Color(0xff080f18),
            //           fontWeight: FontWeight.w700,
            //         ),),
            //       Divider(),
            //       SizedBox(
            //         height: 400,
            //         child:FutureBuilder<List<json_model>>(
            //           future: Services.getTopTenNews(id),
            //           builder: (context, snapshot) {
            //             if (snapshot.hasError) print(snapshot.error);
            //             //print('ARTICLE DATA '+snapshot.data[2].title.rendered);
            //             return snapshot.hasData
            //                 ? ArticleDetailsGrid(items: snapshot.data,id:id)
            //                 : Center(child: CircularProgressIndicator());
            //
            //           },
            //         ),
            //       ),
            //     ],),
            // ),
          ],
        ),
      ),
      //),
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
  _onShareLink(BuildContext context) async {
    await Share.share(link);
  }
}
