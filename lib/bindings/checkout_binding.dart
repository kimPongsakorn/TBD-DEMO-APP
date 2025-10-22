import 'package:get/get.dart';
import 'package:tbd_demo_app/controllers/checkout/new_checkout_controller.dart';
import 'package:tbd_demo_app/controllers/checkout/old_checkout_controller.dart';

import '../controllers/checkout/checkout_controller.dart';
import '../core/feature_flags.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    if (FeatureFlags.isEnabled('new_checkout_flow')) {
      Get.lazyPut<CheckoutController>(() => NewCheckoutController());
    } else {
      Get.lazyPut<CheckoutController>(() => OldCheckoutController());
    }
  }
}
