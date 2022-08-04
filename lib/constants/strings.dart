
class Strings {
  Strings._();

  //General
  static const String APP_NAME = "alajlanonline";
  static const String androidAppId = "online.alajlanonline";
  static const String iOSAppId = "1565162947";

  // static const String kSplashScreen = "assets/images/splash2.png";
  // static const String kSplashScreenEn = "assets/images/splash2_en.png";

  //network
  // Todo production
  static const String MAIN_URL = "https://preprod.alajlanonline.com/";

  // Todo staging
  // static const String MAIN_URL = "https://staging-5em2ouy-qujjm6n5pmk6i.eu-5.magentosite.cloud/";
  static const String MAIN_API_URL_AR = "$MAIN_URL" + "rest/V1/";
  static const String MAIN_API_URL_EN = "$MAIN_URL" + "rest/en/V1/";
  static const String Image_URL = MAIN_URL + "media/catalog/product/";

  static const String MOBILE = "mobile/";
  static const String BLOCKS = "blocks/";
  static const String LOGIN = "integration/customer/token";
  static const String CUSTOMER_ME = "customers/me";
  static const String CUSTOMERS = "customers";
  static const String SOCIAL_LOGIN = "mstore/social_login";
  static const String APPLE_LOGIN = "mstore/appleLogin";
  static const String CUSTOMER_PASSWORD = "customers/password";
  static const String CUSTOMER_RESET_PASSWORD = "customers/resetPassword";
  static const String AR_HELP = "$MAIN_URL" + "faq";
  static const String EN_HELP = "$MAIN_URL" + "faq";
  static const String EN_contact = "$MAIN_URL" + "contact";


  static const String pushNotificationItems = "pushnotification/items";
  static const String pushNotificationSaveToken = "pushnotification/savetoken";

  // ignore: non_constant_identifier_names
  static String CART_MINE = "carts/mine/";
  static String CART_MINE_FIXED = "carts/mine/";
  static String DEFAULT_SHIPPING_CART =
      MOBILE + "carts/mine/estimate-shipping-methods";
  static const String CREATE_CART_MINE = "carts/mine/";
  static const String GUEST_CART = "guest-carts/";
  static const String CONTACT = "contact";
  static const String CHECK_GIFT_CARD = "checkGiftCard/";
  static const String GIFT_CARD = "giftcard/";
  static const String GIFT_CARDS = "giftCards/";
  static const String REDEEM = "redeem";
  static const String ITEMS = "items";
  static const String TOTAL = "totals";
  static const String COUPONS = "coupons";
  static const String ESTIMATE_SHIP_METHOD = "estimate-shipping-methods";
  static const String PAYMENT_INFORMATION = "payment-information";
  static const String SET_PAYMENT_INFORMATION = "set-payment-information";
  static const String SET_PAYMENT_INFORMATION_AND_GET_TOTALS =
      "set-payment-information-and-get-totals";
  static const String SHIPPING_INFORMATION = "shipping-information";
  static const String ADDRESSES = "addresses";
  static const String COUNTRIES = "directory/countries";
  static const String CITIES_DELIVERY_INFO =
      "shippingdeliveryinfo/LANG/xgetallcities";
  static const String STATES_AVAILABLE = "states/availablestates";
  static const String CITES_AVAILABLE = "cities/availablecities/";
  static const String STATE_SAUDI = "SA";
  static const String MY_ORDERS = "me/orders";
  static const String ORDER_TRACK_INFO = "order/shipment/track/";
  static const String WISH_LIST = "wishlist/";
  static const String WISH_LIST_ADD = "add/";
  static const String WISH_LIST_DEL = "delete/";
  static const String SEARCH = "search";
  static const String MOBILE_SEARCH = "mobile/search";
  static const String MEDIA_PRODUCT = "media/catalog/product/";
  static const String REWARD_MINE = "reward/mine/";
  static const String REWARD = "reward/";
  static const String BALANCE = "balance/";
  static const String CART = "cart/";
  static const String CHECKOUT = "checkout/";
  static const String ALERT = "alert";
  static const String INFO = "info";
  static const String HISTORY = "history";
  static const String PAYMENT = "payment";
  static const String USE_REWARD = "use-reward";
  static const String REMOVE_REWARD = "remove-reward";
  static const String RETURN_MINE = "returns/mine/";
  static const String RMA = "rma/";
  static const String COMMENTS = "comments/";
  static const String SUBMIT = "submit/";
  static const String RETURN_ATTR_META = "returnsAttributeMetadata/";
  static const String CANCEL_ORDER_REASONS = "order/cancel/reasons";
  static const String CANCEL_ORDER = "order/cancel/";
  static const String WALLET_BALANCE = "api/wallet/balance";
  static const String PAY_WITH_WALLET = "api/wallet/applypaymentamount";
  static const String SAVED_CARD = "payfort/saved/vault";
  static const String PLACE_ORDER_WITH_SAVED_CARD = "payfort/tokenize";
  static const String DELETE_CARD = "payfort/delete/vault";

  static const String API = "api";
  static const String CATEGORIES = "categories";
  static const String PRODUCTS = "products";
  static const String YOU_MIGHT_LIKE = "cross-sell/mine";
  static const String HOME = "home";
  static const String REVIEWS = "reviews";
  static const String USERNAME = "username";
  static const String PASSWORD = "password";
  static const String EMAIL = "email";
  static const String GENDER = "gender";
  static const String IS_SUBSCRIBED = "is_subscribed";
  static const String FIRSTNAME = "firstname";
  static const String LASTNAME = "lastname";
  static const String STORE_ID = "storeId";
  static const String TOKEN = "token";
  static const String TYPE = "type";
  static const String TEMPLATE = "template";
  static const String WEBSITE_ID = "websiteId";
  static const String RESET_TOKEN = "resetToken";
  static const String NEW_PASSWORD = "newPassword";
  static const String APP_VERSION = "app/version";

  static const double code_fee_tax = (12 - (12 / 1.15));

  //API keys

  // Header keys

  // Production Token
  // Todo production
  //static const String ADMIN_TOKEN = "xw3ciydjn4u8wt14z4r45x340co5iek2";

  // Staging Token
  // Todo staging
   static const String ADMIN_TOKEN = "i9k6d3npa3cpg2e9t600ooe3u65ch2mz";

   static const String host = 'https://test.oppwa.com/v1/';
  static   Uri checkoutEndpoint = Uri(
    scheme: 'https',
    host: host,
    path: '',
  );

  static   Uri statusEndpoint = Uri(
    scheme: 'https',
    host: host,
    path: '',
  );


  static String USER_TOKEN = "";
  static const String GUEST_IMAGE =
      "https://www.iconsdb.com/icons/download/light-gray/guest-512.jpg";

  static const kUpgradeURLConfig = {
    "android": "https://play.google.com/store/apps/details?id=com.wiakum",
    // "ios": "https://apps.apple.com/us/app/jawhara/id1565162947"
    "ios": "http://itunes.apple.com/app/id1565162947",
    "huawei": "https://appgallery.huawei.com/#/app/C104297429"
  };


}
