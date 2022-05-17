import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kalingatv4/model/json_model.dart';
import 'package:kalingatv4/model/news_model.dart';

import 'rounded_bordered_container.dart';
class news_card extends StatelessWidget {
  news_card(context, this.item);
  @required
  BuildContext context;
  final json_model item;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // height: 180,
      // width: 300,
        body: Column(
          children: <Widget>[
        RoundedContainer(
          elevation: 1,
          color: Colors.white,
         padding: const EdgeInsets.all(0),
       margin: EdgeInsets.all(1),
      height: 100,
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
          checkImage(item.better_featured_image),
          SizedBox(
            width: 10,
          ),
          Flexible(
            child: Padding(
              //padding: const EdgeInsets.symmetric(horizontal: 1),
              padding: EdgeInsets.only(top: 10),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        item.title.rendered,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child:Text(
                      'Updated on ' + item.modified,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w700,
                      ),
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
          Icon(
          Icons.keyboard_arrow_right,
          color: Colors.grey,
          size: 30.0,
        ),
        ],
      ),
    ),
            //cartItems(items.image,_items.issues,_items.price),
           // _checkoutSection()
          ],
        )
    );
  }
  Widget checkImage(String image) {

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
  }