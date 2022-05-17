import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kalingatv4/model/news_model.dart';

import 'rounded_bordered_container.dart';
class news_card2 extends StatelessWidget {
  const news_card2(this.context, this._news_model);
  @required
  final news_model _news_model;
  final BuildContext context;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            child: Image.network(
                _news_model.image_url,
                fit: BoxFit.cover
            )
        ),
        Positioned(
            left: 15,
            bottom: 15,
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.5)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                          _news_model.title,
                          style: new TextStyle(
                              fontSize: 20, color: Colors.white)),
                    ],
                  ),
                ],
              ),
            )
        )
      ],
    );






    //   Scaffold(
    //   // height: 180,
    //   // width: 300,
    //     body: Column(
    //       children: <Widget>[
    //     RoundedContainer(
    //       elevation: 1,
    //       color: Colors.white,
    //      padding: const EdgeInsets.all(0),
    //    margin: EdgeInsets.all(1),
    //   height: 120,
    //   child: Row(
    //     children: <Widget>[
    //       Container(
    //         height: 110,
    //         decoration: BoxDecoration(color: Colors.white,
    //             image: DecorationImage(
    //               image: NetworkImage(_news_model.image_url,),
    //               fit:BoxFit.cover,
    //             )),
    //       ),
    //       // SizedBox(
    //       //   width: 20,
    //       // ),
    //       Flexible(
    //         child: Padding(
    //           //padding: const EdgeInsets.symmetric(horizontal: 1),
    //           padding: EdgeInsets.only(top: 15),
    //           child: Column(
    //             children: <Widget>[
    //               Row(
    //                 children: <Widget>[
    //                   Flexible(
    //                     child: Text(
    //                       _news_model.title,
    //                       style: TextStyle(
    //                         fontFamily: 'Poppins',
    //                         fontSize: 16,
    //                         color: const Color(0xff080f18),
    //                         fontWeight: FontWeight.w700,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //               // SizedBox(
    //               //   height: 5,
    //               // ),
    //               // Row(
    //               //   children: <Widget>[
    //               //     Text(_news_model.description),
    //               //   ],
    //               // ),
    //             ],
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // ),
    //         //cartItems(items.image,_items.issues,_items.price),
    //        // _checkoutSection()
    //       ],
    //     )
    // );
  }
  }