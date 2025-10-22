#!/bin/bash
# ==========================================
#  Create Flutter TBD Project Structure
#  Author: Kim (Pongsakorn)
# ==========================================

echo "🚀 Setting up Trunk-Based Development Flutter structure..."

# Root check
if [ ! -d "lib" ]; then
  echo "❌ This script must be run inside a Flutter project root (lib folder not found)"
  exit 1
fi

# Core directories
mkdir -p lib/{core,bindings,controllers,pages,routes,models}
mkdir -p lib/controllers/{checkout,payment,home}
mkdir -p lib/pages/{checkout,payment,home}

# Main entry points
touch lib/main.dart lib/main_dev.dart lib/main_qa.dart lib/main_prod.dart

# Core files
cat > lib/core/flavors.dart << 'EOF'
enum Flavor { dev, qa, prod }

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final String apiBaseUrl;
  final bool enableLogging;
  static FlavorConfig? _instance;

  factory FlavorConfig({
    required Flavor flavor,
    required String name,
    required String apiBaseUrl,
    required bool enableLogging,
  }) {
    _instance ??= FlavorConfig._internal(flavor, name, apiBaseUrl, enableLogging);
    return _instance!;
  }

  FlavorConfig._internal(this.flavor, this.name, this.apiBaseUrl, this.enableLogging);

  static FlavorConfig get instance => _instance!;
  static bool get isDev => _instance?.flavor == Flavor.dev;
  static bool get isQA => _instance?.flavor == Flavor.qa;
  static bool get isProd => _instance?.flavor == Flavor.prod;
}
EOF

cat > lib/core/feature_flags.dart << 'EOF'
import 'package:firebase_remote_config/firebase_remote_config.dart';

class FeatureFlags {
  static final _remoteConfig = FirebaseRemoteConfig.instance;

  static Future<void> init() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: Duration(seconds: 10),
        minimumFetchInterval: Duration(hours: 1),
      ),
    );
    await _remoteConfig.setDefaults({
      'new_checkout_flow': false,
      'new_payment_gateway': false,
    });
    await _remoteConfig.fetchAndActivate();
  }

  static bool isEnabled(String flagName) {
    return _remoteConfig.getBool(flagName);
  }
}
EOF

# Routes
cat > lib/routes/app_pages.dart << 'EOF'
import 'package:get/get.dart';
import '../pages/home/home_page.dart';
import '../bindings/home_binding.dart';
import '../pages/checkout/checkout_page.dart';
import '../bindings/checkout_binding.dart';
import '../pages/payment/payment_page.dart';
import '../bindings/payment_binding.dart';

class AppPages {
  static const INITIAL = '/home';
  static final routes = [
    GetPage(name: '/home', page: () => HomePage(), binding: HomeBinding()),
    GetPage(name: '/checkout', page: () => CheckoutPage(), binding: CheckoutBinding()),
    GetPage(name: '/payment', page: () => PaymentPage(), binding: PaymentBinding()),
  ];
}
EOF

# Bindings template
cat > lib/bindings/checkout_binding.dart << 'EOF'
import 'package:get/get.dart';
import '../core/feature_flags.dart';
import '../controllers/checkout/checkout_controller.dart';
import '../controllers/checkout/old_checkout_controller.dart';
import '../controllers/checkout/new_checkout_controller.dart';

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
EOF

# Example controller
cat > lib/controllers/checkout/checkout_controller.dart << 'EOF'
import 'package:get/get.dart';

abstract class CheckoutController extends GetxController {
  RxBool get isLoading;
  void processPayment();
  void validateCart();
}
EOF

# Example page
cat > lib/pages/home/home_page.dart << 'EOF'
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Get.toNamed('/checkout'),
              child: Text('Go to Checkout'),
            ),
            ElevatedButton(
              onPressed: () => Get.toNamed('/payment'),
              child: Text('Go to Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
EOF

echo "✅ Folder structure created successfully!"
echo "Now you can start building with: flutter run -t lib/main_dev.dart"
