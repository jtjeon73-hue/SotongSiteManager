import '../models/recommendation.dart';
import '../models/related_knowledge.dart';

/// Rule-based recommendations. Not generative AI.
abstract final class RecommendationRules {
  static RecommendationResult recommend(RecommendationProfile profile) {
    final purpose = profile.purpose;
    final level = profile.level;
    final time = profile.timeBudget;

    // Primary hall by purpose (with level/time refinements).
    var primary = switch (purpose) {
      RecommendationPurpose.examStudy => 'elec',
      RecommendationPurpose.workPractice => switch (level) {
        RecommendationLevel.advancedPractice => 'ai-story',
        RecommendationLevel.systematizeBasics => 'elec',
        _ => 'finance',
      },
      RecommendationPurpose.hobbyCulture => 'english',
      RecommendationPurpose.futureReady => 'ai-story',
      RecommendationPurpose.familyLearning => switch (time) {
        RecommendationTime.tenMinutes => 'english',
        _ => 'ai-story',
      },
      RecommendationPurpose.dailyLife => switch (level) {
        RecommendationLevel.firstStart => switch (time) {
          RecommendationTime.tenMinutes => 'english',
          RecommendationTime.weekend => 'car',
          _ => 'finance',
        },
        RecommendationLevel.someKnowledge => 'car',
        RecommendationLevel.systematizeBasics => 'finance',
        RecommendationLevel.advancedPractice => 'elec',
      },
    };

    // Long-term exam/work learners with electricity interest stay on elec.
    if (purpose == RecommendationPurpose.examStudy &&
        time == RecommendationTime.longTerm) {
      primary = 'elec';
    }
    if (purpose == RecommendationPurpose.futureReady &&
        level == RecommendationLevel.firstStart &&
        time == RecommendationTime.tenMinutes) {
      primary = 'english';
    }

    final next = _nextSite(primary, purpose);
    final pathId = _pathFor(primary, purpose, time);
    final focus = _focusFor(primary, level);

    return RecommendationResult(
      primarySiteId: primary,
      reasons: _reasons(primary, profile),
      firstFocus: focus.$1,
      secondFocus: focus.$2,
      nextSiteId: next,
      pathId: pathId,
    );
  }

  static String? _nextSite(String primary, RecommendationPurpose purpose) {
    return switch (primary) {
      'ai-story' =>
        purpose == RecommendationPurpose.hobbyCulture ||
                purpose == RecommendationPurpose.familyLearning
            ? 'english'
            : 'finance',
      'elec' => 'car',
      'car' => 'finance',
      'finance' => 'car',
      'english' => 'ai-story',
      _ => null,
    };
  }

  static String? _pathFor(
    String primary,
    RecommendationPurpose purpose,
    RecommendationTime time,
  ) {
    if (primary == 'elec' && purpose == RecommendationPurpose.examStudy) {
      return 'path-elec-exam';
    }
    if (primary == 'elec') return 'path-elec-life';
    if (primary == 'english' && time == RecommendationTime.tenMinutes) {
      return 'path-english-10';
    }
    if (primary == 'english') return 'path-english-10';
    if (primary == 'car' && purpose == RecommendationPurpose.dailyLife) {
      return 'path-car-care';
    }
    if (primary == 'finance' && purpose == RecommendationPurpose.dailyLife) {
      return 'path-car-finance';
    }
    if (primary == 'finance') return 'path-finance-basic';
    if (primary == 'ai-story' &&
        (purpose == RecommendationPurpose.hobbyCulture ||
            purpose == RecommendationPurpose.familyLearning)) {
      return 'path-ai-english';
    }
    if (primary == 'ai-story') return 'path-ai-first';
    if (primary == 'car') return 'path-car-care';
    return null;
  }

