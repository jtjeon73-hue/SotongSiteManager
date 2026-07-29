/// Inputs collected by the local knowledge finder.
class RecommendationProfile {
  const RecommendationProfile({
    required this.purpose,
    required this.level,
    required this.timeBudget,
  });

  final RecommendationPurpose purpose;
  final RecommendationLevel level;
  final RecommendationTime timeBudget;
}

enum RecommendationPurpose {
  dailyLife,
  examStudy,
  workPractice,
  hobbyCulture,
  futureReady,
  familyLearning,
  healthLifestyle,
  plcAutomation,
  smartFarmTech,
  codingDev,
  ruralDevelopment,
  retirementPlanning;

  String get label => switch (this) {
    RecommendationPurpose.dailyLife => '생활에 바로 활용',
    RecommendationPurpose.examStudy => '자격증·학습',
    RecommendationPurpose.workPractice => '직업·실무',
    RecommendationPurpose.hobbyCulture => '취미·교양',
    RecommendationPurpose.futureReady => '미래 준비',
    RecommendationPurpose.familyLearning => '가족과 함께 학습',
    RecommendationPurpose.healthLifestyle => '건강과 생활습관을 이해하고 싶어요',
    RecommendationPurpose.plcAutomation => 'PLC와 공장자동화를 배우고 싶어요',
    RecommendationPurpose.smartFarmTech => '스마트팜과 농업기술을 알고 싶어요',
    RecommendationPurpose.codingDev => '코딩과 앱 개발을 배우고 싶어요',
    RecommendationPurpose.ruralDevelopment => '농촌생활과 지역발전을 연구하고 싶어요',
    RecommendationPurpose.retirementPlanning => '노후와 인생설계를 준비하고 싶어요',
  };
}

enum RecommendationLevel {
  firstStart,
  someKnowledge,
  systematizeBasics,
  advancedPractice;

  String get label => switch (this) {
    RecommendationLevel.firstStart => '처음 시작',
    RecommendationLevel.someKnowledge => '조금 알고 있음',
    RecommendationLevel.systematizeBasics => '기본기를 체계화하고 싶음',
    RecommendationLevel.advancedPractice => '실무 또는 심화 학습 희망',
  };
}

enum RecommendationTime {
  tenMinutes,
  thirtyMinutes,
  weekend,
  longTerm;

  String get label => switch (this) {
    RecommendationTime.tenMinutes => '하루 10분',
    RecommendationTime.thirtyMinutes => '하루 30분',
    RecommendationTime.weekend => '주말 중심',
    RecommendationTime.longTerm => '장기적으로 체계적 학습',
  };
}

/// Rule-based recommendation output (not generative AI).
class RecommendationResult {
  const RecommendationResult({
    required this.primarySiteId,
    required this.reasons,
    required this.firstFocus,
    required this.secondFocus,
    required this.nextSiteId,
    required this.pathId,
  });

  final String primarySiteId;
  final List<String> reasons;
  final String firstFocus;
  final String secondFocus;
  final String? nextSiteId;
  final String? pathId;
}
