import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:palm_green/models/user.dart';
import 'package:palm_green/url_ref.dart';
import 'package:palm_green/utils/quick_launcher.dart';
import 'package:palm_green/views/me_page/avatar_page.dart';
import 'package:provider/provider.dart';

class Avatar extends StatefulWidget {
  static bool needUpdate = false;

  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  Widget _avatar;

  @override
  Widget build(BuildContext context) {
    if (_avatar == null) _fillWidgetNeeds();
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 5),
      width: 150,
      height: 150,
      child: Material(
        shape: CircleBorder(),
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: GestureDetector(
          child: _avatar,
          onTap: () => QuickLauncher.go(context, AvatarPage(avatar: _avatar)),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(Avatar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (Avatar.needUpdate) _fillWidgetNeeds();
  }

  void _fillWidgetNeeds() async {
    Response response = await Dio().post(
      UrlRef.getAvatar,
      data: Provider.of<User>(context).id,
    );

    var result = json.decode(response.data);
    if (result is bool && result == false) {
      _avatar = Image.asset("assets/images/default_avatar.png");
    } else {
      _avatar = CachedNetworkImage(
        imageUrl: json.decode(response.data),
        fit: BoxFit.cover,
        placeholder: (context, url) => Icon(CommunityMaterialIcons.download),
        errorWidget: (context, url, error) => Image(
          image: AssetImage("assets/images/default_avatar.png"),
        ),
      );
    }

    Avatar.needUpdate = false;
    setState(() => _avatar);
  }
}
