import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screens/about_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/find_knowledge_screen.dart';
import 'screens/home_screen.dart';
import 'screens/learning_guide_screen.dart';
import 'screens/search_screen.dart';
import 'screens/site_detail_screen.dart';
import 'screens/sites_screen.dart';
import 'services/link_service.dart';
import 'services/site_repository.dart';
import 'theme/app_theme.dart';
import 'utils/app_routes.dart';
import 'widgets/app_scope.dart';
import 'widgets/responsive_shell.dart';

GoRouter createAppRouter({String initialLocation = AppRoutes.home}) {
  return GoRouter(
    initialLocation: initialLocation,
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('페이지를 찾을 수 없습니다'),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => context.go(AppRoutes.home),
                child: const Text('홈으로'),
              ),
            ],
          ),
        ),
      ),
    ),
    routes: [
      ShellRoute(
        builder: (context, state, child) => ResponsiveShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            name: 'home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: AppRoutes.sites,
            name: 'sites',
            builder: (context, state) => const SitesScreen(),
            routes: [
              GoRoute(
                path: ':slug',
                name: 'site-detail',
                builder: (context, state) {
                  final slug = state.pathParameters['slug'] ?? '';
                  return SiteDetailScreen(slug: slug);
                },
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.categories,
            name: 'categories',
            builder: (context, state) => const CategoriesScreen(),
          ),
          GoRoute(
            path: AppRoutes.learning,
            name: 'learning',
            builder: (context, state) {
              final course = state.uri.queryParameters['course'];
              return LearningGuideScreen(initialCourseId: course);
            },
          ),
          GoRoute(
            path: AppRoutes.find,
            name: 'find',
            builder: (context, state) => const FindKnowledgeScreen(),
          ),
          GoRoute(
            path: AppRoutes.search,
            name: 'search',
            builder: (context, state) {
              final q = state.uri.queryParameters['q'] ?? '';
              return SearchScreen(initialQuery: q);
            },
          ),
          GoRoute(
            path: AppRoutes.about,
            name: 'about',
            builder: (context, state) => const AboutScreen(),
          ),
        ],
      ),
    ],
  );
}

class SotongSiteManagerApp extends StatelessWidget {
  SotongSiteManagerApp({
    super.key,
    SiteRepository? repository,
    LinkService? linkService,
    GoRouter? router,
  }) : repository = repository ?? SiteRepository(),
       linkService = linkService ?? const LinkService(),
       router = router ?? createAppRouter();

  final SiteRepository repository;
  final LinkService linkService;
  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return AppScope(
      repository: repository,
      linkService: linkService,
      child: MaterialApp.router(
        title: '소통사이트매니저',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        routerConfig: router,
      ),
    );
  }
}
