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
