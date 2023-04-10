import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/drawer_width.dart';

final StateProvider<double> drawerWidthProvider = StateProvider<double>(
    // We return the default Drawer Width. Start value is not so important we
    // will define it later in MaterialApp build.
    (StateProviderRef<double> ref) {
  return drawerWidth();
});
