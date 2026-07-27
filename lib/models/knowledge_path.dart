import 'package:flutter/material.dart';

/// A learning course composed of ordered steps.
@immutable
class KnowledgePath {
  const KnowledgePath({
    required this.id,
    required this.title,
    required this.purpose,
    required this.targetUsers,
    required this.durationLabel,
    required this.dailyMinutesLabel,
    required this.steps,
    required this.siteIds,
    required this.keywords,
    required this.icon,
    this.sortOrder = 0,
  });

  final String id;
  final String title;
  final String purpose;
  final List<String> targetUsers;
  final String durationLabel;
  final String dailyMinutesLabel;
  final List<KnowledgeStep> steps;
  final List<String> siteIds;
  final List<String> keywords;
  final IconData icon;
  final int sortOrder;
}

@immutable
class KnowledgeStep {
  const KnowledgeStep({
    required this.title,
    required this.reason,
    this.hint = '',
  });

  final String title;
  final String reason;
  final String hint;
}
