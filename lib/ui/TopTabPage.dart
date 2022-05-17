import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kalingatv4/model/json_model.dart';
import 'package:kalingatv4/services/Services.dart';
import 'package:kalingatv4/ui/CategoryNewsList.dart';

import 'NewsList.dart';
import 'articleDetail.dart';

class TopTabPage extends StatefulWidget {
  String category,all,index1;
  TopTabPage(this.index1,this.category) : super();

  @override
  TopTabPageState createState() => TopTabPageState(index1,category);
}

class TopTabPageState extends State<TopTabPage> {
  Color kalinga_color_code = const Color(0xff9b2219);
  String id,index1;
  TopTabPageState(this.index1,this.id);
  //
  StreamController<int> streamController = new StreamController<int>();
  Future<void> _refreshProducts(BuildContext context) async {
    return Services.getTopNews();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
         child: RefreshIndicator(
           onRefresh: () => _refreshProducts(context),
           child: FutureBuilder<List<json_model>>(
             future: Services.getTopNews(),
             builder: (context, snapshot) {
               if (snapshot.hasError) print(snapshot.error);
               return snapshot.hasData
                   ? CategoryNewsList(index1,items: snapshot.data,id:id)
                   :  Center(child: CircularProgressIndicator(
                 valueColor: new AlwaysStoppedAnimation<Color>(kalinga_color_code),
               ));

             },
           ),
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