  static (String, String) _focusFor(String primary, RecommendationLevel level) {
    return switch (primary) {
      'ai-story' => (
        'AI 역사·핵심 개념으로 전체 그림 잡기',
        level == RecommendationLevel.advancedPractice
            ? '도구 비교와 안전·윤리 주의점'
            : '생활·업무 사례와 짧은 질문 실습',
      ),
      'elec' => (
        '안전 원칙과 전기 기초 개념',
        level == RecommendationLevel.advancedPractice ||
                level == RecommendationLevel.systematizeBasics
            ? '필기·기출·모의고사 흐름'
            : '생활 전기상식과 전문가에게 맡길 일',
      ),
      'car' => ('기본 점검 체크리스트와 경고등', '정비주기·증상·이력 기록 습관'),
      'finance' => ('돈의 흐름·저축·비상자금', '위험 개념과 금융사기 예방'),
      'english' => ('인사·자기소개와 생활 문장', '테마 대화와 하루 10분 복습'),
      _ => ('전문관 소개부터 살펴보기', '추천 학습 순서 따라가기'),
    };
  }

  static List<String> _reasons(String primary, RecommendationProfile profile) {
    final hallName = switch (primary) {
      'ai-story' => '소통AI스토리',
      'elec' => '소통전기',
      'car' => '소통카',
      'finance' => '소통금융',
      'english' => '소통영어',
      _ => primary,
    };
    return [
      '선택하신 목적(${profile.purpose.label})과 가장 잘 맞는 전문관은 $hallName입니다.',
      '현재 수준(${profile.level.label})에 맞춰 첫 학습 깊이를 조정했습니다.',
      '사용 가능 시간(${profile.timeBudget.label})을 고려해 시작 분량을 제안합니다.',
      '이 결과는 규칙 기반 안내이며, 생성형 AI 분석이 아닙니다.',
    ];
  }
}

abstract final class RelatedKnowledgeData {
  static const List<RelatedKnowledge> items = [
    RelatedKnowledge(
      id: 'rk-ai-english',
      title: 'AI 기초 → AI를 활용한 영어 학습',
      description:
          '영어 기본 문장을 익힌 뒤, AI로 복습 질문을 만들면 짧은 루틴이 유지됩니다. '
          '다만 AI 문장은 오류가 있을 수 있으니 표현을 다시 확인하세요.',
      fromSiteId: 'ai-story',
      toSiteId: 'english',
      keywords: ['AI', '영어', '학습'],
    ),
    RelatedKnowledge(
      id: 'rk-finance-car',
      title: '금융 기초 → 자동차 구매·유지비 판단',
      description:
          '현금흐름과 고정비를 이해한 다음, 차량 정비·유지 비용을 함께 보면 '
          '구매 전후 판단이 신중해집니다.',
      fromSiteId: 'finance',
      toSiteId: 'car',
      keywords: ['금융', '자동차', '유지비'],
    ),
    RelatedKnowledge(
      id: 'rk-elec-car',
      title: '전기 기초 → 자동차 전장·전기 관련 이해',
      description:
          '전압·전류와 안전 감각은 차량 전기 계통·경고등을 이해하는 바탕이 됩니다. '
          '실제 정비는 전문 정비소에 맡기세요.',
      fromSiteId: 'elec',
      toSiteId: 'car',
      keywords: ['전기', '자동차', '전장'],
    ),
    RelatedKnowledge(
      id: 'rk-english-ai',
      title: '영어 기초 → AI 도구와 기술 문서 이해',
      description: '생활영어 기초가 있으면 AI·기술 설명을 읽고 질문하기가 수월해집니다.',
      fromSiteId: 'english',
      toSiteId: 'ai-story',
      keywords: ['영어', 'AI', '문서'],
    ),
    RelatedKnowledge(
      id: 'rk-ai-finance',
      title: 'AI 활용 → 금융 정보의 신뢰성 판단',
      description:
          'AI가 정리한 금융 설명도 오류가 있을 수 있습니다. '
          '금융 교육 원칙과 출처 확인 습관을 함께 익히세요.',
      fromSiteId: 'ai-story',
      toSiteId: 'finance',
      keywords: ['AI', '금융', '신뢰'],
    ),
  ];
}
