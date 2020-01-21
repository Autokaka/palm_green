import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:palm_green/url_ref.dart';

class Banners extends StatefulWidget {
  @override
  _BannersState createState() => _BannersState();
}

class _BannersState extends State<Banners> {
  final double _bannerHeight = 200;
  final double _bannerWidth = 350;
  List _urlList = [];

  @override
  void initState() {
    super.initState();
    _getUrls();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Container(
            padding: EdgeInsets.all(10),
            height: _bannerHeight,
            width: _bannerWidth,
            child: Swiper(
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: _urlList[index].toString(),
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Icon(CommunityMaterialIcons.download),
                  errorWidget: (context, url, error) =>
                      Icon(CommunityMaterialIcons.network_off),
                );
              },
              autoplay: true,
              loop: false,
              itemCount: _urlList.length,
            ),
          ),
        ],
      ),
    );
  }

  void _getUrls() async {
    try {
      Response response = await Dio().get(UrlRef.listBanners);
      _urlList = json.decode(response.data);
      setState(() => _urlList);
    } catch (e) {
      print(e);
    }
  }
}
