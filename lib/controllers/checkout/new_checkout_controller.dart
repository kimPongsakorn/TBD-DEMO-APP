import 'package:get/get.dart';
import 'package:tbd_demo_app/controllers/checkout/checkout_controller.dart';

class NewCheckoutController extends CheckoutController {
  final isLoading = false.obs;

  @override
  void processCheckout() {
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
      Get.snackbar('New Checkout', 'Processed using new checkout flow ✅');
    });
  }
}
