class UrlRef {
  // 项目基址
  static const String origin = "http://114.55.92.221/palm-green";

  // 文章相关
  static const String listArticles = "$origin/api/oss/list_articles.php";
  static const String articleContent = "$origin/api/oss/article_content.php";

  // 图片相关
  static const String listBanners = "$origin/api/oss/list_banners.php";
  static const String getAvatar = "$origin/api/oss/get_avatar.php";
  static const String uploadAvatar = "$origin/api/oss/upload_avatar.php";

  // 登录相关
  static const String login = "$origin/api/db/login.php";
  static const String register = "$origin/api/db/register.php";

  // 更新相关
  static const String checkUpdate = "$origin/api/oss/check_update.php";
}
