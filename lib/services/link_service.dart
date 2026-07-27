import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens external knowledge sites safely in a new browser tab on web.
class LinkService {
  const LinkService();

  Future<bool> openExternal(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null || !(uri.isScheme('https') || uri.isScheme('http'))) {
      return false;
    }

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.platformDefault,
        webOnlyWindowName: '_blank',
      );
      return launched;
    } catch (error, stackTrace) {
      debugPrint('Failed to open $url: $error');
      debugPrintStack(stackTrace: stackTrace);
      return false;
    }
  }
}
