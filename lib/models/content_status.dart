/// Content readiness for categories and halls.
enum ContentStatus {
  live,
  expanding,
  preparing;

  String get label => switch (this) {
    ContentStatus.live => '운영 중',
    ContentStatus.expanding => '콘텐츠 확장 중',
    ContentStatus.preparing => '준비 중',
  };
}
