import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_social_content_share/flutter_social_content_share.dart';
import 'package:kalingatv4/MyTabs.dart';
import 'package:kalingatv4/model/Categories.dart';
import 'package:kalingatv4/model/json_model.dart';
import 'package:kalingatv4/services/Services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:share/share.dart';
import 'package:http/http.dart' as http;
import '../model/categories_link_model.dart';
import 'ArticleDetailsGrid.dart';
import 'article1.dart';
import 'live_video.dart';
import 'package:google_fonts/google_fonts.dart';
import 'news_list_page.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:social_share/social_share.dart';
class ArticleDetail extends StatefulWidget {
  // final id;
  String title='',image_url='',description='',id='',date='',link='',author='',cat='',credit='NC',index;
  //ArticleDetail(this.id,this.title,this.image_url,this.description);
  ArticleDetail(this.index,this.cat,this.image_url,this.title,this.date,this.description,this.link,this.author,this.id,this.credit);
  @override
  // _ArticleDetailState createState() => _ArticleDetailState(id,title,image_url,description);
  _ArticleDetailState createState() => _ArticleDetailState(index,cat,image_url,title,date,description,link,author,id,credit);
}

class _ArticleDetailState extends State<ArticleDetail>  with SingleTickerProviderStateMixin{
  String _platformVersion = 'Unknown';
  //int id;
  String title,image_url,description,link,id,date,author,cat,credit,index;
  // _ArticleDetailState(this.id,this.title,this.image_url,this.description);
  _ArticleDetailState(this.index,this.cat,this.image_url,this.title,this.date,this.description,this.link,this.author,this.id,this.credit);
  Color kalinga_color_code = const Color(0xff9b2219);
  StreamController<int> streamController = new StreamController<int>();
  // Dynamic Link
   String desc1;
  final myUrl = "http://kalingatv.com";
  double custFontSize = 16;
  int _selectedPage;
  List<categories_link_model> _postTopNews =new List<categories_link_model>();
  @override
  void initState() {
    super.initState();
    _selectedPage = int.parse(index);
    //_getTopNews();
    _getLink();
    initPlatformState();
    // _tabController = new TabController(vsync: this, length: _postList.length);
    this.checkDataConnectivity();
  }
  Future<void> initPlatformState() async {
    String platformVersion;

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }
  Future<void> checkDataConnectivity() async {
    var result = await DataConnectionChecker().hasConnection;
    if (result == true) {
      print("Connected");
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "No Internet",
        desc:
        "You are Offline.No Internet Conncection Please Connect To A Network!",
        style: AlertStyle(
          animationType: AnimationType.fromTop,
          titleStyle: TextStyle(
            color: kalinga_color_code,
            fontWeight: FontWeight.w900,
            fontSize: 30.0,
          ),
          descStyle: TextStyle(color: Colors.white, fontSize: 15.0),
        ),
        buttons: [
          DialogButton(
              color: Colors.grey,
              child: Text(
                "OK",
                style: TextStyle(fontSize: 20),
              ),
              width: 120,
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ).show();
    }
  }
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
String _parseHtmlString(String htmlString)
{
  final document=htmlparser.parse(htmlString);
  final String parsedString=htmlparser.parse(document.body.text).documentElement.text;
  return parsedString;
}
  /// SHARE ON INSTAGRAM CALL
  shareOnInstagram() async {
    String result = await FlutterSocialContentShare.share(
        type: ShareType.instagramWithImageUrl, imageUrl:image_url);
        // imageUrl:
        // "https://post.healthline.com/wp-content/uploads/2020/09/healthy-eating-ingredients-732x549-thumbnail-732x549.jpg");
    print(result);
  }

  /// SHARE ON WHATSAPP CALL
  shareWatsapp() async {
    String result = await FlutterSocialContentShare.shareOnWhatsapp("7682896063", link);
    print(result);
  }
  Future<List<categories_link_model>> _getTopNews() async {
    var data = await http.get(Uri.parse("https://kalingatv.com/wp-admin/category/link/ktv_category.json"));
    //var data = await http.get(Uri.parse('http://intentitsolutions.com/P365TECH/api/getAllSubcategory.php?id=87'));
    //var data = await http.get(Uri.parse("https://kalingatv.com/wp-json/wp/v2/categories?per_page=100&_embed"));
    if (data.statusCode == 200) {
      //print('SUBCAT :'+data.body.toString());
      setState(() {
        _postTopNews = parseTopNews(data.body);
        //_tabController = new TabController(vsync: this, length: _postList.length);
        //print('News Data :'+data.body.toString());
        // tabController =
        //     TabController(length: _postList.length??'', vsync: this, initialIndex: 0);
        //print('CONTROLLER '+tabController.length.toString());
        // clength=_postList.length??'';
      }
      );
      //print('CL '+_postList.length.toString()+' SCAT :'+_postList[1].subcategory);
      return _postTopNews;
      //return list;
    } else {
      throw Exception("Error");
    }
    //print('CL :'+clength.toString());
  }
  static List<categories_link_model> parseTopNews(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<categories_link_model>((json) => categories_link_model.fromJson(json)).toList();
  }
  List<categories_link_model> _postList =new List<categories_link_model>();
  TabController _tabController;
  Future<List<categories_link_model>> _getLink() async {
    var data = await http.get(Uri.parse("https://kalingatv.com/wp-admin/category/link/tab_category.json"));
    //var data = await http.get(Uri.parse('http://intentitsolutions.com/P365TECH/api/getAllSubcategory.php?id=87'));
    //var data = await http.get(Uri.parse("https://kalingatv.com/wp-json/wp/v2/categories?per_page=100&_embed"));
    if (data.statusCode == 200) {
      //print('SUBCAT :'+data.body.toString());
      setState(() {
        _postList = parseCategory(data.body);
        // for(int i=0; i<_postList.length; i++)
        //   {
        //     if(_postList[i].name=='Videos')
        //     {
        //       _postList[i].link='YoutubeHomeScreen()';
        //     }
        // if(_postList[i].name=='Education')
        // {
        //   _postList.removeAt(i);
        // }
        // if(_postList[i].name=='Uncategorized')
        // {
        //   _postList.removeAt(i);
        // }
        // if(_postList[i].name=='Founder')
        // {
        //   _postList.removeAt(i);
        // }
        //}
        _tabController = TabController(
          length: _postList.length,
          vsync: this,
          initialIndex: _selectedPage,
        );
        // _tabController.addListener(() {
        //   setState(() {
        //     _selectedPage = _tabController.index;
        //     //_tabIndex = _tabController.index;
        //   });
        // });
       // var _scrollViewController = ScrollController();
       //
       //  // Scrolling view to top when a new tab is selected
       //  _tabController.addListener(() {
       //    setState(() {
       //      _scrollViewController
       //          .jumpTo(_scrollViewController.position.minScrollExtent);
       //    });
       //  });
       // _tabController = new TabController(vsync: this, length: _postList.length);
        //print('News Data :'+data.body.toString());
        // tabController =
        //     TabController(length: _postList.length??'', vsync: this, initialIndex: 0);
        //print('CONTROLLER '+tabController.length.toString());
        // clength=_postList.length??'';
      });
      //print('CL '+_postList.length.toString()+' SCAT :'+_postList[1].subcategory);
      return _postList;
      //return list;
    } else {
      throw Exception("Error");
    }
    //print('CL :'+clength.toString());
  }
  static List<categories_link_model> parseCategory(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<categories_link_model>((json) => categories_link_model.fromJson(json)).toList();
  }
  // String removeAllHtmlTags(String htmlText) {
  //   RegExp exp = RegExp(
  //       r"<[^>]*>",
  //       multiLine: true,
  //       caseSensitive: true
  //   );
  //
  //   return htmlText.replaceAll(exp, '');
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child: Icon(Icons.arrow_back),
        backgroundColor: kalinga_color_code,
        onPressed: () {
          Navigator.pop(context);
          //Navigator.push(context, MaterialPageRoute(builder: (context)=>AllNews1()));
          // setState(() {
          //   i++;
          // });
        },
      ),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // leading: IconButton(
        //   // icon: Icon(Icons.arrow_back, color: Colors.white),
        //   // onPressed: () => Navigator.of(context).pop(),
        //   icon: Icon(Icons.arrow_back, color: Colors.white),
        //   onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>AllNews1()),
        //   ),
        // ),
          title: Row(
        children: [
              GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AllNews1()));
      },
          child:Container(
          child:Image.asset(
            'images/latest_ktv_header_logo2.jpeg',
            fit: BoxFit.contain,
            height: 40,
          ),),),
          SizedBox(
            width: 10,
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

      ),
        actions: [
          GestureDetector(
            onTap: () {
              changeFontSizeInc();
            },
      child:Center(
            child: new Text("A",style: new TextStyle(
              fontSize: 20,fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
              textAlign: TextAlign.center,
            ),

          ),),
          SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: () {
              changeFontSizeDec();
            },
    child:Center(
            child: new Text("A",style: new TextStyle(
              fontSize: 15,fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
              textAlign: TextAlign.center,
            ),
          ),),
          SizedBox(
            width: 20,
          ),
          // Container(
          //   //alignment: Alignment.centerRight,
          //   child:Row(
          //     children:<Widget>[
          //
          //     ],
          //   ),
          // ),
        ],
        backgroundColor: kalinga_color_code,
        elevation: 0,
        iconTheme: IconThemeData(color: kalinga_color_code),
          // title: Row(
          //   children: [
          //     Image.asset(
          //       'images/Kalinga-TV-Logo.png',
          //       fit: BoxFit.contain,
          //       height: 50,
          //     ),
          //     SizedBox(
          //       width: 50,
          //     ),
          // Align(
          //         alignment: Alignment.topRight,
          //  child:IconButton(
          //     icon: Icon(
          //       Icons.live_tv,
          //       color: Colors.white,
          //     ),
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => VideoPlayerScreen()),
          //       );
          //     },
          //   ),
          //       ),
          //   ],
          //
          // )
        ),
      body: Container(
        // padding: EdgeInsets.only(top: 5.0),
        alignment: Alignment.center,
        //child: Expanded(
        child: ListView(
          // shrinkWrap: true,
          children: <Widget>[
            DefaultTabController(
                length: _postList.length, // length of tabs
                initialIndex: _selectedPage,
                child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                  Container(
                    color: Colors.black,
                    child: TabBar(
                      onTap: (index){
                        _tabController.index = _tabController.previousIndex;
                        Navigator.pop(context);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => AllNews1(),
                        //   ),
                        // );
                      },
                      //labelPadding: EdgeInsets.only(top:5,bottom: 5),
                      isScrollable: true,
                      labelPadding: EdgeInsets.zero,
                      controller: _tabController,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Colors.amberAccent,
                      // indicator: BoxDecoration(
                      //   shape: BoxShape.rectangle,
                      //   borderRadius: BorderRadius.circular(0),
                      //   color: kalinga_color_code,
                      //   border: Border.all(
                      //     width: 1,
                      //     color: Colors.white,
                      //   ),
                      // ),
                      tabs: List<Widget>.generate(_postList.length??CircularProgressIndicator(), (int index) {
                        // setState(() {
                        //   _postList[0].name=_postTopNews[0].name??'No Name';
                        //   _postList[0].link=_postTopNews[0].link??'No Link';
                        //   //this.cat_id=_postList[index].category??'';
                        //   //print('CAT_ID '+cat_id);
                        // });
                        return new Tab(
                            child:Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(_postList[index].name??'',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500, fontSize: 15.0))));
                      }),

                    ),
                    // new TabBar(
                    //   isScrollable: true,
                    //   controller: _tabController,
                    //   tabs: myTabs,
                    // ),
                  ),
                ])
            ),
            SizedBox(height: 20.0),
        Container(
             padding: EdgeInsets.symmetric(horizontal: 18.0),
            child:Text(title,
              style:GoogleFonts.libreBaskerville(fontSize: 18,fontWeight: FontWeight.w700,),

          //style:TextStyle(fontSize: 18,fontWeight: FontWeight.w500,fontFamily: 'Roboto'),
            ),
        ),

            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 18.0),
            //   child: new Html(
            //     data: title,
            //     style:{
            //       "h1": Style(fontFamily: 'serif',
            //         backgroundColor: Colors.black,
            //         color: Colors.white,),
            //       //'p': Style(fontSize: FontSize(26),fontWeight: FontWeight.bold,maxLines: 3, textOverflow: TextOverflow.ellipsis),
            //     }
            //     //defaultTextStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,fontFamily: 'Roboto'),
            //   ),
            // ),
            SizedBox(height: 5.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child:Row(
                  children:[
                    // Icon(
                    //   Icons.access_time,
                    //   color: Colors.grey,
                    //   size: 15.0,
                    // ),
                    // SizedBox(
                    //   width: 10,
                    // ),
                    Text(
                      date,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ]
              ),
            ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
            //   child: Text(
            //     "${date == null ? 'Date Here' : date.replaceAll(RegExp('T'),', ')}",
            //     style: new TextStyle(
            //       fontSize: 15.0,fontWeight: FontWeight.bold,
            //       color: Colors.grey,
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),
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
            //SizedBox(height: 5.0),
            // Title
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 18.0),
            //   child: new Html(
            //     data: title+" | Edited By : "+author.toString(),
            //     defaultTextStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,fontFamily: 'Roboto'),
            //   ),
            // ),
            //  Divider(),
            // Padding(
            //   padding: EdgeInsets.only(bottom: 10.0),
            // ),
               Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // SizedBox(
                  //   width: 10,
                  // ),
                  // Container(
                  //   //padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                  //   child: Text(
                  //     "Updated : ${date == null ? 'Date Here' : date.replaceAll(RegExp('T'),', ')}",
                  //     style: new TextStyle(
                  //       fontSize: 15.0,fontWeight: FontWeight.bold,
                  //       color: Colors.grey,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    width: 10,
                  ),
        //           Container(
        //             alignment: Alignment.centerRight,
        //           child:Row(
        //             children:<Widget>[
        //           GestureDetector(
        //             child: new Text("+",style: new TextStyle(
        //               fontSize: 30.0,fontWeight: FontWeight.bold,
        //               color: Colors.grey,
        //             ),),
        //             onTap: () {
        //               changeFontSizeInc();
        //             },
        //           ),
        //           SizedBox(
        //             width: 20,
        //           ),
        //           GestureDetector(
        //             child: new Text("-",style: new TextStyle(
        //               fontSize: 30.0,fontWeight: FontWeight.bold,
        //               color: Colors.grey,
        //             ),),
        //             onTap: () {
        //               changeFontSizeDec();
        //             },
        //           ),
        // ],
        //           ),
        //           ),
        //           SizedBox(
        //             width: 20,
        //           ),
                ],
              ),
            Divider(),
