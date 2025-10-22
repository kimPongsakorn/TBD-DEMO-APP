import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/checkout/checkout_controller.dart';

class CheckoutPage extends GetView<CheckoutController> {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Center(
        child: ElevatedButton(
          onPressed: controller.processCheckout,
          child: const Text('Process Checkout'),
        ),
      ),
    );
  }
}
