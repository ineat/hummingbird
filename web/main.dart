import 'package:flutter_web_ui/ui.dart' as ui;
import 'package:flutter_web_ui/src/engine.dart' as engine;
import 'package:ineat_flutter_web/main.dart' as app;

main() async {
  await ui.webOnlyInitializePlatform();
  app.main();
}