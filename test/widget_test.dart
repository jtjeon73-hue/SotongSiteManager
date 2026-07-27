import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sotong_site_manager/app.dart';
import 'package:sotong_site_manager/data/knowledge_data.dart';
import 'package:sotong_site_manager/models/difficulty_level.dart';
import 'package:sotong_site_manager/models/knowledge_site.dart';
import 'package:sotong_site_manager/models/recommendation.dart';
import 'package:sotong_site_manager/models/site_status.dart';
import 'package:sotong_site_manager/models/typed_search_result.dart';
import 'package:sotong_site_manager/services/site_repository.dart';
import 'package:sotong_site_manager/utils/app_routes.dart';

Widget _buildApp({SiteRepository? repository, String location = '/'}) {
  return SotongSiteManagerApp(
    repository: repository ?? SiteRepository(),
    router: createAppRouter(initialLocation: location),
  );
}

KnowledgeSite _sampleSite({
  String id = 'extra',
  String slug = 'extra',
  String name = '추가사이트',
}) {
  return KnowledgeSite(
    id: id,
    routeSlug: slug,
    name: name,
    shortName: '추가',
    description: '확장성 검증용',
    detailedDescription: '상세',
    categoryId: 'ai-digital',
    icon: Icons.book_outlined,
    color: const Color(0xFF0F766E),
    url: 'https://example.com',
    status: SiteStatus.live,
    targetUsers: const ['테스터'],
    difficulty: DifficultyLevel.beginner,
    topics: const ['테스트'],
    keywords: const ['테스트'],
    recommendedPath: const ['1단계'],
    sortOrder: 99,
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;

  testWidgets('앱이 기본 렌더링되고 브랜드를 보여준다', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1280, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();
    expect(find.textContaining('소통사이트매니저'), findsWidgets);
    expect(find.textContaining('세상의 중요한 지식을 쉽고 깊이 있게'), findsOneWidget);
  });

  testWidgets('5개 현재 사이트가 표시된다', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1280, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(_buildApp(location: AppRoutes.sites));
    await tester.pumpAndSettle();
    for (final site in KnowledgeData.sites) {
      expect(find.text(site.name), findsWidgets);
    }
    expect(KnowledgeData.sites.length, 5);
  });

  test('사이트 외부 주소가 정확하다', () {
    final urls = {for (final site in KnowledgeData.sites) site.id: site.url};
    expect(urls['ai-story'], 'https://sotongware-ai-story.web.app');
    expect(urls['elec'], 'https://sotong-elec.web.app');
    expect(urls['car'], 'https://sotong-car.web.app');
    expect(urls['finance'], 'https://sotong-finance.web.app');
    expect(urls['english'], 'https://sotong-language.web.app');
  });

  testWidgets('분야 필터가 선택한 분야 사이트만 보여준다', (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(_buildApp(location: AppRoutes.categories));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilterChip, '전기·기술'));
    await tester.pumpAndSettle();
    expect(find.text('소통전기'), findsWidgets);
    expect(find.text('소통카'), findsNothing);
  });

  testWidgets('통합 검색이 관련 사이트를 찾는다', (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(_buildApp(location: AppRoutes.search));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '전기기사');
    await tester.pumpAndSettle();
    expect(find.text('소통전기'), findsWidgets);
    expect(find.textContaining('관련 이유'), findsWidgets);
  });

  testWidgets('검색 결과 없음 상태를 안내한다', (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(_buildApp(location: AppRoutes.search));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '존재하지않는키워드XYZ');
    await tester.pumpAndSettle();
    expect(find.text('검색 결과가 없습니다'), findsOneWidget);
  });

  testWidgets('학습 목적별 추천을 보여준다', (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(_buildApp(location: AppRoutes.learning));
    await tester.pumpAndSettle();
    await tester.tap(find.text('AI를 제대로 이해하고 활용하고 싶어요'));
    await tester.pumpAndSettle();
    expect(find.text('소통AI스토리'), findsWidgets);
  });

  testWidgets('모바일 360px에서 overflow가 없다', (tester) async {
    await tester.binding.setSurfaceSize(const Size(360, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final errors = <FlutterErrorDetails>[];
    final oldHandler = FlutterError.onError;
    FlutterError.onError = (details) {
      if (details.toString().contains('overflowed')) {
        errors.add(details);
      }
      oldHandler?.call(details);
    };
    addTearDown(() => FlutterError.onError = oldHandler);
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();
    expect(errors, isEmpty);
    await tester.pumpWidget(_buildApp(location: AppRoutes.sites));
    await tester.pumpAndSettle();
    expect(errors, isEmpty);
  });

  testWidgets('긴 한글 제목을 줄바꿈으로 표시한다', (tester) async {
    await tester.binding.setSurfaceSize(const Size(360, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    const longName = '아주긴한글제목의전문지식사이트이름테스트용명칭입니다';
    final repo = SiteRepository(
      sites: [
        ...KnowledgeData.sites,
        _sampleSite(name: longName),
      ],
    );
    await tester.pumpWidget(
      _buildApp(repository: repo, location: AppRoutes.sites),
    );
    await tester.pumpAndSettle();
    expect(find.text(longName), findsOneWidget);
    final textWidget = tester.widget<Text>(find.text(longName));
    expect(textWidget.softWrap, isTrue);
  });

  testWidgets('주요 라우트에 접근할 수 있다', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1280, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final routes = [
      AppRoutes.home,
      AppRoutes.sites,
      AppRoutes.categories,
      AppRoutes.learning,
      AppRoutes.find,
      AppRoutes.search,
      AppRoutes.about,
    ];
    for (final route in routes) {
      await tester.pumpWidget(_buildApp(location: route));
      await tester.pumpAndSettle();
      expect(find.byType(MaterialApp), findsOneWidget);
    }
    await tester.pumpWidget(_buildApp(location: AppRoutes.about));
    await tester.pumpAndSettle();
    expect(find.textContaining('왜 이 플랫폼을 만들었는가'), findsOneWidget);
  });

  testWidgets('데이터에 사이트를 추가하면 관련 화면에 반영된다', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1100, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final repo = SiteRepository(
      sites: [
        ...KnowledgeData.sites,
        _sampleSite(id: 'health-demo', slug: 'health', name: '소통건강'),
      ],
    );
    await tester.pumpWidget(
      _buildApp(repository: repo, location: AppRoutes.sites),
    );
    await tester.pumpAndSettle();
    expect(find.text('소통건강'), findsWidgets);
  });

  test('5개 전문관 상세 데이터와 slug가 유효하다', () {
    final repo = SiteRepository();
    expect(repo.liveSites.length, 5);
    for (final site in repo.liveSites) {
      expect(site.routeSlug, isNotEmpty);
      expect(site.coreQuestion, isNotEmpty);
      expect(site.safetyNotice, isNotEmpty);
      expect(site.beginnerFocus, isNotEmpty);
      expect(site.menuHighlights, isNotEmpty);
      expect(site.url.startsWith('https://'), isTrue);
    }
    expect(repo.findSiteBySlug('electric')?.id, 'elec');
    expect(repo.findSiteBySlug('language')?.id, 'english');
  });

  testWidgets('전문관 상세 라우트와 필수 섹션을 표시한다', (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _buildApp(location: AppRoutes.siteDetail('electric')),
    );
    await tester.pumpAndSettle();
    expect(find.text('소통전기'), findsWidgets);
    expect(find.text('전문관 소개'), findsOneWidget);
    expect(find.text('이 지식이 중요한 이유'), findsOneWidget);
    expect(find.text('안전·책임 안내'), findsOneWidget);
    expect(find.text('기초 · 중급 · 심화'), findsOneWidget);
  });

  testWidgets('지식 찾기 선택 과정과 추천 결과를 보여준다', (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(_buildApp(location: AppRoutes.find));
    await tester.pumpAndSettle();
    await tester.tap(find.text('자격증·학습'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('처음 시작'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('장기적으로 체계적 학습'));
    await tester.pumpAndSettle();
    expect(find.text('가장 잘 맞는 전문관'), findsOneWidget);
    expect(find.text('소통전기'), findsWidgets);
    expect(find.textContaining('규칙 기반'), findsWidgets);
  });

  test('목적·수준·시간별 추천 결과가 달라질 수 있다', () {
    final repo = SiteRepository();
    final a = repo.recommend(
      const RecommendationProfile(
        purpose: RecommendationPurpose.examStudy,
        level: RecommendationLevel.firstStart,
        timeBudget: RecommendationTime.longTerm,
      ),
    );
    final b = repo.recommend(
      const RecommendationProfile(
        purpose: RecommendationPurpose.hobbyCulture,
        level: RecommendationLevel.firstStart,
        timeBudget: RecommendationTime.tenMinutes,
      ),
    );
    final c = repo.recommend(
      const RecommendationProfile(
        purpose: RecommendationPurpose.dailyLife,
        level: RecommendationLevel.someKnowledge,
        timeBudget: RecommendationTime.weekend,
      ),
    );
    expect(a.primarySiteId, 'elec');
    expect(b.primarySiteId, 'english');
    expect(c.primarySiteId, 'car');
    expect(
      {a.primarySiteId, b.primarySiteId, c.primarySiteId}.length,
      greaterThan(1),
    );
  });

  test('학습 코스 데이터 무결성', () {
    final repo = SiteRepository();
    expect(repo.learningPaths.length, greaterThanOrEqualTo(8));
    for (final path in repo.learningPaths) {
      expect(path.steps.length, inInclusiveRange(3, 6));
      expect(path.siteIds, isNotEmpty);
      for (final id in path.siteIds) {
        expect(repo.findSiteById(id), isNotNull);
      }
    }
  });

  test('검색 결과 유형 구분과 동의어 검색', () {
    final repo = SiteRepository();
    final money = repo.searchTyped('돈');
    expect(money.any((r) => r.siteId == 'finance'), isTrue);
    final ai = repo.searchTyped('인공지능');
    expect(ai.any((r) => r.siteId == 'ai-story'), isTrue);
    final types = money.map((r) => r.type).toSet();
    expect(types.contains(SearchResultType.hall), isTrue);
  });

  test('준비 중 분야 상태와 중복 ID 방지', () {
    final repo = SiteRepository();
    final preparing = repo.categories
        .where((c) => c.contentStatus.label == '준비 중')
        .toList();
    expect(preparing, isNotEmpty);
    final ids = repo.allSites.map((s) => s.id).toList();
    expect(ids.toSet().length, ids.length);
    final slugs = repo.allSites.map((s) => s.routeSlug).toList();
    expect(slugs.toSet().length, slugs.length);
  });

  testWidgets('홈 핵심 행동 버튼이 보인다', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();
    expect(find.text('내게 맞는 지식 찾기'), findsWidgets);
    expect(find.text('분야별 둘러보기'), findsOneWidget);
    expect(find.text('전체 전문 사이트 보기'), findsOneWidget);
  });
}
