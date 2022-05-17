import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kalingatv4/model/json_model.dart';
import 'package:kalingatv4/model/news_model.dart';
import 'package:kalingatv4/services/Services.dart';
import 'package:kalingatv4/ui/news_card.dart';

import 'SearcharticleDetail.dart';
import 'articleDetail.dart';
import 'news_card2.dart';

class SearchPage extends StatefulWidget {
  String category,id;
  SearchPage() : super();

  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  String category,id;
  String search="Achuta Samanta";
  _SearchPage();
  //
  final TextEditingController searchController = TextEditingController();
  StreamController<int> streamController = new StreamController<int>();
  Color kalinga_color_code = const Color(0xff9b2219);
  gridview(AsyncSnapshot<List<json_model>> snapshot) {
    return Padding(
      padding: EdgeInsets.all(1.0),
      child: GridView.count(
        crossAxisCount: 1,
        childAspectRatio: 3.3,
        children: snapshot.data.map(
              (sub_cat) {
            return GestureDetector(
              child: GridTile(
                child: news_card(context,sub_cat),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchArticleDetail(sub_cat.better_featured_image,sub_cat.title.rendered,sub_cat.content.rendered,category),
                  ),
                );
              },
            );
          },
        ).toList(),
      ),
    );
  }
  // gridview2(AsyncSnapshot<List<news_model>> snapshot) {
  //   return Padding(
  //     padding: EdgeInsets.all(1.0),
  //     child: GridView.count(
  //       crossAxisCount: 2,
  //       childAspectRatio: 2.8,
  //       children: snapshot.data.map(
  //             (sub_cat) {
  //           return GestureDetector(
  //             child: GridTile(
  //               child: news_card2(context,sub_cat),
  //             ),
  //             onTap: () {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => ArticleDetail(sub_cat.id,sub_cat.title,sub_cat.image_url,sub_cat.description),
  //                 ),
  //               );
  //             },
  //           );
  //         },
  //       ).toList(),
  //     ),
  //   );
  // }

  circularProgress() {
    return Center(
      child: const CircularProgressIndicator(
        //valueColor: new AlwaysStoppedAnimation<Color>(kalinga_color_code),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back, color: Colors.white),
      //     onPressed: () => Navigator.of(context).pop(),
      //   ),
      //   backgroundColor: kalinga_color_code,
      //   elevation: 0,
      //   iconTheme: IconThemeData(color: kalinga_color_code),
      //  // title:
      //   //title: Text("KalingaTV"),
      //   //centerTitle: true,
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
              height: 20,
          ),
      Container(
        color:kalinga_color_code,
          child:Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              Center(
                  child : Container(
                      width: 300,
                      height: 60,
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        textInputAction: TextInputAction.go,
                        style: TextStyle(color: Colors.black, fontSize: 20,),
                        controller: searchController,
                        autocorrect: true,
                        decoration: InputDecoration(
                          hintText: 'Search Here...',
                          contentPadding: const EdgeInsets.all(10),
                          suffixIcon: IconButton(icon: Icon(Icons.search_rounded),
                            onPressed: () {
                              setState(() { search = searchController.text; });
                              searchController.clear();
                              FocusScope.of(context).requestFocus(FocusNode());
                              print(search);
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => SearchPage(search)),
                              // );
                            },),
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white70,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                            borderSide: BorderSide(color: kalinga_color_code, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: kalinga_color_code, width: 2),
                          ),
                        ),
                      )
                  )),
            ],

          ),
      ),
          Search()
        ],
      ),
    );
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  Widget Search()
  {
    // if(search=="nodata")
    //   {
    //    return Container(
    //      child: Text("")
    //     );
    //   }
    //else {
     return Flexible(
        child: FutureBuilder<List<json_model>>(
          future: Services.getSearchNews(search),
          builder: (context, snapshot) {
            // not setstate here
            //
            if (snapshot.hasError) {
              // return Text('Error ${snapshot.error}');
              //return Text('No Data Found !');
              return Center(child: Text('No Data Found !'));
            }
            if (snapshot.hasData) {
              streamController.sink.add(snapshot.data.length);
              print('LENGTH :' + snapshot.data.length.toString());
              // gridview
              return gridview(snapshot);
            }

            return Center(child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(kalinga_color_code),
            ));
          },
        ),
      );
    }
  }
//}




