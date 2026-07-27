import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sotong_site_manager/app.dart';
import 'package:sotong_site_manager/data/knowledge_data.dart';
import 'package:sotong_site_manager/models/difficulty_level.dart';
import 'package:sotong_site_manager/models/knowledge_site.dart';
import 'package:sotong_site_manager/models/site_status.dart';
import 'package:sotong_site_manager/services/site_repository.dart';
import 'package:sotong_site_manager/utils/app_routes.dart';

Widget _buildApp({SiteRepository? repository, String location = '/'}) {
  return SotongSiteManagerApp(
    repository: repository ?? SiteRepository(),
    router: createAppRouter(initialLocation: location),
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
    await tester.binding.setSurfaceSize(const Size(900, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(_buildApp(location: AppRoutes.learning));
    await tester.pumpAndSettle();

    await tester.tap(find.text('AI를 처음 배우고 싶어요'));
    await tester.pumpAndSettle();

    expect(find.text('추천 학습 순서'), findsOneWidget);
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
    final custom = KnowledgeSite(
      id: 'long-title',
      name: longName,
      shortName: '긴제목',
      description: '긴 제목 줄바꿈 확인용 설명입니다.',
      detailedDescription: '상세 설명',
      categoryId: 'ai-digital',
      icon: Icons.book_outlined,
      color: const Color(0xFF0F766E),
      url: 'https://example.com',
      status: SiteStatus.live,
      targetUsers: const ['테스터'],
      difficulty: DifficultyLevel.beginner,
      topics: const ['테스트'],
      keywords: const ['긴제목'],
      recommendedPath: const ['1단계'],
      sortOrder: 99,
    );

    final repo = SiteRepository(sites: [...KnowledgeData.sites, custom]);

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
    expect(find.textContaining('왜 만들었나요'), findsOneWidget);
  });

  testWidgets('데이터에 사이트를 추가하면 관련 화면에 반영된다', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1100, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    const extra = KnowledgeSite(
      id: 'health-demo',
      name: '소통건강',
      shortName: '건강',
      description: '생활 건강 지식을 쉽게 안내하는 준비 사이트',
      detailedDescription: '확장성 검증용 상세 설명',
      categoryId: 'health-life',
      icon: Icons.favorite_outline,
      color: Color(0xFFB42318),
      url: 'https://example.com/health',
      status: SiteStatus.live,
      targetUsers: ['입문자'],
      difficulty: DifficultyLevel.beginner,
      topics: ['수면', '운동'],
      keywords: ['건강', '생활'],
      recommendedPath: ['기초 이해'],
      featured: true,
      sortOrder: 20,
    );

    final repo = SiteRepository(sites: [...KnowledgeData.sites, extra]);

    await tester.pumpWidget(
      _buildApp(repository: repo, location: AppRoutes.sites),
    );
    await tester.pumpAndSettle();
    expect(find.text('소통건강'), findsWidgets);

    await tester.pumpWidget(
      _buildApp(repository: repo, location: '${AppRoutes.search}?q=건강'),
    );
    await tester.pumpAndSettle();
    expect(find.text('소통건강'), findsWidgets);
  });
}
