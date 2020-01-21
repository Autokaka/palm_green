import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:palm_green/widgets/banners.dart';
import 'package:palm_green/widgets/article_items.dart';

class ArticlePage extends StatefulWidget {
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  Banners _banner = Banners();
  ArticleItems _articleItems = ArticleItems();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, "views.article_page.title")),
      ),
      body: EasyRefresh.custom(
        slivers: <Widget>[
          _banner,
          _articleItems,
        ],
        onRefresh: _articleItems.reload,
        onLoad: _articleItems.loadMore,
      ),
    );
  }
}
