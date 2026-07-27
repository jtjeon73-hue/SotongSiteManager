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

  test('카탈로그에 5개 운영 사이트가 있다', () {
    expect(KnowledgeData.sites.where((s) => s.url.isNotEmpty).length, 5);
    expect(repository.liveSites.length, 5);
  });

  test('동의어 검색이 금융·영어를 찾는다', () {
    expect(
      repository.searchTyped('재테크').any((r) => r.siteId == 'finance'),
      isTrue,
    );
    expect(
      repository.searchTyped('영어회화').any((r) => r.siteId == 'english'),
      isTrue,
    );
  });

  test('잘못된 외부 URL이 없다', () {
    for (final site in repository.allSites) {
      expect(site.url.startsWith('https://'), isTrue);
      expect(site.url.contains(' '), isFalse);
    }
  });
}
