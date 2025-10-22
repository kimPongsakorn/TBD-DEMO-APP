import 'package:get/get.dart';
import 'payment_controller.dart';

class NewPaymentController extends PaymentController {
  final isLoading = false.obs;

  @override
  void processPayment() {
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
      Get.snackbar('New Payment', 'Processed with 3D Secure ✅');
    });
  }
}
