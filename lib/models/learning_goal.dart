import 'package:flutter/material.dart';

/// A learner goal that maps to recommended sites and a study order.
@immutable
class LearningGoal {
  const LearningGoal({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.siteIds,
    required this.learningOrder,
    required this.tips,
    this.keywords = const [],
  });

  final String id;
  final String title;
  final String description;
  final IconData icon;
  final List<String> siteIds;
  final List<String> learningOrder;
  final List<String> tips;
  final List<String> keywords;
}
