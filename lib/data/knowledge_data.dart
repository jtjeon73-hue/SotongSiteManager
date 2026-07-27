import 'package:flutter/material.dart';

import '../models/difficulty_level.dart';
import '../models/featured_knowledge.dart';
import '../models/knowledge_category.dart';
import '../models/knowledge_site.dart';
import '../models/learning_goal.dart';
import '../models/site_status.dart';

/// Static catalog for stage-1 local search and discovery.
///
/// Add a new [KnowledgeSite] here (and optionally category / featured / goal
/// links) so home, sites, categories, search, and learning guide all update.
abstract final class KnowledgeData {
  static const List<KnowledgeCategory> categories = [
    KnowledgeCategory(
      id: 'ai-digital',
      name: 'AI·디지털',
      description:
          '인공지능과 디지털 도구를 일상과 업무에 안전하게 활용하는 방법을 다룹니다. '
          '개념 이해부터 실생활 적용, 실무 활용까지 단계적으로 안내합니다.',
      futureDirection: '프롬프트 설계, 업무 자동화, 디지털 리터러시, AI 윤리 콘텐츠를 확대합니다.',
      icon: Icons.auto_awesome_outlined,
      color: Color(0xFF0F766E),
      sortOrder: 1,
      status: SiteStatus.live,
      keywords: ['AI', '인공지능', '디지털', '챗봇', '프롬프트'],
    ),
    KnowledgeCategory(
      id: 'elec-tech',
      name: '전기·기술',
      description:
          '생활 전기부터 자격 시험과 현장 안전까지, 전기 지식을 쉽게 시작하고 '
          '원리와 실무로 깊게 이어가도록 구성합니다.',
      futureDirection: '전기기사·산업기사 학습 경로, 배선·계측·안전 실습 가이드를 보강합니다.',
      icon: Icons.bolt_outlined,
      color: Color(0xFFC47A12),
      sortOrder: 2,
      status: SiteStatus.live,
      keywords: ['전기', '전기기사', '배선', '안전', '계측'],
    ),
    KnowledgeCategory(
      id: 'auto-mobility',
      name: '자동차·이동',
      description:
          '자동차 관리, 점검, 고장 이해, 안전 운전 지식을 생활 언어로 설명하고 '
          '필요하면 기술 원리까지 확장합니다.',
      futureDirection: '농기계·전기차·정비 기초 콘텐츠를 연결해 이동 분야 지식을 넓힙니다.',
      icon: Icons.directions_car_outlined,
      color: Color(0xFF1D4F91),
      sortOrder: 3,
      status: SiteStatus.live,
      keywords: ['자동차', '정비', '점검', '운전', '전기차'],
    ),
    KnowledgeCategory(
      id: 'finance-economy',
      name: '금융·경제',
      description:
          '돈의 흐름, 저축·투자·세금의 기본을 쉽게 정리하고 '
          '실생활에 바로 적용할 수 있는 판단 기준을 제공합니다.',
      futureDirection: '재무설계, 세금 기초, 은퇴 준비, 지역경제 이해 콘텐츠를 확장합니다.',
      icon: Icons.account_balance_outlined,
      color: Color(0xFF1F7A5C),
      sortOrder: 4,
      status: SiteStatus.live,
      keywords: ['금융', '투자', '세금', '저축', '경제'],
    ),
    KnowledgeCategory(
      id: 'english-language',
      name: '영어·언어',
      description:
          '생활 회화부터 학습 습관, 실무 표현까지 부담 없이 이어가는 '
          '외국어 학습 경로를 안내합니다.',
      futureDirection: '상황별 회화, 독해 전략, 다른 외국어 입문 콘텐츠를 추가합니다.',
      icon: Icons.translate_outlined,
      color: Color(0xFF5B4B8A),
      sortOrder: 5,
      status: SiteStatus.live,
      keywords: ['영어', '회화', '외국어', '학습', '표현'],
    ),
    KnowledgeCategory(
      id: 'health-life',
      name: '건강·생활',
      description:
          '일상 건강 관리, 생활 안전, 몸의 신호 이해처럼 '
          '누구나 알아야 할 생활 지식을 차분히 정리합니다.',
      futureDirection: '운동, 영양, 수면, 응급처치 기초를 쉽게 설명하는 전문 사이트를 준비합니다.',
      icon: Icons.favorite_outline,
      color: Color(0xFFB42318),
      sortOrder: 6,
      status: SiteStatus.preparing,
      keywords: ['건강', '생활', '운동', '영양', '안전'],
    ),
    KnowledgeCategory(
      id: 'farm-rural',
      name: '농업·귀촌',
      description:
          '귀촌 준비, 작물 기초, 스마트팜 개념처럼 농촌 생활과 '
          '농업 지식을 처음 접하는 사람 기준으로 안내합니다.',
      futureDirection: '스마트팜 운영, 작기 관리, 지역 정착 가이드를 전문 사이트로 연결합니다.',
      icon: Icons.agriculture_outlined,
      color: Color(0xFF3F7D4E),
      sortOrder: 7,
      status: SiteStatus.preparing,
      keywords: ['농업', '귀촌', '스마트팜', '작물', '농촌'],
    ),
    KnowledgeCategory(
      id: 'dev-automation',
      name: '개발·산업자동화',
      description:
          '프로그래밍 입문과 PLC·산업자동화 기초를 연결해 '
          '현장과 학습이 이어지도록 설계합니다.',
      futureDirection: '코딩 기초, PLC 실습, 스마트팩토리 개념 사이트를 단계적으로 추가합니다.',
      icon: Icons.precision_manufacturing_outlined,
      color: Color(0xFF355C7D),
      sortOrder: 8,
      status: SiteStatus.preparing,
      keywords: ['프로그래밍', 'PLC', '자동화', '코딩', '산업'],
    ),
    KnowledgeCategory(
      id: 'region-culture',
      name: '지역·문화',
      description:
          '지역발전, 관광, 역사·과학·생활지식처럼 우리 동네와 '
          '세상을 이해하는 지식을 모읍니다.',
      futureDirection: '지역 스토리, 관광 해설, 역사·과학 입문 콘텐츠를 연결합니다.',
      icon: Icons.location_city_outlined,
      color: Color(0xFF7A5C45),
      sortOrder: 9,
      status: SiteStatus.planned,
      keywords: ['지역', '관광', '역사', '문화', '과학'],
    ),
    KnowledgeCategory(
      id: 'hobby-retirement',
      name: '취미·노후',
      description:
          '취미와 음악, 노후생활처럼 삶의 질을 높이는 지식을 '
          '천천히, 부담 없이 탐색할 수 있게 합니다.',
      futureDirection: '취미 입문, 음악 감상·연주, 노후 생활 설계 콘텐츠를 준비합니다.',
      icon: Icons.spa_outlined,
      color: Color(0xFF6B5B95),
      sortOrder: 10,
      status: SiteStatus.planned,
      keywords: ['취미', '음악', '노후', '여가', '생활'],
    ),
  ];

