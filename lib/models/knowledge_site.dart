import 'package:flutter/material.dart';

import 'difficulty_level.dart';
import 'site_status.dart';

/// A linked specialist knowledge hall in the Sotong ecosystem.
@immutable
class KnowledgeSite {
  const KnowledgeSite({
    required this.id,
    required this.routeSlug,
    required this.name,
    required this.shortName,
    required this.description,
    required this.detailedDescription,
    required this.categoryId,
    required this.icon,
    required this.color,
    required this.url,
    required this.status,
    required this.targetUsers,
    required this.difficulty,
    required this.topics,
    required this.keywords,
    required this.recommendedPath,
    required this.sortOrder,
    this.featured = false,
    this.learningOutcomes = const [],
    this.whyMatters = '',
    this.coreQuestion = '',
    this.valueProposition = '',
    this.startPoint = '',
    this.menuHighlights = const [],
    this.beginnerFocus = const [],
    this.intermediateFocus = const [],
    this.advancedFocus = const [],
    this.useCases = const [],
    this.safetyNotice = '',
    this.relatedSiteIds = const [],
    this.confirmedFeatures = const [],
  });

  final String id;

  /// Public URL slug under `/sites/:slug` (e.g. electric, language).
  final String routeSlug;
  final String name;
  final String shortName;
  final String description;
  final String detailedDescription;
  final String categoryId;
  final IconData icon;
  final Color color;
  final String url;
  final SiteStatus status;
  final List<String> targetUsers;
  final DifficultyLevel difficulty;
  final List<String> topics;
  final List<String> keywords;
  final List<String> recommendedPath;
  final bool featured;
  final int sortOrder;
  final List<String> learningOutcomes;
  final String whyMatters;
  final String coreQuestion;
  final String valueProposition;
  final String startPoint;
  final List<String> menuHighlights;
  final List<String> beginnerFocus;
  final List<String> intermediateFocus;
  final List<String> advancedFocus;
  final List<String> useCases;
  final String safetyNotice;
  final List<String> relatedSiteIds;
  final List<String> confirmedFeatures;

  bool get isLive => status == SiteStatus.live && url.isNotEmpty;

  KnowledgeSite copyWith({
    String? id,
    String? routeSlug,
    String? name,
    String? shortName,
    String? description,
    String? detailedDescription,
    String? categoryId,
    IconData? icon,
    Color? color,
    String? url,
    SiteStatus? status,
    List<String>? targetUsers,
    DifficultyLevel? difficulty,
    List<String>? topics,
    List<String>? keywords,
    List<String>? recommendedPath,
    bool? featured,
    int? sortOrder,
    List<String>? learningOutcomes,
    String? whyMatters,
    String? coreQuestion,
    String? valueProposition,
    String? startPoint,
    List<String>? menuHighlights,
    List<String>? beginnerFocus,
    List<String>? intermediateFocus,
    List<String>? advancedFocus,
    List<String>? useCases,
    String? safetyNotice,
    List<String>? relatedSiteIds,
    List<String>? confirmedFeatures,
  }) {
    return KnowledgeSite(
      id: id ?? this.id,
      routeSlug: routeSlug ?? this.routeSlug,
      name: name ?? this.name,
      shortName: shortName ?? this.shortName,
      description: description ?? this.description,
      detailedDescription: detailedDescription ?? this.detailedDescription,
      categoryId: categoryId ?? this.categoryId,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      url: url ?? this.url,
      status: status ?? this.status,
      targetUsers: targetUsers ?? this.targetUsers,
      difficulty: difficulty ?? this.difficulty,
      topics: topics ?? this.topics,
      keywords: keywords ?? this.keywords,
      recommendedPath: recommendedPath ?? this.recommendedPath,
      featured: featured ?? this.featured,
      sortOrder: sortOrder ?? this.sortOrder,
      learningOutcomes: learningOutcomes ?? this.learningOutcomes,
      whyMatters: whyMatters ?? this.whyMatters,
      coreQuestion: coreQuestion ?? this.coreQuestion,
      valueProposition: valueProposition ?? this.valueProposition,
      startPoint: startPoint ?? this.startPoint,
      menuHighlights: menuHighlights ?? this.menuHighlights,
      beginnerFocus: beginnerFocus ?? this.beginnerFocus,
      intermediateFocus: intermediateFocus ?? this.intermediateFocus,
      advancedFocus: advancedFocus ?? this.advancedFocus,
      useCases: useCases ?? this.useCases,
      safetyNotice: safetyNotice ?? this.safetyNotice,
      relatedSiteIds: relatedSiteIds ?? this.relatedSiteIds,
      confirmedFeatures: confirmedFeatures ?? this.confirmedFeatures,
    );
  }
}
