import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:palm_green/utils/quick_launcher.dart';
import 'package:palm_green/views/school_page/school_ann_page.dart';

class SchoolPage extends StatefulWidget {
  @override
  _SchoolPageState createState() => _SchoolPageState();
}

class _SchoolPageState extends State<SchoolPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, "views.school_page.title")),
        elevation: 0,
      ),
      body: EasyRefresh.custom(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Card(
                elevation: 0,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(CommunityMaterialIcons.alert),
                      title: Text(FlutterI18n.translate(
                          context, "views.school_page.announcement")),
                      onTap: () => QuickLauncher.go(context, SchoolAnnPage()),
                    ),
                    ListTile(
                      leading: Icon(CommunityMaterialIcons.calendar),
                      title: Text(FlutterI18n.translate(
                          context, "views.school_page.schedule")),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
