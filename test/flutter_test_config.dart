import 'dart:async';
import 'dart:io';

import 'package:golden_toolkit/golden_toolkit.dart';

//Theme
import 'package:ez_ticketz_app/helper/utils/custom_theme.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return GoldenToolkit.runWithConfiguration(
    () async {
      await loadAppFonts();
      await testMain();
    },
    config: GoldenToolkitConfiguration(
      defaultDevices: const [GoldensGlobalConfig.defaultDevice],
      fileNameFactory: (name) {
        if(Platform.isWindows) {
            return 'goldens_local/$name.png';
        }
        else {
          return 'goldens/$name.png';
        }
      }
    ),
  );
}

abstract class GoldensGlobalConfig {
  static final globalAppWrapper = materialAppWrapper(
    theme: CustomTheme.mainTheme,
  );

  static const defaultDevice = Device.iphone11;

  static final defaultSurfaceSize = defaultDevice.size;
}
