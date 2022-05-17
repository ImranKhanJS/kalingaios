import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Categories {
  String name;
  String link;

  Categories({
    this.name,
    this.link
  }
  );
  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
        name: json == null ? 'NO Categiry' :json['name'] as String,
        link: json == null ? 'NO LINK' :json["_links"]["wp:post_type"][0]["href"] as String);
    }
}