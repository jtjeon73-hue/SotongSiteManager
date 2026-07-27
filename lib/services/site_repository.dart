import 'package:flutter/material.dart';

import '../data/knowledge_data.dart';
import '../models/featured_knowledge.dart';
import '../models/knowledge_category.dart';
import '../models/knowledge_site.dart';
import '../models/learning_goal.dart';
import '../models/search_result.dart';
import '../models/site_status.dart';
import 'search_service.dart';

/// Single source of truth for local knowledge catalog queries.
class SiteRepository {
  SiteRepository({
    List<KnowledgeSite>? sites,
    List<KnowledgeCategory>? categories,
    List<LearningGoal>? goals,
    List<FeaturedKnowledge>? featured,
    SearchService? searchService,
  }) : _sites = List.unmodifiable(sites ?? KnowledgeData.sites),
       _categories = List.unmodifiable(categories ?? KnowledgeData.categories),
       _goals = List.unmodifiable(goals ?? KnowledgeData.learningGoals),
       _featured = List.unmodifiable(
         featured ?? KnowledgeData.featuredKnowledge,
       ),
       _searchService = searchService ?? const SearchService();

  final List<KnowledgeSite> _sites;
  final List<KnowledgeCategory> _categories;
  final List<LearningGoal> _goals;
  final List<FeaturedKnowledge> _featured;
  final SearchService _searchService;

  List<KnowledgeSite> get allSites {
    final sorted = [..._sites]
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    return List.unmodifiable(sorted);
  }

  List<KnowledgeSite> get liveSites =>
      allSites.where((site) => site.status == SiteStatus.live).toList();

  List<KnowledgeSite> get featuredSites =>
      allSites.where((site) => site.featured).toList();

  List<KnowledgeCategory> get categories {
    final sorted = [..._categories]
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    return List.unmodifiable(sorted);
  }

  List<LearningGoal> get learningGoals => _goals;

  List<FeaturedKnowledge> get featuredKnowledge => _featured;

  List<FeaturedKnowledge> get recentKnowledge =>
      _featured.where((item) => item.isNew).toList();

  KnowledgeSite? findSiteById(String id) {
    for (final site in _sites) {
      if (site.id == id) {
        return site;
      }
    }
    return null;
  }

  KnowledgeCategory? findCategoryById(String id) {
    for (final category in _categories) {
      if (category.id == id) {
        return category;
      }
    }
    return null;
  }

  LearningGoal? findGoalById(String id) {
    for (final goal in _goals) {
      if (goal.id == id) {
        return goal;
      }
    }
    return null;
  }

  List<KnowledgeSite> sitesByCategory(String categoryId) {
    return allSites.where((site) => site.categoryId == categoryId).toList();
  }

  List<KnowledgeSite> sitesForGoal(LearningGoal goal) {
    return goal.siteIds.map(findSiteById).whereType<KnowledgeSite>().toList();
  }

  KnowledgeCategory categoryForSite(KnowledgeSite site) {
    return findCategoryById(site.categoryId) ??
        const KnowledgeCategory(
          id: 'unknown',
          name: '기타',
          description: '분류 정보가 아직 연결되지 않은 항목입니다.',
          futureDirection: '카테고리 메타데이터를 보강합니다.',
          icon: Icons.category_outlined,
          color: Color(0xFF5C6B7A),
          sortOrder: 999,
        );
  }

  List<SearchResult> search(String query) {
    return _searchService.search(
      query: query,
      sites: allSites,
      categories: categories,
    );
  }
}
