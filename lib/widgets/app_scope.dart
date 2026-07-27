import 'package:flutter/material.dart';

import '../services/link_service.dart';
import '../services/site_repository.dart';

/// Provides shared services to the widget tree.
class AppScope extends InheritedWidget {
  const AppScope({
    required this.repository,
    required this.linkService,
    required super.child,
    super.key,
  });

  final SiteRepository repository;
  final LinkService linkService;

  static AppScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope not found in context');
    return scope!;
  }

  static SiteRepository repositoryOf(BuildContext context) =>
      of(context).repository;

  static LinkService linkServiceOf(BuildContext context) =>
      of(context).linkService;

  @override
  bool updateShouldNotify(AppScope oldWidget) {
    return repository != oldWidget.repository ||
        linkService != oldWidget.linkService;
  }
}
