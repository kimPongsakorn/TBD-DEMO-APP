import 'package:get/get.dart';
import '../pages/home/home_page.dart';
import '../bindings/home_binding.dart';
import '../pages/checkout/checkout_page.dart';
import '../bindings/checkout_binding.dart';
import '../pages/payment/payment_page.dart';
import '../bindings/payment_binding.dart';

class AppPages {
  static const initial = '/home';

  static final routes = [
    GetPage(name: '/home', page: () => HomePage(), binding: HomeBinding()),
    GetPage(name: '/checkout', page: () => CheckoutPage(), binding: CheckoutBinding()),
    GetPage(name: '/payment', page: () => PaymentPage(), binding: PaymentBinding()),
  ];
}