  static const List<KnowledgeSite> sites = [
    KnowledgeSite(
      id: 'ai-story',
      name: '소통AI스토리',
      shortName: 'AI스토리',
      description: '인공지능을 처음 만나는 사람을 위한 쉬운 이야기와 활용 길잡이',
      detailedDescription:
          '소통AI스토리는 AI가 무엇인지, 어디에 쓰이는지, 어떻게 안전하게 활용하는지 '
          '이야기처럼 풀어줍니다. 개념 설명에 그치지 않고 생활·업무 사례, 자주 하는 실수, '
          '다음 학습 추천까지 이어져 초보자와 실무자 모두 계속 찾아볼 수 있습니다.',
      categoryId: 'ai-digital',
      icon: Icons.auto_awesome_outlined,
      color: Color(0xFF0F766E),
      url: 'https://sotongware-ai-story.web.app',
      status: SiteStatus.live,
      targetUsers: ['AI 입문자', '직장인', '학생', '어르신', '교육·행정 실무자'],
      difficulty: DifficultyLevel.allLevels,
      topics: ['AI 기초 개념', '생활 속 AI', '프롬프트 기초', '업무 활용', '안전과 윤리'],
      keywords: ['AI', '인공지능', '챗GPT', '프롬프트', '디지털', '자동화'],
      recommendedPath: [
        '왜 AI를 알아야 하는지 이해',
        '핵심 개념을 쉬운 말로 익히기',
        '생활 사례로 감각 잡기',
        '프롬프트와 활용 패턴 연습',
        '업무·학습에 적용하고 주의점 점검',
      ],
      featured: true,
      sortOrder: 1,
      whyMatters:
          'AI는 이미 검색, 문서, 번역, 업무 도구에 들어와 있습니다. 원리와 한계를 알면 더 안전하고 똑똑하게 쓸 수 있습니다.',
      learningOutcomes: [
        'AI의 가능과 한계를 구분할 수 있다',
        '일상·업무에서 바로 써볼 질문을 만들 수 있다',
        '개인정보·환각·과장 정보를 조심할 수 있다',
      ],
    ),
    KnowledgeSite(
      id: 'elec',
      name: '소통전기',
      shortName: '전기',
      description: '생활 전기부터 자격 공부와 현장 안전까지 이어지는 전기 지식',
      detailedDescription:
          '소통전기는 전기가 왜 중요한지부터 시작해 기본 개념, 생활 사례, 원리, '
          '실무 활용, 자주 하는 실수와 안전 주의사항까지 단계적으로 안내합니다. '
          '전기기사 공부를 시작하는 사람부터 생활 안전을 챙기고 싶은 사람까지 '
          '자신에게 맞는 깊이로 학습을 이어갈 수 있습니다.',
      categoryId: 'elec-tech',
      icon: Icons.bolt_outlined,
      color: Color(0xFFC47A12),
      url: 'https://sotong-elec.web.app',
      status: SiteStatus.live,
      targetUsers: ['전기 입문자', '자격 수험생', '현장 실무자', '안전 담당자', '생활 전기 학습자'],
      difficulty: DifficultyLevel.allLevels,
      topics: ['전기 기초', '회로와 전류', '생활 전기', '자격 시험', '감전·안전'],
      keywords: ['전기', '전기기사', '회로', '전압', '전류', '안전', '배선'],
      recommendedPath: [
        '전기 지식의 필요성과 안전 원칙 확인',
        '전압·전류·저항 등 핵심 개념 익히기',
        '가정·현장 사례로 연결',
        '원리와 계산 감각 키우기',
        '자격·실무 문제로 복습',
      ],
      featured: true,
      sortOrder: 2,
      whyMatters:
          '전기는 생활과 산업의 기반입니다. 잘못된 이해는 사고와 직결되므로 쉬운 설명과 안전 원칙이 함께 필요합니다.',
      learningOutcomes: [
        '기본 전기 용어를 설명할 수 있다',
        '생활 속 전기 위험을 구분할 수 있다',
        '자격 공부나 현장 학습의 출발점을 잡을 수 있다',
      ],
    ),
    KnowledgeSite(
      id: 'car',
      name: '소통카',
      shortName: '카',
      description: '자동차를 제대로 이해하고 관리하기 위한 실용 자동차 지식',
      detailedDescription:
          '소통카는 차량 점검, 관리, 이상 징후 이해처럼 운전자가 꼭 알아야 할 지식을 '
          '쉽게 설명합니다. 왜 관리가 필요한지부터 핵심 부품 개념, 생활 사례, '
          '조금 더 깊은 원리, 실무적 점검 순서까지 연결해 '
          '처음 배우는 사람과 경험 있는 운전자 모두가 참고할 수 있습니다.',
      categoryId: 'auto-mobility',
      icon: Icons.directions_car_outlined,
      color: Color(0xFF1D4F91),
      url: 'https://sotong-car.web.app',
      status: SiteStatus.live,
      targetUsers: ['운전자', '차량 관리 초보', '정비 입문자', '가족 운전자', '실무 학습자'],
      difficulty: DifficultyLevel.beginner,
      topics: ['차량 점검', '엔진·배터리', '타이어·제동', '계절 관리', '안전 운전'],
      keywords: ['자동차', '정비', '엔진', '배터리', '타이어', '점검', '운전'],
      recommendedPath: [
        '자동차 관리가 중요한 이유 이해하기',
        '기본 점검 항목 익히기',
        '이상 징후와 생활 사례 연결',
        '주요 장치의 작동 원리 살펴보기',
        '정기 점검·안전 습관으로 정착',
      ],
      featured: true,
      sortOrder: 3,
      whyMatters:
          '자동차는 생활 도구이자 안전과 비용이 걸린 자산입니다. 기본을 알면 고장·사고·불필요한 비용을 줄일 수 있습니다.',
      learningOutcomes: [
        '일상 점검 체크리스트를 만들 수 있다',
        '경고등·이상 소리를 가볍게 넘기지 않게 된다',
        '정비소와 소통할 기본 용어를 갖춘다',
      ],
    ),
    KnowledgeSite(
      id: 'finance',
      name: '소통금융',
      shortName: '금융',
      description: '돈의 흐름을 이해하고 실생활에 적용하는 금융·경제 지식',
      detailedDescription:
          '소통금융은 저축, 소비, 투자, 세금처럼 삶에서 반복되는 돈의 결정을 '
          '쉽게 풀어줍니다. 단순 상품 소개가 아니라 왜 알아야 하는지, '
          '핵심 개념, 생활 사례, 원리, 실수와 주의사항, 복습 포인트까지 담아 '
          '초보자도 자신 있게 금융 지식을 시작할 수 있게 합니다.',
      categoryId: 'finance-economy',
      icon: Icons.account_balance_outlined,
      color: Color(0xFF1F7A5C),
      url: 'https://sotong-finance.web.app',
      status: SiteStatus.live,
      targetUsers: ['금융 입문자', '직장인', '학생', '가정 재무 관리자', '은퇴 준비자'],
      difficulty: DifficultyLevel.beginner,
      topics: ['가계부·현금흐름', '저축과 투자', '위험과 수익', '세금 기초', '금융 사기 예방'],
      keywords: ['금융', '투자', '저축', '세금', '경제', '자산', '이자'],
      recommendedPath: [
        '돈의 흐름과 재무 목표 정리',
        '이자·위험·분산 등 핵심 개념 학습',
        '생활 속 금융 결정에 적용',
        '투자·세금의 기본 원리 확장',
        '자주 하는 실수와 안전 원칙 점검',
      ],
      featured: true,
      sortOrder: 4,
      whyMatters:
          '금융 지식은 평생 반복되는 선택의 기준입니다. 쉬운 이해와 신중한 원칙이 함께해야 실생활에서 도움이 됩니다.',
      learningOutcomes: [
        '수입·지출·저축의 기본 구조를 설명할 수 있다',
        '위험과 수익의 관계를 이해한다',
        '과장 광고·사기 정보에 더 신중해진다',
      ],
    ),
    KnowledgeSite(
      id: 'english',
      name: '소통영어',
      shortName: '영어',
      description: '생활영어를 부담 없이 시작하고 꾸준히 이어가는 언어 학습',
      detailedDescription:
          '소통영어는 문법 암기보다 이해와 활용을 우선합니다. '
          '왜 영어가 필요한지, 처음 익힐 표현, 생활 상황 사례, 조금 더 깊은 구조, '
          '실무·여행·일상 활용, 자주 하는 실수까지 단계적으로 안내해 '
          '처음 배우는 사람도 포기하지 않고 이어갈 수 있습니다.',
      categoryId: 'english-language',
      icon: Icons.translate_outlined,
      color: Color(0xFF5B4B8A),
      url: 'https://sotong-language.web.app',
      status: SiteStatus.live,
      targetUsers: ['영어 입문자', '생활회화 학습자', '학생', '직장인', '어르신'],
      difficulty: DifficultyLevel.beginner,
      topics: ['생활 회화', '핵심 표현', '듣기·말하기', '학습 습관', '실무 기초 표현'],
      keywords: ['영어', '회화', '표현', '문법', '듣기', '말하기', '학습'],
      recommendedPath: [
        '학습 목적과 짧은 목표 설정',
        '핵심 생활 표현부터 익히기',
        '상황 대화로 바로 써보기',
        '문장 구조와 표현 원리 이해',
        '복습·확장 표현으로 이어가기',
      ],
      featured: true,
      sortOrder: 5,
      whyMatters:
          '영어는 정보 접근과 소통의 도구입니다. 처음부터 어렵게 시작하면 포기하기 쉬우므로 생활 중심으로 쌓는 것이 중요합니다.',
      learningOutcomes: [
        '자주 쓰는 생활 문장을 말할 수 있다',
        '짧은 학습 루틴을 만들 수 있다',
        '실수해도 대화를 이어가는 자신감을 얻는다',
      ],
    ),
  ];

