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
        RecommendationLevel.advancedPractice => 'plc',
        RecommendationLevel.systematizeBasics => 'elec',
        RecommendationLevel.someKnowledge => 'development',
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
      RecommendationPurpose.healthLifestyle => 'health',
      RecommendationPurpose.plcAutomation => 'plc',
      RecommendationPurpose.smartFarmTech => 'smart-farm',
      RecommendationPurpose.codingDev => 'development',
      RecommendationPurpose.ruralDevelopment => 'country-ai',
    };

    // Preserve stage-2 regression refinements.
    if (purpose == RecommendationPurpose.examStudy &&
        time == RecommendationTime.longTerm) {
      primary = 'elec';
    }
    if (purpose == RecommendationPurpose.futureReady &&
        level == RecommendationLevel.firstStart &&
        time == RecommendationTime.tenMinutes) {
      primary = 'english';
    }
    // Advanced work learners who want long-term coding stay on development.
    if (purpose == RecommendationPurpose.workPractice &&
        level == RecommendationLevel.someKnowledge &&
        time == RecommendationTime.longTerm) {
      primary = 'development';
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
            : purpose == RecommendationPurpose.ruralDevelopment
            ? 'country-ai'
            : 'development',
      'elec' => purpose == RecommendationPurpose.plcAutomation ? 'plc' : 'car',
      'car' => 'finance',
      'finance' =>
        purpose == RecommendationPurpose.healthLifestyle ? 'health' : 'car',
      'english' =>
        purpose == RecommendationPurpose.codingDev ? 'development' : 'ai-story',
      'health' => 'finance',
      'plc' => 'development',
      'smart-farm' => 'country-ai',
      'development' => 'ai-story',
      'country-ai' => 'smart-farm',
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
    if (primary == 'health') {
      return time == RecommendationTime.longTerm
          ? 'path-health-midlife'
          : 'path-health-info';
    }
    if (primary == 'plc') {
      return purpose == RecommendationPurpose.plcAutomation &&
              time == RecommendationTime.longTerm
          ? 'path-plc-mfc'
          : 'path-plc-first';
    }
    if (primary == 'smart-farm') {
      return time == RecommendationTime.longTerm
          ? 'path-smartfarm-data'
          : 'path-smartfarm-basic';
    }
    if (primary == 'development') {
      return time == RecommendationTime.longTerm
          ? 'path-flutter-intro'
          : 'path-coding-first';
    }
    if (primary == 'country-ai') {
      return purpose == RecommendationPurpose.ruralDevelopment &&
              time == RecommendationTime.longTerm
          ? 'path-rural-ai-ideas'
          : 'path-rural-life';
    }
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
      'health' => ('건강 기초와 정보 한계 이해', '생활습관·응급 안내와 전문가 상담 시점'),
      'plc' => ('PLC 시작하기와 안전', '센서·통신·제조사 입문'),
      'smart-farm' => ('스마트팜 개념과 적용 범위', '센서·제어·운영의 연결'),
      'development' => ('맞춤 로드맵과 컴퓨터 기초', 'Python 또는 Flutter 입문'),
      'country-ai' => ('사매면 이해와 주민의 하루', '현실/제안 라벨을 구분해 읽기'),
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
      'health' => '소통건강',
      'plc' => '소통PLC',
      'smart-farm' => '소통스마트팜',
      'development' => '소통개발',
      'country-ai' => '소통농촌AI',
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
      startHint: '소통영어 생활 문장부터',
      nextHint: '소통AI스토리에서 질문 설계',
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
      startHint: '소통금융 현금흐름',
      nextHint: '소통카 유지·정비 비용',
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
      startHint: '소통전기 안전·기초',
      nextHint: '소통카 경고등·전장 이해',
      keywords: ['전기', '자동차', '전장'],
    ),
    RelatedKnowledge(
      id: 'rk-english-ai',
      title: '영어 기초 → AI 도구와 기술 문서 이해',
      description: '생활영어 기초가 있으면 AI·기술 설명을 읽고 질문하기가 수월해집니다.',
      fromSiteId: 'english',
      toSiteId: 'ai-story',
      startHint: '소통영어 기본 문장',
      nextHint: '소통AI스토리 개념·활용',
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
      startHint: '소통AI스토리 안전·윤리',
      nextHint: '소통금융 기초·사기 예방',
      keywords: ['AI', '금융', '신뢰'],
    ),
    RelatedKnowledge(
      id: 'rk-health-finance',
      title: '건강 이해 → 의료비·생활 재무 준비',
      description:
          '건강 정보로 생활 관리 감각을 잡은 뒤, 의료비·비상자금 관점을 금융 전문관에서 연결합니다. '
          '진단·처방은 의료전문가 영역입니다.',
      fromSiteId: 'health',
      toSiteId: 'finance',
      startHint: '소통건강 기초·생활습관',
      nextHint: '소통금융 비상자금·보험 기초',
      keywords: ['건강', '금융', '의료비'],
    ),
    RelatedKnowledge(
      id: 'rk-health-english',
      title: '건강 기초 → 여행·일상 건강 표현',
      description: '증상·병원 관련 생활영어를 익히면 해외 여행·일상 소통에 도움이 됩니다.',
      fromSiteId: 'health',
      toSiteId: 'english',
      startHint: '소통건강 증상·응급 안내',
      nextHint: '소통영어 생활 장면 문장',
      keywords: ['건강', '영어', '여행'],
    ),
    RelatedKnowledge(
      id: 'rk-elec-plc',
      title: '전기 기초 → PLC·산업 제어로 확장',
      description:
          '전기 안전과 기초 개념을 익힌 뒤 PLC·센서·통신으로 확장하면 '
          '현장 자동화 학습이 수월해집니다.',
      fromSiteId: 'elec',
      toSiteId: 'plc',
      startHint: '소통전기 안전·기초',
      nextHint: '소통PLC 시작하기',
      keywords: ['전기', 'PLC', '자동화'],
    ),
    RelatedKnowledge(
      id: 'rk-plc-dev',
      title: 'PLC → PC·MFC·소프트웨어 연동',
      description:
          'PLC 데이터 수집과 MFC/통신 개념을 익힌 뒤, '
          '개발 전문관에서 소프트웨어·프로토콜 감각을 키웁니다.',
      fromSiteId: 'plc',
      toSiteId: 'development',
      startHint: '소통PLC 통신·MFC',
      nextHint: '소통개발 기본지식·실무',
      keywords: ['PLC', '개발', 'MFC', '통신'],
    ),
    RelatedKnowledge(
      id: 'rk-plc-smartfarm',
      title: 'PLC·센서 → 스마트팜 제어 적용',
      description: '센서·제어·통신 원리를 농업 환경·운영 맥락에 연결합니다.',
      fromSiteId: 'plc',
      toSiteId: 'smart-farm',
      startHint: '소통PLC 센서·제어',
      nextHint: '소통스마트팜 제어·PLC',
      keywords: ['PLC', '스마트팜', '센서'],
    ),
    RelatedKnowledge(
      id: 'rk-smartfarm-dev',
      title: '스마트팜 데이터 → 저장·분석·시각화',
      description: '농업 센서 데이터의 의미를 이해한 뒤 개발 기초로 저장·시각화 감각을 익힙니다.',
      fromSiteId: 'smart-farm',
      toSiteId: 'development',
      startHint: '소통스마트팜 데이터·소프트웨어',
      nextHint: '소통개발 Python·프로젝트',
      keywords: ['스마트팜', '개발', '데이터'],
    ),
    RelatedKnowledge(
      id: 'rk-smartfarm-rural',
      title: '스마트팜 → 지역 농업·사업기획',
      description: '기술 이해를 사매면 사례의 농업·관광·실행 제안과 연결해 봅니다.',
      fromSiteId: 'smart-farm',
      toSiteId: 'country-ai',
      startHint: '소통스마트팜 구축·운영',
      nextHint: '소통농촌AI 사업·차별화',
      keywords: ['스마트팜', '농촌', '사업'],
    ),
    RelatedKnowledge(
      id: 'rk-ai-dev',
      title: 'AI 이해 → AI 시대 개발 도구',
      description: 'AI 개념·한계를 알고 개발 학습에 도구를 보조로 쓰면 효율이 높아집니다.',
      fromSiteId: 'ai-story',
      toSiteId: 'development',
      startHint: '소통AI스토리 개념·주의점',
      nextHint: '소통개발 AI 활용 학습',
      keywords: ['AI', '개발', '도구'],
    ),
    RelatedKnowledge(
      id: 'rk-ai-rural',
      title: 'AI 이해 → 농촌 문제·아이디어 탐색',
      description:
          'AI의 가능과 한계를 이해한 뒤, 지역 제안은 참고자료로만 다룹니다. '
          '최종 결정은 주민·행정이 합니다.',
      fromSiteId: 'ai-story',
      toSiteId: 'country-ai',
      startHint: '소통AI스토리 활용·윤리',
      nextHint: '소통농촌AI 차별화·시범사업',
      keywords: ['AI', '농촌', '아이디어'],
    ),
    RelatedKnowledge(
      id: 'rk-english-dev',
      title: '영어 → 기술 문서·개발 용어',
      description: '생활영어 기초가 있으면 개발 문서와 용어 학습이 한결 수월해집니다.',
      fromSiteId: 'english',
      toSiteId: 'development',
      startHint: '소통영어 기초 문장',
      nextHint: '소통개발 용어집·기본지식',
      keywords: ['영어', '개발', '문서'],
    ),
  ];
}