// Description
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
//               child: new Text(_parseHtmlString(description),
//                   style: TextStyle(fontFamily: 'Roboto',fontSize: custFontSize)),
//             ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: new Html(
                  data: description,
                style: {
                  // p tag with text_size
                  "p": Style(
                    fontSize: FontSize(custFontSize),fontFamily: 'librefranklin'
                  ),
                  "strong": Style(
                    fontSize: FontSize(custFontSize),
                  ),
                },
                  //defaultTextStyle: TextStyle(fontFamily: 'Roboto',fontSize: custFontSize)
              ),
            ),
              // child: Text(
              //     "${removeAllHtmlTags(description) == null ? 'Description of Article' : removeAllHtmlTags(description)}",
              //     style: TextStyle(fontFamily: 'Roboto',fontSize: custFontSize)),
          Row(
            //mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 40,
                  width: 40,
                  //scale: 0.8,
                child:IconButton(
                  icon: new Image.asset('images/facebook_256px.png'),
                  //color: Colors.grey,
                  onPressed: ()  async {
                    // SocialShare.shareFacebookStory(image_url,"#ffffff","#000000",
                    //     link,
                    //     appId: "362951925798454");

                    // Platform.isAndroid
                    //     ? SocialShare.shareFacebookStory(
                    //   image_url,
                    //   "#ffffff",
                    //   "#000000",
                    //   link,
                    //   appId: "362951925798454",
                    // ).then((data) {
                    //   print(data);
                    // })
                    //     : SocialShare.shareFacebookStory(
                    //   image_url,
                    //   "#ffffff",
                    //   "#000000",
                    //   link,
                    // ).then((data) {
                    //   print(data);
                    // });
                    // Platform.isAndroid
                    //     ? SocialShare.shareFacebookStory(
                    //   image_url,
                    //   "#ffffff",
                    //   "#000000",
                    //   "https://google.com",
                    //   appId: "362951925798454",
                    // ).then((data) {
                    //   print(data);
                    // })
                    shareOnFacebook();
                  },
                ),),
                Container(
                  height: 40,
                  width: 40,
                child:IconButton(
                  icon: new Image.asset('images/twitter_icon.png'),
                  //color: Colors.grey,
                  onPressed: () {
                    SocialShare.shareTwitter(
                        title,
                        url:link);
                  },
                ),),
                Container(
                  height: 40,
                  width: 40,
                child:IconButton(
                  icon: new Image.asset('images/instagram_256px.png'),
                  //color: Colors.grey,
                  onPressed: () {
                    //SocialShare.shareInstagramStory(link);
                   //SocialShare.shareInstagramStory(link??'');
                    //shareOnInstagram();
                    FlutterSocialContentShare.share(
                        type: ShareType.instagramWithImageUrl,
                        quote: title,
                        url: link,
                        imageUrl:image_url
                        );
                  },
                ),),
                Container(
                  height: 40,
                  width: 40,
                child:IconButton(
                  icon: new Image.asset('images/whatsapp_256px.png'),
                  //color: Colors.grey,
                  onPressed: () {
                    SocialShare.shareWhatsapp(link);
                    //shareWatsapp();
                  },
                ),),
                Container(
                  height: 40,
                  width: 40,
                child:IconButton(
                  icon: const Icon(Icons.share),
                  color: Colors.grey,
                  onPressed: () {
                    SocialShare.shareOptions(link);
                    //_onShareLink(context);
                  },
                ),),
      ],
          ),
            Divider(),
            Container(
              child: Column(
                  children: <Widget>[
            Text('Related Articles',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                color: const Color(0xff080f18),
                fontWeight: FontWeight.w700,
              ),),
                    Divider(),
              SizedBox(
                height: 400,
                child:Container(
                  padding: EdgeInsets.only(top: 20.0),
                  decoration: BoxDecoration(
                    border:Border.all(
                      color: Colors.grey[350], //                   <--- border color
                      width: 2.0,
                    )
                  ),
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                child:FutureBuilder<List<json_model>>(
                      future: Services.getRelatedNews(cat,id),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) print(snapshot.error);
                        //print('ARTICLE DATA '+snapshot.data[2].title.rendered);
                        return snapshot.hasData
                            ? ArticleDetailsGrid(index:index,cat:cat,items: snapshot.data,id:id)
                            : Center(child: CircularProgressIndicator());

                      },
                    ),),
              ),
                    SizedBox(
                      height: 10,
                    )
              ],),
            ),
          ],
        ),
   ),
      //),
    );
  }
  // String removeAllHtmlTags(String htmlText) {
  //   RegExp exp = RegExp(
  //       r"<[^>]*>",
  //       multiLine: true,
  //       caseSensitive: true
  //   );
  //   return htmlText.replaceAll(exp, '');
  // }
  _onShareLink(BuildContext context) async {
    await Share.share(link);
  }
}
