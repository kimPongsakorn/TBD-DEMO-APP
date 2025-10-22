import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tbd_demo_app/controllers/payment/payment_controller.dart';

class PaymentPage extends GetView<PaymentController> {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: Center(
        child: ElevatedButton(
          onPressed: controller.processPayment,
          child: const Text('Process Payment'),
        ),
      ),
    );
  }
}
