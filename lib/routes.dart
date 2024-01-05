import 'package:citymall/bindings/initial_binding.dart';
import 'package:citymall/bindings/splash_binding.dart';
import 'package:citymall/screens/account_screen.dart';
import 'package:citymall/screens/cart/cart_screen.dart';
import 'package:citymall/screens/categories_list_screen.dart';
import 'package:citymall/screens/checkout_screen.dart';
import 'package:citymall/screens/coupons_screen.dart';
import 'package:citymall/screens/dashboard.dart';
import 'package:citymall/screens/deals/categories_list_screen.dart';
import 'package:citymall/screens/deals/collection_list_screen.dart';
import 'package:citymall/screens/deals/collection_product_list.dart';
import 'package:citymall/screens/deals/product_list.dart';
import 'package:citymall/screens/filter.dart';
import 'package:citymall/screens/location.dart';
import 'package:citymall/screens/login_screen.dart';
import 'package:citymall/screens/login_success.dart';
import 'package:citymall/screens/main_categories_list_screen.dart';
import 'package:citymall/screens/nointenet.dart';
import 'package:citymall/screens/onboarding.dart';
import 'package:citymall/screens/order_accepted_screen.dart';
import 'package:citymall/screens/order_failed_dialog.dart';
import 'package:citymall/screens/otp_screen.dart';
import 'package:citymall/screens/payment.dart';
import 'package:citymall/screens/product_detail.dart';
import 'package:citymall/screens/product_list.dart';
import 'package:citymall/screens/razor_payment.dart';
import 'package:citymall/screens/register_screen.dart';
import 'package:citymall/screens/register_success.dart';
import 'package:citymall/screens/return_order_items_list_screen.dart';
import 'package:citymall/screens/return_screen.dart';
import 'package:citymall/screens/search.dart';
import 'package:citymall/screens/single_order.dart';
import 'package:citymall/screens/splash_screen.dart';
import 'package:citymall/screens/static/about.dart';
import 'package:citymall/screens/static/privacy.dart';
import 'package:citymall/screens/static/return.dart';
import 'package:citymall/screens/static/shipping.dart';
import 'package:citymall/screens/static/terms.dart';
import 'package:citymall/screens/support.dart';
import 'package:citymall/screens/test.dart';
import 'package:citymall/screens/order_history.dart';
import 'package:citymall/screens/user_account/profile.dart';
import 'package:citymall/screens/welcome_screen.dart';
import 'package:citymall/screens/error.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String dashboard = '/dashboard';
  static const String success = '/success';
  static const String login = '/login';
  static const String register = '/register';
  static const String detail = '/detail';
  static const String cart = '/cart';
  static const String coupons = '/coupons';
  static const String categories = '/categories';
  static const String main_categories = '/main_categories';
  static const String products = '/products';
  static const String checkout = '/checkout';
  static const String account = '/account';
  static const String updateProfile = '/updateProfile';
  static const String onBoarding = '/onBoarding';

  static const String pending_orders = '/pending_orders';
  static const String order_history = '/order_history';
  static const String sub_categories = '/sub_categories';
  static const String error_page = '/error_page';
  static const String filter = '/filter';
  static const String test = '/test';
  static const String product_detail = '/product_detail';
  static const String order_detail = '/order_detail';
  static const String order_success = '/order_success';
  static const String order_failed = '/order_failed';
  static const String register_success = '/register_success';
  static const String location = '/location';
  static const String search = '/search';
  static const String return_order_item_list = '/return_order_item_list';
  static const String return_order = '/return_order';
  static const String payment = '/payment';
  static const String map = '/map';
  static const String otp = '/otp';
  static const String deals_categories = '/deals_categories';
  static const String deals_products = '/deals_products';
  static const String support = '/support';
  static const String collectionProducts = '/collection_products';
  static const String collections = '/collections';
  static const String shipping = '/shipping';
  static const String privacy = '/privacy';
  static const String refund = '/return';
  static const String terms = '/terms';
  static const String about = '/about';
  static const String nointernet = '/nointernet';
  static List<GetPage> pages = [
    GetPage(
      name: splash,
      page: () => SplashScreen(),
      binding: SplashBinding()
    ), GetPage(
      name: nointernet,
      page: () => NoIntenetScreen(),
    ),
    GetPage(
      name: about,
      page: () => About(),
    ),
    GetPage(
      name: shipping,
      page: () => ShippingPolicy(),
    ),
    GetPage(
      name: privacy,
      page: () => PrivacyPolicy(),
    ),
    GetPage(
      name: terms,
      page: () => Terms(),
    ),
    GetPage(
      name: refund,
      page: () => ReturnPolicy(),
    ),


    GetPage(
      name: login,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: otp,
      page: () => OTPScreen(),
    ),
    GetPage(
      name: welcome,
      page: () => WelcomeScreen(),
    ),
    GetPage(
      name: success,
      page: () => LoginSuccessScreen(),
    ),
    GetPage(
      name: dashboard,
      page: () => DashboardScreen(),
        binding: InitialBinding()
    ),
    GetPage(
      name: detail,
      page: () => ProductDetailScreen(),
    ),
    GetPage(
      name: cart,
      page: () => CartScreen(),
    ),
    GetPage(
      name: coupons,
      page: () => CouponsScreen(),
    ),
    GetPage(
      name: categories,
      page: () => CategoriesListScreen(),
    ),

    GetPage(
      name: products,
      page: () => ProductListScreen(),
    ),
    GetPage(
      name: categories,
      page: () => CategoriesListScreen(),
    ),
    GetPage(
      name: checkout,
      page: () => CheckoutScreen(),
    ),
    GetPage(
      name: account,
      page: () => AccountScreen(),
    ),
    GetPage(
      name: return_order,
      page: () => ReutrnOrderScreen(),
    ),
    GetPage(
      name: return_order_item_list,
      page: () => ReutrnOrderItemsListScreen(),
    ),
    GetPage(
      name: updateProfile,
      page: () => ProfileScreen(),
    ),

    GetPage(
      name: order_history,
      page: () => OrderHistoryScreen(),
    ),

    GetPage(
      name: error_page,
      page: () => ErrorPage(),
    ),
    GetPage(
      name: main_categories,
      page: () => MainCategoriesListScreen(),
    ),
    GetPage(
      name: test,
      page: () => TestScreen(),
    ),
    GetPage(
      name: product_detail,
      page: () => ProductDetailScreen(),
    ),
    GetPage(
      name: order_success,
      page: () => OrderAcceptedScreen(),
    ),GetPage(
      name: order_failed,
      page: () => OrderFailedDialogue(),
    ),
    GetPage(
      name: product_detail,
      page: () => ProductDetailScreen(),
    ),
    GetPage(
      name: register,
      page: () => RegisterScreen(),
    ),
    GetPage(
      name: register_success,
      page: () => RegisterSuccess(),
    ),
    GetPage(
      name: location,
      page: () => LocationPage(),
    ),
    GetPage(
      name: search,
      page: () => SearchScreen(),
    ),
    GetPage(
      name: order_detail,
      page: () => SingleOrderScreen(),
    ),
    // GetPage(
    //   name: payment,
    //   page: () => RazorPaymentScreen(),
    // ),
    GetPage(
      name: map,
      page: () => LocationPage(),
    ),
    GetPage(
      name: deals_categories,
      page: () => DealsCategoriesListScreen(),
    ),
    GetPage(
      name: deals_products,
      page: () => DealsProductListScreen(),
    ),
    GetPage(
      name: support,
      page: () => SupportScreen(),
    ),
    GetPage(
      name: onBoarding,
      page: () => OnBoardingScreen(),
    ),
    GetPage(
      name: collectionProducts,
      page: () => CollectionProductListScreen(),
    ),
    GetPage(
      name: collections,
      page: () => CollectionListScreen(),
    ),
  ];
}
