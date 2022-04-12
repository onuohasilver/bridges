class BridgeErrors {
  static const String cannotOverride =
      'BridgeError: Cannot Override Previously set value. Try setting override to true.';
  static String unmatched(String name, Type? savedType, Type? initialType) {
    return '  $name of type $savedType is not similar to requested type $initialType gotten from parsed initial Value';
  }
}
