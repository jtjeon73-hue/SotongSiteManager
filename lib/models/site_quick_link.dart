import 'package:flutter/material.dart';

/// Verified deep link into a specialist site's public routes.
@immutable
class SiteQuickLink {
  const SiteQuickLink({required this.label, required this.url});

  final String label;
  final String url;
}
