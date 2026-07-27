import 'package:flutter/material.dart';

/// Cross-site learning bridge shown on home and hall detail.
@immutable
class RelatedKnowledge {
  const RelatedKnowledge({
    required this.id,
    required this.title,
    required this.description,
    required this.fromSiteId,
    required this.toSiteId,
    required this.keywords,
  });

  final String id;
  final String title;
  final String description;
  final String fromSiteId;
  final String toSiteId;
  final List<String> keywords;
}
