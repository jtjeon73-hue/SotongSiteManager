import 'package:flutter/material.dart';

import '../models/featured_knowledge.dart';
import '../models/knowledge_category.dart';
import '../models/knowledge_path.dart';
import '../models/knowledge_site.dart';
import '../models/learning_goal.dart';
import '../models/related_knowledge.dart';
import 'categories_data.dart';
import 'learning_paths_data.dart';
import 'recommendation_rules.dart';
import 'sites_data.dart';

/// Aggregated catalog for stage-2 discovery.
abstract final class KnowledgeData {
  static const List<KnowledgeCategory> categories = CategoriesData.categories;
  static const List<KnowledgeSite> sites = SitesData.sites;
  static const List<KnowledgePath> learningPaths = LearningPathsData.paths;
  static const List<RelatedKnowledge> relatedKnowledge =
      RelatedKnowledgeData.items;

  static const List<FeaturedKnowledge> featuredKnowledge = [
    FeaturedKnowledge(
      id: 'fk-ai-prompt',
      title: '좋은 질문은 좋은 AI 답변을 만든다',
      summary:
          '목적·대상·형식을 분명히 하면 AI 활용 품질이 달라집니다. '
          '소통AI스토리에서 개념과 활용부터 시작하세요.',
      whyItMatters: '도구보다 질문 설계가 결과의 차이를 만듭니다.',
      siteId: 'ai-story',
      categoryId: 'ai-digital',
      tags: ['AI', '프롬프트', '실무'],
      isNew: true,
    ),
    FeaturedKnowledge(
      id: 'fk-elec-safety',
      title: '전기는 편리하지만, 안전 원칙이 먼저다',
      summary: '소통전기에서 기초 개념과 안전·자격 학습 흐름을 함께 확인하세요.',
      whyItMatters: '전기 지식은 시험용만이 아니라 가정과 현장의 안전과 직결됩니다.',
      siteId: 'elec',
      categoryId: 'elec-tech',
      tags: ['전기', '안전', '기초'],
    ),
    FeaturedKnowledge(
      id: 'fk-car-check',
      title: '출발 전 5분 점검이 큰 고장을 막는다',
      summary: '타이어·오일·배터리·경고등만 습관적으로 확인해도 문제를 일찍 발견할 수 있습니다.',
      whyItMatters: '작은 점검 습관이 안전과 비용을 지킵니다.',
      siteId: 'car',
      categoryId: 'auto-mobility',
      tags: ['자동차', '점검', '습관'],
    ),
    FeaturedKnowledge(
      id: 'fk-finance-cashflow',
      title: '투자보다 먼저, 돈의 흐름을 본다',
      summary: '수입과 지출, 비상자금의 구조를 이해하면 금융 판단이 달라집니다.',
      whyItMatters: '현금흐름 이해는 모든 재무 판단의 출발점입니다.',
      siteId: 'finance',
      categoryId: 'finance-economy',
      tags: ['금융', '가계', '기초'],
      isNew: true,
    ),
    FeaturedKnowledge(
      id: 'fk-english-daily',
      title: '하루 한 장면으로 생활영어 시작하기',
      summary: '실제 장면을 정해 짧게 반복하면 영어가 생활 도구가 됩니다.',
      whyItMatters: '짧은 반복이 장기 학습을 가능하게 합니다.',
      siteId: 'english',
      categoryId: 'english-language',
      tags: ['영어', '생활', '습관'],
    ),
  ];

