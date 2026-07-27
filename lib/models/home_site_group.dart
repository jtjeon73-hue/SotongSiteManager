import 'package:flutter/material.dart';

/// Home grouping for many halls without a flat 10-card dump.
@immutable
class HomeSiteGroup {
  const HomeSiteGroup({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.siteIds,
  });

  final String id;
  final String title;
  final String subtitle;

  /// Site ids that belong to this home section (a site may appear in multiple).
  final List<String> siteIds;
}