  static const List<FeaturedKnowledge> featuredKnowledge = [
    FeaturedKnowledge(
      id: 'fk-ai-prompt',
      title: '좋은 질문은 좋은 AI 답변을 만든다',
      summary:
          '목적, 대상, 형식, 제약을 분명히 하면 AI 활용 품질이 크게 달라집니다. '
          '소통AI스토리에서 쉬운 예시로 시작하세요.',
      whyItMatters: '도구보다 질문 설계가 결과의 차이를 만듭니다.',
      siteId: 'ai-story',
      categoryId: 'ai-digital',
      tags: ['AI', '프롬프트', '실무'],
      isNew: true,
    ),
    FeaturedKnowledge(
      id: 'fk-elec-safety',
      title: '전기는 편리하지만, 안전 원칙이 먼저다',
      summary:
          '감전·과열·합선은 생활 속에서도 일어납니다. '
          '소통전기에서 기본 개념과 주의사항을 함께 확인하세요.',
      whyItMatters: '전기 지식은 시험용만이 아니라 가정과 현장의 안전과 직결됩니다.',
      siteId: 'elec',
      categoryId: 'elec-tech',
      tags: ['전기', '안전', '기초'],
    ),
    FeaturedKnowledge(
      id: 'fk-car-check',
      title: '출발 전 5분 점검이 큰 고장을 막는다',
      summary:
          '타이어, 오일, 배터리, 경고등만 습관적으로 확인해도 '
          '많은 문제를 일찍 발견할 수 있습니다.',
      whyItMatters: '작은 점검 습관이 안전과 비용을 지킵니다.',
      siteId: 'car',
      categoryId: 'auto-mobility',
      tags: ['자동차', '점검', '습관'],
    ),
    FeaturedKnowledge(
      id: 'fk-finance-cashflow',
      title: '투자보다 먼저, 돈의 흐름을 본다',
      summary:
          '수입과 지출, 비상자금의 구조를 이해하면 '
          '금융 상품을 고르는 눈이 달라집니다.',
      whyItMatters: '현금흐름 이해는 모든 재무 판단의 출발점입니다.',
      siteId: 'finance',
      categoryId: 'finance-economy',
      tags: ['금융', '가계', '기초'],
      isNew: true,
    ),
    FeaturedKnowledge(
      id: 'fk-english-daily',
      title: '하루 한 장면으로 생활영어 시작하기',
      summary:
          '카페, 병원, 직장처럼 실제 장면을 정해 짧게 반복하면 '
          '영어가 암기가 아니라 생활 도구가 됩니다.',
      whyItMatters: '짧은 반복이 장기 학습을 가능하게 합니다.',
      siteId: 'english',
      categoryId: 'english-language',
      tags: ['영어', '생활', '습관'],
    ),
  ];

