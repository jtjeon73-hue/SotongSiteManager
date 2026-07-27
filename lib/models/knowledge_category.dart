import 'package:flutter/material.dart';

import 'site_status.dart';

/// Expandable knowledge category used across discovery screens.
@immutable
class KnowledgeCategory {
  const KnowledgeCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.futureDirection,
    required this.icon,
    required this.color,
    required this.sortOrder,
    this.status = SiteStatus.preparing,
    this.keywords = const [],
  });

  final String id;
  final String name;
  final String description;
  final String futureDirection;
  final IconData icon;
  final Color color;
  final int sortOrder;
  final SiteStatus status;
  final List<String> keywords;
}
