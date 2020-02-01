import 'package:flutter/foundation.dart';

class UrlRef {
  // 项目基址
  static const String origin = "http://114.55.92.221/palm-green";

  // 全局附加属性设置模式
  static const String append = kReleaseMode ? "" : "-dev";

  // 文章相关
  static const String listArticles = "$origin/api$append/oss/list_articles.php";
  static const String articleContent =
      "$origin/api$append/oss/article_content.php";

  // 图片相关
  static const String listBanners = "$origin/api$append/oss/list_banners.php";
  static const String getAvatar = "$origin/api$append/oss/get_avatar.php";
  static const String uploadAvatar = "$origin/api$append/oss/upload_avatar.php";

  // 登录相关
  static const String login = "$origin/api$append/db/login.php";
  static const String register = "$origin/api$append/db/register.php";

  // 更新相关
  static const String checkUpdate = "$origin/api$append/oss/check_update.php";
}
