import 'package:flutter/material.dart';

/// A curated knowledge highlight shown on the home screen.
@immutable
class FeaturedKnowledge {
  const FeaturedKnowledge({
    required this.id,
    required this.title,
    required this.summary,
    required this.whyItMatters,
    required this.siteId,
    required this.categoryId,
    required this.tags,
    this.isNew = false,
  });

  final String id;
  final String title;
  final String summary;
  final String whyItMatters;
  final String siteId;
  final String categoryId;
  final List<String> tags;
  final bool isNew;
}
