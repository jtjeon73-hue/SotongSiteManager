/// Operating status of a knowledge site.
enum SiteStatus {
  live,
  preparing,
  planned;

  String get label => switch (this) {
    SiteStatus.live => '운영 중',
    SiteStatus.preparing => '준비 중',
    SiteStatus.planned => '계획 중',
  };
}
