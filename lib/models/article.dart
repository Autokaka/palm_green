import 'package:flutter/material.dart';

class Article {
  String _title;
  String _content;
  String _author;
  String _time;

  Article({
    @required String title,
    String content,
    String author,
    String time,
  }) {
    _title = title;
    _content = content;
    _author = author;
    _time = time;
  }

  get title => _title;
  get content => _content;
  get author => _author;
  get time => _time;
}