  static const List<LearningGoal> learningGoals = [
    LearningGoal(
      id: 'goal-ai-beginner',
      title: 'AI를 처음 배우고 싶어요',
      description:
          '인공지능이 무엇인지부터 생활·업무 활용까지, '
          '부담 없이 시작할 수 있는 경로입니다.',
      icon: Icons.auto_awesome_outlined,
      siteIds: ['ai-story'],
      learningOrder: [
        'AI가 무엇인지, 왜 중요한지 읽기',
        '핵심 개념을 쉬운 말로 정리하기',
        '생활 속 사례로 감각 잡기',
        '짧은 프롬프트 실습하기',
        '주의사항과 다음 학습 확인하기',
      ],
      tips: ['완벽한 용어보다 “무엇을 시키고 싶은지”를 먼저 적으세요.', '개인정보와 중요한 결정은 AI에만 맡기지 마세요.'],
      keywords: ['AI', '인공지능', '입문', '처음'],
    ),
    LearningGoal(
      id: 'goal-elec-exam',
      title: '전기기사 공부를 하고 싶어요',
      description:
          '자격 공부의 출발점으로 전기 기초와 안전 원칙을 탄탄히 잡고 '
          '원리와 문제로 확장합니다.',
      icon: Icons.bolt_outlined,
      siteIds: ['elec'],
      learningOrder: [
        '전기 학습의 목표와 안전 원칙 확인',
        '전압·전류·전력 등 기초 개념 정복',
        '생활·현장 사례로 감각 연결',
        '원리와 계산 문제 연습',
        '자주 하는 실수와 복습 문제 풀기',
      ],
      tips: ['공식 암기 전에 물리 감각을 먼저 만드세요.', '안전 관련 내용은 시험용이 아니라 실제 기준으로 읽으세요.'],
      keywords: ['전기기사', '자격', '전기', '시험'],
    ),
    LearningGoal(
      id: 'goal-car-care',
      title: '자동차를 제대로 관리하고 싶어요',
      description: '운전자가 알아야 할 점검·관리·이상 징후를 체계적으로 익힙니다.',
      icon: Icons.directions_car_outlined,
      siteIds: ['car'],
      learningOrder: [
        '차량 관리가 중요한 이유 이해하기',
        '일상 점검 항목 익히기',
        '경고등과 이상 징후 사례 확인',
        '주요 장치 원리 살펴보기',
        '계절·장거리 운행 체크리스트 만들기',
      ],
      tips: [
        '이상이 느껴지면 “나중에”보다 “기록하고 확인”이 안전합니다.',
        '정비소에 갈 때는 증상·시점·상황을 메모하세요.',
      ],
      keywords: ['자동차', '관리', '정비', '점검'],
    ),
    LearningGoal(
      id: 'goal-finance',
      title: '금융과 돈의 흐름을 이해하고 싶어요',
      description: '저축·투자·세금의 기본을 생활 언어로 이해하고 판단력을 키웁니다.',
      icon: Icons.account_balance_outlined,
      siteIds: ['finance'],
      learningOrder: [
        '수입·지출·비상자금 구조 파악',
        '이자·위험·분산 개념 익히기',
        '생활 금융 결정에 적용',
        '세금·투자 기초로 확장',
        '사기·과장 정보 주의점 점검',
      ],
      tips: ['높은 수익 약속일수록 원리를 먼저 확인하세요.', '금융 지식은 상품 추천보다 판단 기준을 쌓는 일입니다.'],
      keywords: ['금융', '투자', '저축', '세금'],
    ),
    LearningGoal(
      id: 'goal-english',
      title: '생활영어를 배우고 싶어요',
      description: '문법보다 실제 장면에서 바로 쓰는 표현으로 영어를 시작합니다.',
      icon: Icons.translate_outlined,
      siteIds: ['english'],
      learningOrder: [
        '나와 관련된 생활 장면 고르기',
        '핵심 표현 10개부터 익히기',
        '짧은 대화로 바로 써보기',
        '문장 구조를 가볍게 이해하기',
        '복습하고 다음 장면으로 확장하기',
      ],
      tips: ['하루 10분이라도 같은 장면을 반복하세요.', '틀려도 대화를 이어가는 연습을 우선하세요.'],
      keywords: ['영어', '생활영어', '회화'],
    ),
    LearningGoal(
      id: 'goal-dev-plc',
      title: '개발과 산업자동화를 공부하고 싶어요',
      description:
          '현재는 준비 중인 분야입니다. 프로그래밍과 PLC·산업자동화 지식을 '
          '쉬운 입문부터 현장 활용까지 연결할 예정입니다.',
      icon: Icons.precision_manufacturing_outlined,
      siteIds: [],
      learningOrder: [
        '프로그래밍 기초 개념 이해',
        '자동화와 센서·제어의 역할 파악',
        'PLC 입문과 간단한 논리 연습',
        '현장 사례로 안전·실무 주의점 학습',
        '심화 학습 경로로 확장',
      ],
      tips: [
        '지금은 관련 분야로 AI·전기 지식을 먼저 살펴볼 수 있습니다.',
        '새 전문 사이트가 열리면 학습 길잡이가 자동으로 연결됩니다.',
      ],
      keywords: ['프로그래밍', 'PLC', '자동화', '코딩'],
    ),
    LearningGoal(
      id: 'goal-farm',
      title: '농촌생활과 스마트팜을 알아보고 싶어요',
      description:
          '귀촌·농업·스마트팜 분야는 준비 중입니다. '
          '생활 지식과 기술 지식이 만나도록 구성할 예정입니다.',
      icon: Icons.agriculture_outlined,
      siteIds: [],
      learningOrder: [
        '귀촌·농업이 필요한 이유와 현실 이해',
        '작물·계절·기초 관리 개념 익히기',
        '스마트팜 센서·제어의 역할 살펴보기',
        '생활 사례와 지역 정보 연결',
        '안전·비용·다음 학습 확인',
      ],
      tips: [
        '지금은 전기·AI 등 기반 기술 사이트를 참고할 수 있습니다.',
        '준비 중 분야도 방향과 학습 순서를 미리 확인할 수 있습니다.',
      ],
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
  static const String supportLine = '관심에서 시작해 이해하고, 배우고, 실생활에 활용하는 소통 지식 플랫폼';

  static const String philosophy =
      '소통사이트매니저는 링크를 모아 두는 곳이 아닙니다. '
      '소통회장이 만든 전문 지식 사이트를 하나의 허브로 연결하고, '
      '누구나 중요한 지식을 쉽게 시작하면서도 필요할 때 실무·전문 수준까지 '
      '깊이 들어갈 수 있도록 안내합니다. '
      '쉬운 설명과 깊은 내용을 함께 두고, 이해와 활용을 중심으로 운영합니다.';

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
