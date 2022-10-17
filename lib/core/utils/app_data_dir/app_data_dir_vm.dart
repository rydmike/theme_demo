import 'dart:io' show Directory;

import 'package:path_provider/path_provider.dart' as path_provider;

/// The [getAppDataDir] is a custom made folder/directory getter for different
/// platforms, it uses package path_provider.dart.
///
/// The "Directory" function and importing "dart.io" is not supported on
/// Flutter WEB builds. This will only be imported on VM platforms that support
/// compiling them, which is all except the WEB platform.
Future<String> getAppDataDir() async {
  final Directory dir = await path_provider.getApplicationSupportDirectory();
  return dir.path;
}
