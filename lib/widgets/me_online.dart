import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:palm_green/models/user.dart';
import 'package:palm_green/widgets/avatar.dart';
import 'package:provider/provider.dart';

class MeOnline extends StatefulWidget {
  @override
  _MeOnlineState createState() => _MeOnlineState();
}

class _MeOnlineState extends State<MeOnline> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Avatar(),
        Card(
          elevation: 0,
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(CommunityMaterialIcons.numeric),
                title: Text(
                    FlutterI18n.translate(context, "widgets.me_online.id")),
                subtitle: Text("${Provider.of<User>(context).id}"),
                onTap: () => {},
              ),
              ListTile(
                leading: Icon(CommunityMaterialIcons.card_bulleted),
                title: Text(
                    FlutterI18n.translate(context, "widgets.me_online.name")),
                subtitle: Text("${Provider.of<User>(context).name}"),
                onTap: () => {},
              ),
              ListTile(
                leading: Icon(CommunityMaterialIcons.timeline),
                title: Text(FlutterI18n.translate(
                    context, "widgets.me_online.join_date")),
                subtitle: Text("${Provider.of<User>(context).joinDate}"),
                onTap: () => {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