// import 'dart:async';
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:http/http.dart' as http;
// import 'package:odisha/model/json_model.dart';
// import 'package:odisha/services/Services.dart';
//
// import 'article1.dart';
// import 'news_card.dart';
// //import http package manually
//
// class SearchPage extends StatefulWidget{
//   @override
//   State createState() {
//     return _SearchPage();
//   }
// }
//
// class _SearchPage extends State{
//   StreamController<int> streamController = new StreamController<int>();
//   bool searching, error;
//   var data;
//   String query;
//   Color kalinga_color_code = const Color(0xff9b2219);
//   String dataurl = "https://kalingatv.com/wp-json/wp/v2/posts?search=naveen";
//   // do not use http://localhost/ , Android emulator do not recognize localhost
//   // insted use your local ip address or your live URL
//   // hit "ipconfig" on Windows or "ip a" on Linux to get IP Address
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
//                     // builder: (context) => ArticleDetail(sub_cat.id,sub_cat.title,sub_cat.image_url,sub_cat.description),
//                   ),
//                 );
//               },
//             );
//           },
//         ).toList(),
//       ),
//     );
//   }
//   @override
//   void initState() {
//     searching = false;
//     error = false;
//     query = "";
//     super.initState();
//   }
//
//   void getSuggestion() async{  //get suggestion function
//     var res = await http.post(dataurl + "?query=" + Uri.encodeComponent(query));
//     //in query there might be unwant character so, we encode the query to url
//     if (res.statusCode == 200) {
//       setState(() {
//         data = json.decode(res.body);
//         print("DATA SEARCH "+data);
//         //update data value and UI
//       });
//     }else{
//       //there is error
//       setState(() {
//         error = true;
//       });
//     }
//   }
//   circularProgress() {
//     return Center(
//       child: const CircularProgressIndicator(),
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           leading: searching?IconButton(
//             icon:Icon(Icons.arrow_back),
//             onPressed:(){
//               setState(() {
//                 searching = false;
//                 //set not searching on back button press
//               });
//             },
//           ):IconButton(
//               icon: Icon(Icons.arrow_back),
//               onPressed:(){
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => AllNews1()),
//                 );
//               }
//           ), //,
//           //if searching is true then show arrow back else play arrow
//           title:searching?searchField():Text("Kalinga TV"),
//           actions: [
//             IconButton(
//                 icon: Icon(Icons.search),
//                 onPressed:(){
//                   setState(() {
//                     searching = true;
//                   });
//                 }
//             ), // search icon button
//
//             //add more icons here
//           ],
//           backgroundColor: searching?kalinga_color_code:kalinga_color_code,
//           //if searching set background to orange, else set to deep orange
//         ),
//
//         body:SingleChildScrollView(
//             child:Container(
//                 alignment: Alignment.center,
//                 child:data == null?
//                 Container(
//                     padding: EdgeInsets.all(20),
//                     child: searching?Text("Please wait")
//                         :Text("Search any News")
//                   //if is searching then show "Please wait"
//                   //else show search peopels text
//                 ):
//                 Container(
//                   child: searching?showSearchSuggestions()
//                       :Text("Find any News"),
//                 )
//               // if data is null or not retrived then
//               // show message, else show suggestion
//             )
//         )
//     );
//   }
//
//   Widget showSearchSuggestions(){
//     Flexible(
//       child: FutureBuilder<List<json_model>>(
//         future: Services.getSearchNews(query),
//         builder: (context, snapshot) {
//           // not setstate here
//           //
//           if (snapshot.hasError) {
//             return Text('Error ${snapshot.error}');
//           }
//           if (snapshot.hasData) {
//             streamController.sink.add(snapshot.data.length);
//             print('SEARCH LENGTH :'+snapshot.data.length.toString());
//             // gridview
//             return gridview(snapshot);
//           }
//           return circularProgress();
//
//         },
//       ),
//     );
//     // List suggestionlist = List.from(
//     //     data["data"].map((i){
//     //       return SearchSuggestion.fromJSON(i);
//     //     })
//     // );
//     // //serilizing json data inside model list.
//     // return Column(
//     //   children:suggestionlist.map((suggestion){
//     //     return InkResponse(
//     //         onTap: (){
//     //           //when tapped on suggestion
//     //           print(suggestion.id); //pint student id
//     //         },
//     //         child: SizedBox(
//     //             width:double.infinity, //make 100% width
//     //             child:Card(
//     //               child: Container(
//     //                 padding: EdgeInsets.all(15),
//     //                 child: Text(suggestion.name, style: TextStyle(
//     //                   fontSize:20, fontWeight:FontWeight.bold,
//     //                 ),),
//     //               ),
//     //             )
//     //         )
//     //     );
//     //   }).toList(),
//     // );
//     return circularProgress();
//   }
//
//   Widget searchField(){ //search input field
//     return Container(
//         child:TextField(
//           autofocus: true,
//           style: TextStyle(color:Colors.white, fontSize: 18),
//           decoration:InputDecoration(
//             hintStyle: TextStyle(color:Colors.grey[100], fontSize: 18),
//             hintText: "Search News",
//             enabledBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color:Colors.white, width:2),
//             ),//under line border, set OutlineInputBorder() for all side border
//             focusedBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color:Colors.white, width:2),
//             ), // focused border color
//           ), //decoration for search input field
//           onChanged: (value){
//             query = value; //update the value of query
//             getSuggestion(); //start to get suggestion
//           },
//         )
//     );
//   }
// }
//
//
// class SearchSuggestion{
//   String id, name;
//   SearchSuggestion({this.id, this.name});
//
//   factory SearchSuggestion.fromJSON(Map<String, dynamic> json){
//     return SearchSuggestion(
//       id: json["id"],
//       name: json["name"],
//     );
//   }
// }

// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:http/http.dart' as http;
//
// import 'article1.dart';
// //import http package manually
//
// class SearchPage extends StatefulWidget{
//   @override
//   State createState() {
//     return _SearchPage();
//   }
// }
//
// class _SearchPage extends State{
//   bool searching, error;
//   var data;
//   String query;
//   Color kalinga_color_code = const Color(0xff9b2219);
//   String dataurl = "https://kalingatv.com/wp-json/wp/v2/posts";
//   // do not use http://localhost/ , Android emulator do not recognize localhost
//   // insted use your local ip address or your live URL
//   // hit "ipconfig" on Windows or "ip a" on Linux to get IP Address
//
//   @override
//   void initState() {
//     searching = false;
//     error = false;
//     query = "";
//     super.initState();
//   }
//
//   void getSuggestion() async{  //get suggestion function
//     var res = await http.post(dataurl + "?search=" + Uri.encodeComponent(query));
//     //in query there might be unwant character so, we encode the query to url
//     if (res.statusCode == 200) {
//       setState(() {
//         data = json.decode(res.body);
//         print("DATA SERACH "+data);
//         //update data value and UI
//       });
//     }else{
//       //there is error
//       setState(() {
//         error = true;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           leading: searching?IconButton(
//             icon:Icon(Icons.arrow_back),
//             onPressed:(){
//               setState(() {
//                 searching = false;
//                 //set not searching on back button press
//               });
//             },
//           ):IconButton(
//               icon: Icon(Icons.arrow_back),
//               onPressed:(){
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => AllNews1()),
//                 );
//               }
//           ), //,
//           //if searching is true then show arrow back else play arrow
//           title:searching?searchField():Text("Kalinga TV"),
//           actions: [
//             IconButton(
//                 icon: Icon(Icons.search),
//                 onPressed:(){
//                   setState(() {
//                     searching = true;
//                   });
//                 }
//             ), // search icon button
//
//             //add more icons here
//           ],
//           backgroundColor: searching?kalinga_color_code:kalinga_color_code,
//           //if searching set background to orange, else set to deep orange
//         ),
//
//         body:SingleChildScrollView(
//             child:Container(
//                 alignment: Alignment.center,
//                 child:data == null?
//                 Container(
//                     padding: EdgeInsets.all(20),
//                     child: searching?Text("Please wait")
//                         :Text("Search any News")
//                   //if is searching then show "Please wait"
//                   //else show search peopels text
//                 ):
//                 Container(
//                   child: searching?showSearchSuggestions()
//                       :Text("Find any News"),
//                 )
//               // if data is null or not retrived then
//               // show message, else show suggestion
//             )
//         )
//     );
//   }
//
//   Widget showSearchSuggestions(){
//     List suggestionlist = List.from(
//         data.map((i){
//           return json_model.fromJson(i);
//         })
//     );
//     //serilizing json data inside model list.
//     return Column(
//       children:suggestionlist.map((suggestion){
//         return InkResponse(
//             onTap: (){
//               //when tapped on suggestion
//               print(suggestion.id); //pint student id
//             },
//             child: SizedBox(
//                 width:double.infinity, //make 100% width
//                 child:Card(
//                   child: Container(
//                     padding: EdgeInsets.all(15),
//                     child: Text(suggestion.id, style: TextStyle(
//                       fontSize:20, fontWeight:FontWeight.bold,
//                     ),),
//                   ),
//                 )
//             )
//         );
//       }).toList(),
//     );
//   }
//
//   Widget searchField(){ //search input field
//     return Container(
//         child:TextField(
//           autofocus: true,
//           style: TextStyle(color:Colors.white, fontSize: 18),
//           decoration:InputDecoration(
//             hintStyle: TextStyle(color:Colors.white, fontSize: 18),
//             hintText: "Search News",
//             enabledBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color:Colors.white, width:2),
//             ),//under line border, set OutlineInputBorder() for all side border
//             focusedBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color:Colors.white, width:2),
//             ), // focused border color
//           ), //decoration for search input field
//           onChanged: (value){
//             query = value; //update the value of query
//             getSuggestion(); //start to get suggestion
//           },
//         )
//     );
//   }
// }
//
//
// //serarch suggestion data model to serialize JSON data
// class SearchSuggestion{
//   String id, name;
//   SearchSuggestion({this.id, this.name});
//
//   factory SearchSuggestion.fromJSON(Map<String, dynamic> json){
//     return SearchSuggestion(
//       id: json["id"],
//       name: json["name"],
//     );
//   }
// }

