import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Expose the semantics tree for accessibility and Playwright checks on web.
  SemanticsBinding.instance.ensureSemantics();
  runApp(SotongSiteManagerApp());
}
