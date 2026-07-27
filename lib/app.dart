import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screens/about_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/home_screen.dart';
import 'screens/learning_guide_screen.dart';
import 'screens/search_screen.dart';
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
          ),
          GoRoute(
            path: AppRoutes.categories,
            name: 'categories',
            builder: (context, state) => const CategoriesScreen(),
          ),
          GoRoute(
            path: AppRoutes.learning,
            name: 'learning',
            builder: (context, state) => const LearningGuideScreen(),
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
