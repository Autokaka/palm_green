import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:webfeed/domain/rss_feed.dart';

class SchoolAnnPage extends StatefulWidget {
  @override
  _SchoolAnnPageState createState() => _SchoolAnnPageState();
}

class _SchoolAnnPageState extends State<SchoolAnnPage> {
  Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    _getAnnouncementList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title:
            Text(FlutterI18n.translate(context, "views.school_ann_page.title")),
      ),
      body: Container(),
    );
  }

  void _getAnnouncementList() async {
    var response =
        await _dio.get("https://rsshub.app/bilibili/bangumi/media/9192");
    var channel = RssFeed.parse(response.data);
    print(channel.items);
  }
}