// class json_model{
//   int id;
//   String date;
//   String modified;
//   String status;
//   Title title;
//   Content content;
//   Better_featured_image better_featured_image;
//
//   json_model({
//     this.id,
//     this.date,
//     this.modified,
//     this.status,
//     this.title,
//     this.content,
//     this.better_featured_image
//   });
//
//   factory json_model.fromJson(Map<String, dynamic> parsedJson){
//     return json_model(
//         id: parsedJson['id'],
//         date: parsedJson['date'],
//         modified: parsedJson['modified'],
//         status: parsedJson['status'],
//         title: Title.fromJson(parsedJson['title']),
//         content: Content.fromJson(parsedJson['content']),
//         better_featured_image: Better_featured_image.fromJson(parsedJson['better_featured_image'])
//     );
//   }
// }
//
// class Better_featured_image {
//   String source_url;
//   Better_featured_image({
//     this.source_url
//   });
//   factory Better_featured_image.fromJson(Map<String, dynamic> json){
//     return Better_featured_image(
//         source_url: json['source_url']
//     );
//   }
// }
//
// class Content {
//   String rendered;
//   Content({
//     this.rendered
//   });
//   factory Content.fromJson(Map<String, dynamic> json){
//     return Content(
//         rendered: json['rendered']
//     );
//   }
// }
//
// class Title {
//   String rendered;
//   Title({
//     this.rendered
//   });
//   factory Title.fromJson(Map<String, dynamic> json){
//     return Title(
//         rendered: json['rendered']
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:odisha/model/json_model.dart';
// import 'dart:async';
//
// import 'package:odisha/services/Services.dart';
//
// class SearchPage extends StatefulWidget {
//   SearchPage() : super();
//
//   final String title = "Filter List Demo";
//
//   @override
//   _SearchPageState createState() => _SearchPageState();
// }
//
// class Debouncer {
//   final int milliseconds;
//   VoidCallback action;
//   Timer _timer;
//
//   Debouncer({this.milliseconds});
//
//   run(VoidCallback action) {
//     if (null != _timer) {
//       _timer.cancel();
//     }
//     _timer = Timer(Duration(milliseconds: milliseconds), action);
//   }
// }
//
// class _SearchPageState extends State<SearchPage> {
//   //
//   final debouncer = Debouncer(milliseconds: 1000);
//   json_model users;
//   String title;
//
//   @override
//   void initState() {
//     super.initState();
//     title = 'Loading users...';
//     Services.getSearchNews2().then((usersFromServer) {
//       setState(() {
//         users = usersFromServer ;
//         title = widget.title;
//       });
//     });
//   }
//
//   Widget list() {
//     return Expanded(
//       child: ListView.builder(
//         itemCount: users.title.rendered == null ? 0 : users.title.rendered.length,
//         itemBuilder: (BuildContext context, int index) {
//           return row(index);
//         },
//       ),
//     );
//   }
//
//   Widget row(int index) {
//     return Card(
//       child: Padding(
//         padding: EdgeInsets.all(10.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               users.jmodel[index].title.rendered,
//               style: TextStyle(
//                 fontSize: 16.0,
//                 color: Colors.black,
//               ),
//             ),
//             SizedBox(
//               height: 5.0,
//             ),
//             Text(
//               users.title.rendered[index].toLowerCase(),
//               style: TextStyle(
//                 fontSize: 14.0,
//                 color: Colors.grey,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget searchTF() {
//     return TextField(
//       decoration: InputDecoration(
//         border: OutlineInputBorder(
//           borderRadius: const BorderRadius.all(
//             const Radius.circular(
//               5.0,
//             ),
//           ),
//         ),
//         filled: true,
//         fillColor: Colors.white60,
//         contentPadding: EdgeInsets.all(15.0),
//         hintText: 'Filter by title',
//       ),
//       onChanged: (string) {
//         debouncer.run(() {
//           setState(() {
//             title = 'Searching...';
//           });
//           Services.getSearchNews2().then((usersFromServer) {
//             setState(() {
//               users = json_model.filterList(usersFromServer, string);
//               title = widget.title;
//             });
//           });
//         });
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(10.0),
//         child: Column(
//           children: <Widget>[
//             searchTF(),
//             SizedBox(
//               height: 10.0,
//             ),
//             list(),
//           ],
//         ),
//       ),
//     );
//   }
// }
