import 'package:get/get.dart';
import 'payment_controller.dart';

class OldPaymentController extends PaymentController {
  final isLoading = false.obs;

  @override
  void processPayment() {
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
      Get.snackbar('Old Payment', 'Processed via legacy gateway');
    });
  }
}
