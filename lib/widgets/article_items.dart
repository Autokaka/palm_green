import 'dart:convert';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:palm_green/url_ref.dart';
import 'package:palm_green/models/article.dart';
import 'package:palm_green/utils/quick_launcher.dart';
import 'package:palm_green/views/article_page/article_content.dart';

class ArticleItems extends StatefulWidget {
  final _articleItemsState = _ArticleItemsState();

  @override
  _ArticleItemsState createState() => _articleItemsState;

  Future<void> reload() => _articleItemsState.reload();

  Future<void> loadMore() => _articleItemsState.loadMore();
}

class _ArticleItemsState extends State<ArticleItems> {
  List<Article> _articleList = <Article>[];

  @override
  void initState() {
    super.initState();
    reload();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return ListTile(
            leading: Icon(CommunityMaterialIcons.newspaper),
            title: Text(_articleList[index].title),
            onTap: () => QuickLauncher.go(
                context, ArticleContent(title: _articleList[index].title)),
          );
        },
        childCount: _articleList.length,
      ),
    );
  }

  Future<void> reload() async {
    try {
      Response response = await Dio().get(UrlRef.listArticles);
      List titleList = json.decode(response.data);

      _articleList.clear();
      for (var title in titleList) {
        _articleList.add(Article(title: title));
      }

      setState(() => _articleList);
    } catch (e) {
      print(e);
    }
  }

  Future<void> loadMore() async {
    try {
      String passMsg;
      if (_articleList.length != 0) {
        passMsg = _articleList[_articleList.length - 1].title;
      }

      Response response = await Dio().post(
        UrlRef.listArticles,
        data: passMsg,
      );
      List titleList = json.decode(response.data);

      if (titleList.length >= 1) _articleList.removeLast();
      for (var title in titleList) {
        _articleList.add(Article(title: title));
      }

      setState(() => _articleList);
    } catch (e) {
      print(e);
    }
  }
}
