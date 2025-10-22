import 'package:get/get.dart';
import 'package:tbd_demo_app/controllers/checkout/checkout_controller.dart';

class OldCheckoutController extends CheckoutController {
  final isLoading = false.obs;

  @override
  void processCheckout() {
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
      Get.snackbar('Old Checkout', 'Processed using legacy checkout flow');
    });
  }
}
