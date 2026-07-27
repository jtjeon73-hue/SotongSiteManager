import 'package:flutter/material.dart';

import '../data/knowledge_data.dart';
import '../data/recommendation_rules.dart';
import '../data/search_keywords.dart';
import '../models/featured_knowledge.dart';
import '../models/knowledge_category.dart';
import '../models/knowledge_path.dart';
import '../models/knowledge_site.dart';
import '../models/learning_goal.dart';
import '../models/recommendation.dart';
import '../models/related_knowledge.dart';
import '../models/search_result.dart';
import '../models/site_status.dart';
import '../models/typed_search_result.dart';
import '../utils/app_routes.dart';
import 'search_service.dart';

class SiteRepository {
  SiteRepository({
    List<KnowledgeSite>? sites,
    List<KnowledgeCategory>? categories,
    List<LearningGoal>? goals,
    List<FeaturedKnowledge>? featured,
    List<KnowledgePath>? paths,
    List<RelatedKnowledge>? related,
    SearchService? searchService,
  }) : _sites = List.unmodifiable(sites ?? KnowledgeData.sites),
       _categories = List.unmodifiable(categories ?? KnowledgeData.categories),
       _goals = List.unmodifiable(goals ?? KnowledgeData.learningGoals),
       _featured = List.unmodifiable(
         featured ?? KnowledgeData.featuredKnowledge,
       ),
       _paths = List.unmodifiable(paths ?? KnowledgeData.learningPaths),
       _related = List.unmodifiable(related ?? KnowledgeData.relatedKnowledge),
       _searchService = searchService ?? const SearchService() {
    _assertIntegrity();
  }

  final List<KnowledgeSite> _sites;
  final List<KnowledgeCategory> _categories;
  final List<LearningGoal> _goals;
  final List<FeaturedKnowledge> _featured;
  final List<KnowledgePath> _paths;
  final List<RelatedKnowledge> _related;
  final SearchService _searchService;

  void _assertIntegrity() {
    final siteIds = <String>{};
    final slugs = <String>{};
    for (final site in _sites) {
      assert(siteIds.add(site.id), 'Duplicate site id: ${site.id}');
      assert(slugs.add(site.routeSlug), 'Duplicate slug: ${site.routeSlug}');
      assert(site.url.startsWith('https://'), 'Non-https URL for ${site.id}');
    }
    final categoryIds = _categories.map((c) => c.id).toSet();
    for (final site in _sites) {
      assert(
        categoryIds.contains(site.categoryId),
        'Unknown category ${site.categoryId} for ${site.id}',
      );
      for (final relatedId in site.relatedSiteIds) {
        assert(
          siteIds.contains(relatedId),
          'Unknown related site $relatedId for ${site.id}',
        );
      }
    }
    for (final path in _paths) {
      for (final id in path.siteIds) {
        assert(siteIds.contains(id), 'Path ${path.id} unknown site $id');
      }
      for (final id in path.relatedSiteIds) {
        assert(
          siteIds.contains(id),
          'Path ${path.id} unknown related site $id',
        );
      }
      assert(
        path.steps.length >= 3 && path.steps.length <= 6,
        'Path ${path.id} must have 3-6 steps',
      );
    }
    for (final item in _related) {
      assert(
        siteIds.contains(item.fromSiteId),
        'Related ${item.id} unknown from ${item.fromSiteId}',
      );
      assert(
        siteIds.contains(item.toSiteId),
        'Related ${item.id} unknown to ${item.toSiteId}',
      );
    }
    for (final site in _sites) {
      for (final catId in site.secondaryCategoryIds) {
        assert(
          categoryIds.contains(catId),
          'Unknown secondary category $catId for ${site.id}',
        );
      }
    }
    for (final group in KnowledgeData.homeGroups) {
      for (final id in group.siteIds) {
        assert(siteIds.contains(id), 'Home group ${group.id} unknown site $id');
      }
    }
  }

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
  List<KnowledgePath> get learningPaths {
    final sorted = [..._paths]
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    return List.unmodifiable(sorted);
  }

  List<RelatedKnowledge> get relatedKnowledge => _related;

  KnowledgeSite? findSiteById(String id) {
    for (final site in _sites) {
      if (site.id == id) return site;
    }
    return null;
  }

  KnowledgeSite? findSiteBySlug(String slug) {
    for (final site in _sites) {
      if (site.routeSlug == slug) return site;
    }
    return null;
  }

  KnowledgeCategory? findCategoryById(String id) {
    for (final category in _categories) {
      if (category.id == id) return category;
    }
    return null;
  }

  LearningGoal? findGoalById(String id) {
    for (final goal in _goals) {
      if (goal.id == id) return goal;
    }
    return null;
  }

  KnowledgePath? findPathById(String id) {
    for (final path in _paths) {
      if (path.id == id) return path;
    }
    return null;
  }

  List<KnowledgeSite> sitesByCategory(String categoryId) =>
      allSites.where((site) => site.categoryId == categoryId).toList();

  List<KnowledgeSite> sitesForGoal(LearningGoal goal) =>
      goal.siteIds.map(findSiteById).whereType<KnowledgeSite>().toList();

  List<KnowledgeSite> sitesForPath(KnowledgePath path) =>
      path.siteIds.map(findSiteById).whereType<KnowledgeSite>().toList();

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

  String hallRoute(KnowledgeSite site) => AppRoutes.siteDetail(site.routeSlug);

  List<SearchResult> search(String query) => _searchService.search(
    query: query,
    sites: allSites,
    categories: categories,
  );

  List<TypedSearchResult> searchTyped(String query) =>
      _searchService.searchTyped(
        query: query,
        sites: allSites,
        categories: categories,
        goals: learningGoals,
        paths: learningPaths,
      );

  RecommendationResult recommend(RecommendationProfile profile) =>
      RecommendationRules.recommend(profile);

  List<String> get popularSearchTopics => SearchKeywords.popularTopics;
  List<String> get suggestedSearchKeywords => SearchKeywords.suggestedKeywords;
}
