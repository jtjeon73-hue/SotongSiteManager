/// Synonym and related-keyword expansion for local search.
abstract final class SearchKeywords {
  static const Map<String, List<String>> synonyms = {
    '돈': ['금융', '저축', '가계', '자산'],
    '재테크': ['금융', '투자', '저축'],
    '차': ['자동차', '정비', '차량'],
    '자동차': ['차', '정비', '경고등'],
    '농기계': ['자동차', '정비', '트랙터'],
    '인공지능': ['AI', '프롬프트', 'LLM'],
    'AI': ['인공지능', '프롬프트', '챗봇'],
    '챗gpt': ['AI', '프롬프트', '인공지능'],
    '영어회화': ['생활영어', '회화', '영어'],
    '생활영어': ['영어', '회화', '문장'],
    '전기기사': ['전기', '자격증', '필기', '실기'],
    '자격증': ['전기기사', '시험', '필기'],
    '감전': ['전기', '안전'],
    '투자': ['금융', '주식', '위험'],
    '세금': ['금융', '연말정산'],
    '프롬프트': ['AI', '질문'],
    '경고등': ['자동차', '점검'],
    '회화': ['영어', '대화'],
    '병': ['건강', '질환', '증상'],
    '질병': ['건강', '질환', '증상'],
    '증상': ['건강', '질환', '검진'],
    '건강관리': ['건강', '생활습관', '예방'],
    '노후 건강': ['건강', '중장년', '예방'],
    '피엘씨': ['PLC', '자동화', '제어'],
    'plc': ['PLC', '피엘씨', '자동화'],
    '제어': ['PLC', '자동화', '센서'],
    '자동화': ['PLC', '공장 자동화', '제어'],
    '공장 자동화': ['PLC', '자동화', '제어'],
    '농사': ['스마트팜', '농업', '작물'],
    '농업': ['스마트팜', '농사', '센서'],
    '스마트농업': ['스마트팜', '농업', '센서'],
    '코딩': ['개발', '프로그래밍', 'Python'],
    '프로그램': ['개발', '프로그래밍', '코딩'],
    '프로그래밍': ['개발', '코딩', 'Flutter'],
    '앱 만들기': ['개발', 'Flutter', '코딩'],
    '웹개발': ['웹', 'Firebase', '배포', 'MFC'],
    '앱개발': ['앱', 'Flutter', 'APK', '배포'],
    'MFC': ['웹앱MFC', 'PLC', '배포', '개발'],
    'mfc': ['MFC', 'PLC', '개발'],
    'firebase 배포': ['웹개발', 'Firebase', '배포'],
    '시골': ['농촌', '귀촌', '지역'],
    '귀촌': ['농촌', '시골', '지역'],
    '지역': ['농촌', '마을', '지역발전'],
    '마을': ['농촌', '사매', '지역'],
    '센서': ['PLC', '스마트팜', '전기'],
    '통신': ['PLC', '개발', '자동화'],
    '데이터': ['개발', '스마트팜', 'AI'],
  };

  static const List<String> popularTopics = [
    'AI',
    '전기기사',
    '자동차 점검',
    '금융 기초',
    '생활영어',
    '건강',
    'PLC',
    '스마트팜',
    '코딩',
    'MFC',
    '웹개발',
    '농촌',
    '프롬프트',
    '센서',
  ];

  static const List<String> suggestedKeywords = [
    '인공지능',
    '돈',
    '차',
    '영어회화',
    '건강관리',
    '피엘씨',
    '스마트농업',
    '코딩',
    'MFC',
    '웹개발',
    '귀촌',
    '센서',
    '안전',
    '자격증',
  ];

  /// Expand query tokens with synonym mappings.
  static Set<String> expandTokens(Iterable<String> tokens) {
    final expanded = <String>{};
    for (final token in tokens) {
      final lower = token.toLowerCase();
      expanded.add(lower);
      synonyms.forEach((key, values) {
        if (key.toLowerCase() == lower ||
            values.any((v) => v.toLowerCase() == lower)) {
          expanded.add(key.toLowerCase());
          for (final value in values) {
            expanded.add(value.toLowerCase());
          }
        }
      });
    }
    return expanded;
  }
}