  static const List<LearningGoal> learningGoals = [
    LearningGoal(
      id: 'goal-ai-beginner',
      title: 'AI를 제대로 이해하고 활용하고 싶어요',
      description: '인공지능 개념부터 생활·업무 활용과 주의점까지 안내합니다.',
      icon: Icons.auto_awesome_outlined,
      siteIds: ['ai-story'],
      learningOrder: ['AI 역사와 필요성', '핵심 개념', '생활·업무 사례', '짧은 실습', '안전·윤리 확인'],
      tips: ['완벽한 용어보다 무엇을 시키고 싶은지를 먼저 적으세요.', '중요한 결정은 AI에만 맡기지 마세요.'],
      keywords: ['AI', '인공지능', '입문', '활용'],
    ),
    LearningGoal(
      id: 'goal-elec-exam',
      title: '전기 원리와 전기기사 공부를 시작하고 싶어요',
      description: '생활 전기와 자격 학습의 출발점을 잡습니다.',
      icon: Icons.bolt_outlined,
      siteIds: ['elec'],
      learningOrder: ['안전 원칙', '기초 개념', '필기·공식', '기출·모의고사', '오답 복습'],
      tips: ['공식 암기 전에 물리 감각을 만드세요.', '위험한 작업은 전문가에게 맡기세요.'],
      keywords: ['전기기사', '자격', '전기', '시험'],
    ),
    LearningGoal(
      id: 'goal-car-care',
      title: '자동차를 안전하고 경제적으로 관리하고 싶어요',
      description: '점검·경고등·정비주기 습관을 만듭니다.',
      icon: Icons.directions_car_outlined,
      siteIds: ['car'],
      learningOrder: ['기본 점검', '경고등·증상', '정비주기', '이력·비용 기록', '계절 점검'],
      tips: ['이상이 느껴지면 기록하고 확인하세요.', '안전 계통은 전문 정비소에 맡기세요.'],
      keywords: ['자동차', '관리', '정비', '점검'],
    ),
    LearningGoal(
      id: 'goal-finance',
      title: '돈과 금융의 흐름을 이해하고 싶어요',
      description: '교육 중심으로 저축·위험·세금의 기초를 익힙니다.',
      icon: Icons.account_balance_outlined,
      siteIds: ['finance'],
      learningOrder: ['현금흐름', '저축·비상자금', '위험과 수익', '세금·보험 기초', '사기 예방'],
      tips: ['높은 수익 약속일수록 원리를 먼저 확인하세요.', '개인 의사결정은 전문가 확인이 필요합니다.'],
      keywords: ['금융', '투자', '저축', '세금'],
    ),
    LearningGoal(
      id: 'goal-english',
      title: '영어를 기초부터 생활 속에서 사용하고 싶어요',
      description: '짧은 장면 반복으로 생활영어를 이어갑니다.',
      icon: Icons.translate_outlined,
      siteIds: ['english'],
      learningOrder: ['인사·자기소개', '생활 문장', '테마 대화', '문법 보완', '퀴즈 복습'],
      tips: ['하루 10분이라도 같은 장면을 반복하세요.', '틀려도 대화를 이어가는 연습을 우선하세요.'],
      keywords: ['영어', '생활영어', '회화'],
    ),
    LearningGoal(
      id: 'goal-dev-plc',
      title: '개발과 산업자동화를 공부하고 싶어요',
      description: '현재는 준비 중인 분야입니다. 학습 방향만 미리 확인할 수 있습니다.',
      icon: Icons.precision_manufacturing_outlined,
      siteIds: [],
      learningOrder: ['프로그래밍 기초 개념', '자동화와 센서 역할', 'PLC 입문', '현장 안전', '심화 확장'],
      tips: ['지금은 AI·전기 등 기반 지식을 먼저 살펴볼 수 있습니다.'],
      keywords: ['프로그래밍', 'PLC', '자동화', '코딩'],
    ),
    LearningGoal(
      id: 'goal-farm',
      title: '농촌생활과 스마트팜을 알아보고 싶어요',
      description: '귀촌·스마트팜 분야는 준비 중입니다.',
      icon: Icons.agriculture_outlined,
      siteIds: [],
      learningOrder: ['귀촌·농업 현실 이해', '작물·기초 관리', '스마트팜 개념', '생활 사례', '안전·비용'],
      tips: ['준비 중 분야도 방향을 미리 확인할 수 있습니다.'],
      keywords: ['농업', '귀촌', '스마트팜', '농촌'],
    ),
  ];

  static const List<String> starterPaths = [
    'AI를 생활 도구로 쓰고 싶다면 → 소통AI스토리',
    '가정과 현장의 전기를 이해하고 싶다면 → 소통전기',
    '차를 안전하고 스마트하게 관리하고 싶다면 → 소통카',
    '돈의 결정을 스스로 이해하고 싶다면 → 소통금융',
    '생활영어를 부담 없이 시작하고 싶다면 → 소통영어',
  ];

  static const List<String> learningMethodSteps = [
    '관심 분야 발견',
    '핵심 개념 이해',
    '생활 사례 확인',
    '깊이 있는 학습',
    '실제 활용과 반복 학습',
  ];

  static const List<String> expansionFields = [
    '건강',
    '프로그래밍',
    'PLC·산업자동화',
    '스마트팜',
    '농업·귀촌',
    '자동차·농기계',
    '인공지능 활용',
    '재무·투자·세금',
    '외국어',
    '역사·과학·생활지식',
    '지역발전·관광',
    '취미·음악',
    '노후생활',
    '새로운 관심 분야',
  ];

  static const String brandName = '소통사이트매니저';
  static const String brandNameEn = 'Sotong Knowledge Manager';
  static const String tagline = '세상의 중요한 지식을 쉽고 깊이 있게';
  static const String supportLine =
      '처음 시작하는 분부터 실생활과 실무에 활용하려는 분까지, '
      '필요한 지식과 학습 순서를 안내합니다.';

  static const String philosophy =
      '소통사이트매니저는 링크를 모아 두는 곳이 아닙니다. '
      '소통회장이 만든 전문 지식 사이트를 하나의 허브로 연결하고, '
      '누구나 중요한 지식을 쉽게 시작하면서도 필요할 때 실무·전문 수준까지 '
      '깊이 들어갈 수 있도록 안내합니다.';

  static const List<String> contentPrinciples = [
    '왜 알아야 하는가',
    '처음 배우는 핵심 개념',
    '생활 속 사례',
    '조금 더 깊은 원리',
    '실무 또는 실제 활용',
    '자주 하는 실수',
    '안전과 주의사항',
    '확인 문제와 복습',
    '다음 학습 추천',
    '관련 전문 사이트 연결',
  ];
}
