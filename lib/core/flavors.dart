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
