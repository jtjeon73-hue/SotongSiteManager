import 'package:flutter_test/flutter_test.dart';
import 'package:sotong_site_manager/data/knowledge_data.dart';
import 'package:sotong_site_manager/services/search_service.dart';
import 'package:sotong_site_manager/services/site_repository.dart';

void main() {
  final repository = SiteRepository();
  const search = SearchService();

  test('빈 검색어는 빈 결과를 반환한다', () {
    expect(
      search.search(
        query: '   ',
        sites: repository.allSites,
        categories: repository.categories,
      ),
      isEmpty,
    );
  });

  test('키워드 검색은 관련 사이트를 점수순으로 반환한다', () {
    final results = repository.search('자동차 배터리');
    expect(results, isNotEmpty);
    expect(results.first.site.id, 'car');
    expect(results.first.reasons, isNotEmpty);
  });

  test('카탈로그에 12개 운영 사이트가 있다', () {
    expect(KnowledgeData.sites.where((s) => s.url.isNotEmpty).length, 12);
    expect(repository.liveSites.length, 12);
  });

  test('동의어 검색이 금융·영어·신규 분야를 찾는다', () {
    expect(
      repository.searchTyped('재테크').any((r) => r.siteId == 'finance'),
      isTrue,
    );
    expect(
      repository.searchTyped('영어회화').any((r) => r.siteId == 'english'),
      isTrue,
    );
    expect(
      repository.searchTyped('코딩').any((r) => r.siteId == 'development'),
      isTrue,
    );
    expect(
      repository.searchTyped('MFC').any((r) => r.siteId == 'web-app-dev'),
      isTrue,
    );
    expect(
      repository.searchTyped('웹개발').any((r) => r.siteId == 'web-app-dev'),
      isTrue,
    );
    expect(
      repository.searchTyped('스마트농업').any((r) => r.siteId == 'smart-farm'),
      isTrue,
    );
    expect(
      repository.searchTyped('귀촌').any((r) => r.siteId == 'country-ai'),
      isTrue,
    );
    expect(
      repository.searchTyped('소통노후').any((r) => r.siteId == 'save-live'),
      isTrue,
    );
    expect(
      repository.searchTyped('노후 준비').any((r) => r.siteId == 'save-live'),
      isTrue,
    );
    expect(
      repository
          .searchTyped('SotongSaveLive')
          .any((r) => r.siteId == 'save-live'),
      isTrue,
    );
    expect(
      repository.searchTyped('자녀 없는 부부').any((r) => r.siteId == 'save-live'),
      isTrue,
    );
    expect(
      repository.searchTyped('장기요양').any((r) => r.siteId == 'save-live'),
      isTrue,
    );
    final sensor = repository.searchTyped('센서');
    expect(sensor.any((r) => r.siteId == 'plc'), isTrue);
    expect(sensor.any((r) => r.siteId == 'smart-farm'), isTrue);
  });

  test('잘못된 외부 URL이 없다', () {
    for (final site in repository.allSites) {
      expect(site.url.startsWith('https://'), isTrue);
      expect(site.url.contains(' '), isFalse);
    }
  });
}
