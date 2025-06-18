import 'package:hive/hive.dart';

class HiveHelper {
  static const _boxName = 'settings';

  static Future<void> init() async {
    await Hive.openBox(_boxName);
  }

  static bool getOnboardingSeen() {
    final box = Hive.box(_boxName);
    return box.get('onboarding_seen', defaultValue: false);
  }

  static Future<void> setOnboardingSeen(bool seen) async {
    final box = Hive.box(_boxName);
    await box.put('onboarding_seen', seen);
  }
}
