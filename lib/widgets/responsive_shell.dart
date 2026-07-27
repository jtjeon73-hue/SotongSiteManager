import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_colors.dart';
import '../utils/app_routes.dart';
import '../utils/breakpoints.dart';

class _NavItem {
  const _NavItem(this.label, this.path, this.icon);

  final String label;
  final String path;
  final IconData icon;
}

const _navItems = [
  _NavItem('홈', AppRoutes.home, Icons.home_outlined),
  _NavItem('전체 사이트', AppRoutes.sites, Icons.grid_view_outlined),
  _NavItem('분야별 지식', AppRoutes.categories, Icons.category_outlined),
  _NavItem('학습 길잡이', AppRoutes.learning, Icons.explore_outlined),
  _NavItem('통합 검색', AppRoutes.search, Icons.search),
  _NavItem('소개', AppRoutes.about, Icons.info_outline),
];

/// Responsive navigation shell for desktop rail / mobile drawer.
class ResponsiveShell extends StatelessWidget {
  const ResponsiveShell({required this.child, super.key});

  final Widget child;

  int _selectedIndex(String location) {
    final index = _navItems.indexWhere((item) {
      if (item.path == AppRoutes.home) {
        return location == AppRoutes.home;
      }
      return location.startsWith(item.path);
    });
    return index < 0 ? 0 : index;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final location = GoRouterState.of(context).uri.path;
    final selected = _selectedIndex(location);
    final isDesktop = Breakpoints.isDesktop(width);

    if (isDesktop) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: selected,
              extended: width >= 1280,
              backgroundColor: AppColors.surface,
              indicatorColor: AppColors.teal.withValues(alpha: 0.14),
              selectedIconTheme: const IconThemeData(color: AppColors.teal),
              selectedLabelTextStyle: const TextStyle(
                color: AppColors.navy,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelTextStyle: const TextStyle(
                color: AppColors.textSecondary,
              ),
              leading: Padding(
                padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
                child: Column(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.navy,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.hub_outlined,
                        color: Colors.white,
                      ),
                    ),
                    if (width >= 1280) ...[
                      const SizedBox(height: 12),
                      const Text(
                        '소통사이트매니저',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: AppColors.navy,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              onDestinationSelected: (index) =>
                  context.go(_navItems[index].path),
              destinations: [
                for (final item in _navItems)
                  NavigationRailDestination(
                    icon: Icon(item.icon),
                    selectedIcon: Icon(item.icon),
                    label: Text(item.label),
                  ),
              ],
            ),
            const VerticalDivider(width: 1),
            Expanded(child: child),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('소통사이트매니저'),
        actions: [
          Semantics(
            button: true,
            label: '통합 검색으로 이동',
            child: IconButton(
              tooltip: '통합 검색',
              onPressed: () => context.go(AppRoutes.search),
              icon: const Icon(Icons.search),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: AppColors.navy),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '소통사이트매니저',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Sotong Knowledge Manager',
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
              for (var i = 0; i < _navItems.length; i++)
                ListTile(
                  leading: Icon(_navItems[i].icon),
                  title: Text(_navItems[i].label),
                  selected: selected == i,
                  selectedTileColor: AppColors.teal.withValues(alpha: 0.12),
                  onTap: () {
                    Navigator.of(context).pop();
                    context.go(_navItems[i].path);
                  },
                ),
            ],
          ),
        ),
      ),
      body: child,
      bottomNavigationBar: width < 720
          ? NavigationBar(
              selectedIndex: selected.clamp(0, 3),
              onDestinationSelected: (index) {
                final mapped = switch (index) {
                  0 => AppRoutes.home,
                  1 => AppRoutes.sites,
                  2 => AppRoutes.learning,
                  _ => AppRoutes.search,
                };
                context.go(mapped);
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  label: '홈',
                ),
                NavigationDestination(
                  icon: Icon(Icons.grid_view_outlined),
                  label: '사이트',
                ),
                NavigationDestination(
                  icon: Icon(Icons.explore_outlined),
                  label: '길잡이',
                ),
                NavigationDestination(icon: Icon(Icons.search), label: '검색'),
              ],
            )
          : null,
    );
  }
}
