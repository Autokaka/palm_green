import 'dart:convert';
import 'dart:io';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palm_green/models/user.dart';
import 'package:palm_green/url_ref.dart';
import 'package:palm_green/widgets/avatar.dart';
import 'package:palm_green/widgets/easy_list.dart';
import 'package:provider/provider.dart';

class AvatarPage extends StatefulWidget {
  final Widget avatar;

  AvatarPage({Key key, @required this.avatar}) : super(key: key);

  @override
  _AvatarPageState createState() => _AvatarPageState();
}

class _AvatarPageState extends State<AvatarPage> {
  File _imageFile;
  Widget _avatar;
  BuildContext _scaffoldContext;
  bool _uploading = false;

  @override
  void initState() {
    super.initState();
    _avatar ??= widget.avatar;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, "views.avatar_page.title")),
      ),
      body: Builder(
        builder: (BuildContext context) {
          _scaffoldContext = context;
          return EasyList(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 200,
                    width: 120,
                    color: Colors.grey[200],
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    child: _avatar,
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 100,
                        margin:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        child: ClipOval(
                          child: _avatar,
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        color: Colors.grey[200],
                        margin:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        child: ClipRect(
                          child: _avatar,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  OutlineButton.icon(
                    icon: Icon(CommunityMaterialIcons.google_photos),
                    label: Text(FlutterI18n.translate(
                        context, "views.avatar_page.gallery")),
                    onPressed: () => _pickImage(ImageSource.gallery),
                  ),
                  Padding(padding: EdgeInsets.all(15)),
                  OutlineButton.icon(
                    icon: Icon(CommunityMaterialIcons.camera),
                    label: Text(FlutterI18n.translate(
                        context, "views.avatar_page.camera")),
                    onPressed: () => _pickImage(ImageSource.camera),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(10)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: RaisedButton.icon(
                  color: Colors.green,
                  colorBrightness: Brightness.dark,
                  icon: Icon(CommunityMaterialIcons.upload),
                  label: Text(_uploading
                      ? FlutterI18n.translate(
                          context, "views.avatar_page.uploading")
                      : FlutterI18n.translate(
                          context, "views.avatar_page.confirm")),
                  onPressed: _uploading ? null : _uploadAvatar,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _pickImage(ImageSource source) async {
    _imageFile = await ImagePicker.pickImage(source: source);
    if (_imageFile == null) return;

    setState(() {
      _avatar = Image.file(_imageFile);
    });
  }

  void _uploadAvatar() async {
    if (_imageFile == null) return;

    setState(() {
      _uploading = true;
    });

    Response response = await Dio().post(
      UrlRef.uploadAvatar,
      data: FormData.fromMap({
        "file": await MultipartFile.fromFile(
          _imageFile.path,
          filename: "${Provider.of<User>(context, listen: false).id}.png",
        ),
      }),
    );

    var result = json.decode(response.data);
    if (result is bool && result == true) {
      Avatar.needUpdate = true;
      Navigator.pop(context);
    } else {
      final snackBar = SnackBar(
        content: Text(
            FlutterI18n.translate(context, "views.avatar_page.upload_fail")),
      );
      Scaffold.of(_scaffoldContext).showSnackBar(snackBar);
    }
  }
}
