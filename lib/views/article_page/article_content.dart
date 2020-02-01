import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:palm_green/url_ref.dart';
import 'package:palm_green/widgets/easy_list.dart';

class ArticleContent extends StatefulWidget {
  final String title;
  ArticleContent({Key key, this.title}) : super(key: key);

  @override
  _ArticleContentState createState() => _ArticleContentState();
}

class _ArticleContentState extends State<ArticleContent> {
  String _content = "";

  @override
  void initState() {
    super.initState();
    _getContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.title),
      ),
      body: EasyList(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: MarkdownBody(
              data: _content,
            ),
          ),
        ],
      ),
    );
  }

  void _getContent() async {
    try {
      Response response = await Dio().post(
        UrlRef.articleContent,
        data: widget.title,
      );
      if (response.data != false) {
        _content = json.decode(response.data);
        setState(() => _content);
      }
    } catch (e) {
      print(e);
    }
  }
}
