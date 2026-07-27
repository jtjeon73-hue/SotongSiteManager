import 'package:flutter/material.dart';

import 'content_status.dart';
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
    this.contentStatus = ContentStatus.preparing,
    this.keywords = const [],
    this.audienceHint = '',
    this.whyNeeded = '',
  });

  final String id;
  final String name;
  final String description;
  final String futureDirection;
  final IconData icon;
  final Color color;
  final int sortOrder;
  final SiteStatus status;
  final ContentStatus contentStatus;
  final List<String> keywords;
  final String audienceHint;
  final String whyNeeded;
}
