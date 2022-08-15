
class Strings {
  Strings._();

  //network
  // Todo production
  static const String MAIN_URL = "https://wiakum.com";

  // Todo staging
  // static const String MAIN_URL = "https://staging-5em2ouy-qujjm6n5pmk6i.eu-5.magentosite.cloud/";
  static const String MAIN_API_URL_AR = "$MAIN_URL" + "/";
  static const String MAIN_API_URL_EN = "$MAIN_URL" + "/en/";
  static const String MAIN_API_AR = "$MAIN_URL" + "/rest/V1/";
  static const String MAIN_API_EN = "$MAIN_URL" + "/rest/en/V1/";

  static const kUpgradeURLConfig = {
    "android": "https://play.google.com/store/apps/details?id=com.wiakum",
    "ios": "http://itunes.apple.com/app/id1565162947",
    "huawei": "https://appgallery.huawei.com/#/app/C104297429"
  };


}
