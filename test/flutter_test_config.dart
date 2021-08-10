import 'dart:async';

import 'package:golden_toolkit/golden_toolkit.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return GoldenToolkit.runWithConfiguration(
    () async {
      await loadAppFonts();
      await testMain();
    },
    config: GoldenToolkitConfiguration(
      defaultDevices: const [Device.iphone11],
      deviceFileNameFactory: (name, device) {
        // return 'goldens/$name.${device.name}.png';
        return 'goldens/$name.png';
      }
    ),
  );
}
