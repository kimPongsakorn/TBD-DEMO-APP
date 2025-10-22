import 'package:get/get.dart';
import '../controllers/payment/payment_controller.dart';
import '../controllers/payment/old_payment_controller.dart';
import '../controllers/payment/new_payment_controller.dart';
import '../core/feature_flags.dart';

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    if (FeatureFlags.isEnabled('new_payment_gateway')) {
      Get.lazyPut<PaymentController>(() => NewPaymentController());
    } else {
      Get.lazyPut<PaymentController>(() => OldPaymentController());
    }
  }
}
