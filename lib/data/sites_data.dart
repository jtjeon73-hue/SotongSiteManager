import 'package:flutter/material.dart';

import '../models/difficulty_level.dart';
import '../models/knowledge_site.dart';
import '../models/site_status.dart';

/// Specialist hall catalog. Keep URLs and IDs stable.
abstract final class SitesData {
  static const List<KnowledgeSite> sites = [
    KnowledgeSite(
      id: 'ai-story',
      routeSlug: 'ai-story',
      name: '소통AI스토리',
      shortName: 'AI스토리',
      description: 'AI 역사·개념·활용·안전까지 체계적으로 안내하는 AI 지식 전문관',
      detailedDescription:
          '소통AI스토리는 AI의 역사와 변천사, 핵심 개념, 도구 탐색과 비교, 분야별 활용, '
          '생활·업무 워크플로, 안전·윤리·저작권, 미래 전망과 용어사전까지 '
          '검증된 출처와 함께 단계적으로 살펴보는 AI 학습 플랫폼입니다. '
          '통합 검색과 즐겨찾기로 필요한 내용을 다시 찾아볼 수 있습니다.',
      categoryId: 'ai-digital',
      icon: Icons.auto_awesome_outlined,
      color: Color(0xFF0F766E),
      url: 'https://sotongware-ai-story.web.app',
      status: SiteStatus.live,
      targetUsers: ['AI 입문자', '직장인', '학생', '어르신', '교육·행정 실무자'],
      difficulty: DifficultyLevel.allLevels,
      topics: ['AI 역사 타임라인', '핵심 개념', '도구 탐색·비교', '분야별 활용', '안전·윤리'],
      keywords: ['AI', '인공지능', '챗GPT', '프롬프트', 'LLM', '머신러닝', '디지털'],
      recommendedPath: [
        'AI 역사와 왜 알아야 하는지 살펴보기',
        '핵심 개념을 쉬운 말로 익히기',
        '생활·업무 활용 사례 확인',
        '도구 탐색과 짧은 실습',
        '안전·윤리·저작권 주의점 점검',
      ],
      featured: true,
      sortOrder: 1,
      whyMatters:
          'AI는 이미 검색·문서·번역·업무 도구에 들어와 있습니다. '
          '원리와 한계를 알면 더 안전하고 똑똑하게 활용할 수 있습니다.',
      learningOutcomes: [
        'AI의 가능과 한계를 구분할 수 있다',
        '생활·업무에서 바로 써볼 질문을 만들 수 있다',
        '개인정보·환각·과장 정보를 조심할 수 있다',
      ],
      coreQuestion: 'AI를 어떻게 이해하고, 안전하게 활용할 수 있을까?',
      valueProposition: '역사부터 활용·윤리까지, AI를 쉽게 시작하고 깊게 이어갑니다.',
      startPoint: 'AI 역사 타임라인 또는 핵심 개념부터 시작하세요.',
      menuHighlights: [
        'AI 역사 타임라인',
        '세대별 변천사',
        '핵심 개념',
        'AI 도구 탐색·비교',
        '분야별 활용·워크플로',
        '안전·윤리·저작권',
        '용어사전·출처 검증',
      ],
      beginnerFocus: ['AI가 무엇인지, 왜 중요한지', '쉬운 비유로 핵심 개념 이해', '일상에서 만나는 AI 사례'],
      intermediateFocus: ['도구 탐색과 조건별 비교', '분야별 활용 패턴', '생활·업무 워크플로 구성'],
      advancedFocus: ['안전·윤리·저작권 심화', '미래 전망의 근거와 불확실성 구분', '출처 검증과 용어 정리'],
      useCases: [
        '업무 문서 초안을 더 명확한 질문으로 만들기',
        '학습·행정에서 AI 도구의 한계를 알고 확인하기',
        '가족과 함께 AI 용어를 쉽게 설명하기',
      ],
      safetyNotice:
          'AI 결과는 오류(환각)가 있을 수 있습니다. '
          '중요한 사실·법률·의료·금융 정보는 반드시 추가 확인하세요. '
          '개인정보와 민감 정보는 입력하지 않는 것이 안전합니다.',
      relatedSiteIds: ['english', 'finance'],
      confirmedFeatures: [
        '타임라인·세대별 변천사',
        '핵심 개념 설명',
        'AI 도구 탐색·비교(최대 3개)',
        '분야별 활용·안전 윤리',
        '통합 검색·즐겨찾기·출처 검증센터',
      ],
    ),
    KnowledgeSite(
      id: 'elec',
      routeSlug: 'electric',
      name: '소통전기',
      shortName: '전기',
      description: '생활 전기 상식부터 전기기사 자격 학습까지 이어지는 전기 전문관',
      detailedDescription:
          '소통전기는 전기기사 필기·실기 학습을 중심으로, '
          '강의·공식·기출유형·모의고사·오답·계산기·암기카드와 '
          '일반 전기상식·공구·현장 안전을 함께 다루는 전기 학습 플랫폼입니다. '
          '공식 출처(Q-Net 등)와 자체 콘텐츠를 구분하며, '
          '로컬 진도·오답·즐겨찾기로 꾸준한 학습을 돕습니다.',
      categoryId: 'elec-tech',
      icon: Icons.bolt_outlined,
      color: Color(0xFFC47A12),
      url: 'https://sotong-elec.web.app',
      status: SiteStatus.live,
      targetUsers: ['전기 입문자', '자격 수험생', '현장 실무자', '안전 담당자', '생활 전기 학습자'],
      difficulty: DifficultyLevel.allLevels,
      topics: ['전기 기초', '필기·실기', '공식·계산', '모의고사', '감전·안전'],
      keywords: ['전기', '전기기사', '회로', '전압', '전류', '안전', '자격증', '모의고사'],
      recommendedPath: [
        '학습 목표와 안전 원칙 확인',
        '전기 기초·공식 감각 잡기',
        '필기 과목·기출유형 연습',
        '실기·계산·모의고사로 확장',
        '오답·취약점 복습',
      ],
      featured: true,
      sortOrder: 2,
      whyMatters:
          '전기는 생활과 산업의 기반이며, 잘못된 이해는 사고와 직결됩니다. '
          '쉬운 설명과 자격 학습, 안전 원칙이 함께 필요합니다.',
      learningOutcomes: [
        '기본 전기 용어와 공식을 설명할 수 있다',
        '생활·현장의 전기 위험을 구분할 수 있다',
        '전기기사 학습의 출발점과 복습 루틴을 잡을 수 있다',
      ],
      coreQuestion: '전기 원리와 안전, 자격 공부를 어디서부터 시작할까?',
      valueProposition: '생활 전기부터 전기기사 필기·실기 학습 흐름을 한곳에서 이어갑니다.',
      startPoint: '시험안내와 전기 기초, 또는 일반 전기상식·안전부터 시작하세요.',
      menuHighlights: [
        '시험안내',
        '필기 과목·강의·공식',
        '기출유형·모의고사',
        '실기·계산·암기카드',
        '전기상식·공구·안전',
        '용어·검색·출처',
      ],
      beginnerFocus: ['전압·전류·저항 등 기초 개념', '생활 전기상식과 안전', '시험 구조와 학습 계획'],
      intermediateFocus: ['필기 과목별 공식·문제', '계산기·암기카드 활용', '오답·취약점 관리'],
      advancedFocus: ['모의고사와 과락 대비', '실기·계산 심화', '자격 준비도 점검'],
      useCases: [
        '가정·현장의 전기 위험을 구분하고 전문가에게 맡길 일 알기',
        '전기기사 필기·실기 학습 루틴 만들기',
        '공식·계산을 문제로 복습하기',
      ],
      safetyNotice:
          '감전·화재 위험이 있는 배선·수리·점검 작업은 '
          '자격 있는 전문가에게 의뢰하세요. '
          '학습 콘텐츠는 교육용이며, 실제 현장 작업 지침을 대체하지 않습니다.',
      relatedSiteIds: ['car', 'ai-story'],
      confirmedFeatures: [
        '필기·실기 학습 메뉴',
        '기출유형·모의고사·오답',
        '공식·계산기·암기카드',
        '전기상식·공구·안전',
        '로컬 진도·검색·출처',
      ],
    ),
    KnowledgeSite(
      id: 'car',
      routeSlug: 'car',
      name: '소통카',
      shortName: '카',
      description: '자동차·농기계 점검·정비·이상 증상을 한곳에서 관리하는 전문관',
      detailedDescription:
          '소통카는 자동차와 농기계의 정비주기, 소모품, 정비이력, 고장증상, '
          '계절별 관리를 안내하는 관리정보 플랫폼입니다. '
          '대시보드·캘린더·비용·체크리스트·경고등·증상 안내와 '
          '로컬 장비 등록·정비 기록을 제공합니다. '
          '제조사 사용설명서·정비지침을 항상 우선하며, 주기는 참고값입니다.',
      categoryId: 'auto-mobility',
      icon: Icons.directions_car_outlined,
      color: Color(0xFF1D4F91),
      url: 'https://sotong-car.web.app',
      status: SiteStatus.live,
      targetUsers: ['운전자', '차량 관리 초보', '농기계 사용자', '정비 입문자', '가족 운전자'],
      difficulty: DifficultyLevel.beginner,
      topics: ['정비주기', '소모품', '경고등', '고장증상', '계절 관리', '농기계'],
      keywords: ['자동차', '정비', '엔진', '배터리', '타이어', '점검', '농기계', '경고등'],
      recommendedPath: [
        '차량·장비 기본 정보와 점검 습관 이해하기',
        '오늘의 정비·체크리스트 확인',
        '경고등·이상 증상 사례 살펴보기',
        '정비이력·비용 기록 시작',
        '계절·장거리 운행 전 점검',
      ],
      featured: true,
      sortOrder: 3,
      whyMatters:
          '자동차와 농기계는 안전과 비용이 걸린 생활·업무 도구입니다. '
          '작은 점검 습관이 고장과 사고를 줄입니다.',
      learningOutcomes: [
        '일상 점검 체크리스트를 만들 수 있다',
        '경고등·이상 증상을 가볍게 넘기지 않게 된다',
        '정비소와 소통할 기본 기록을 남길 수 있다',
      ],
      coreQuestion: '내 차와 농기계를 어떻게 안전하고 경제적으로 관리할까?',
      valueProposition: '정비주기·증상·경고등·비용을 생활 언어로 정리해 관리를 돕습니다.',
      startPoint: '대시보드의 오늘의 정비와 기본 점검 체크리스트부터 시작하세요.',
      menuHighlights: [
        '통합 관리 대시보드',
        '오늘의 정비·캘린더',
        '정비이력·비용',
        '체크리스트·증상·경고등',
        '자동차·농기계 관리',
      ],
      beginnerFocus: ['기본 점검 항목', '소모품과 정비주기 개념', '경고등 의미 익히기'],
      intermediateFocus: ['증상별 점검 흐름', '정비이력·비용 관리', '계절·주행거리 맞춤 주기'],
      advancedFocus: ['장비별 맞춤 정비 규칙', '농기계 작업 전후 점검', '안전 가이드와 참고 주기 구분'],
      useCases: [
        '출발 전 타이어·오일·배터리 확인',
        '경고등 점등 시 증상 기록 후 정비소 상담',
        '농기계 작업 전후 점검 습관화',
      ],
      safetyNotice:
          '안전과 직결되는 제동·조향·리프트·전기 계통 정비는 '
          '전문 정비소 점검이 필요합니다. '
          '사이트 주기는 참고값이며 제조사 지침을 우선하세요.',
      relatedSiteIds: ['elec', 'finance'],
      confirmedFeatures: [
        '자동차·농기계 관리',
        '정비주기·소모품·이력',
        '체크리스트·증상·경고등',
        '대시보드·캘린더·비용',
        '로컬 등록·검색·백업',
      ],
    ),
    KnowledgeSite(
      id: 'finance',
      routeSlug: 'finance',
      name: '소통금융',
      shortName: '금융',
      description: '돈의 원리부터 저축·투자·세금·연금까지 배우는 금융교육 전문관',
      detailedDescription:
          '소통금융은 금융 기초, 돈 관리, 예금·적금, 부동산, 주식·ETF, 채권, '
          '금·원자재, 보험, 대출·신용, 세금, 연금·은퇴, 경제와 시장, '
          '금융사기 예방과 교육용 계산 도구를 다루는 금융·자산관리 교육 사이트입니다. '
          '특정 상품·종목의 매수·매도 추천이나 수익 보장을 하지 않으며, '
          '개인 의사결정은 공식기관·전문가 확인을 권합니다.',
      categoryId: 'finance-economy',
      icon: Icons.account_balance_outlined,
      color: Color(0xFF1F7A5C),
      url: 'https://sotong-finance.web.app',
      status: SiteStatus.live,
      targetUsers: ['금융 입문자', '직장인', '학생', '가정 재무 관리자', '은퇴 준비자'],
      difficulty: DifficultyLevel.beginner,
      topics: ['금융 기초', '가계·저축', '투자 개념', '세금·연금', '금융사기 예방'],
      keywords: ['금융', '투자', '저축', '세금', '경제', '자산', '이자', '대출', '보험'],
      recommendedPath: [
        '금융 기초와 돈의 흐름 이해하기',
        '가계·저축·비상자금 정리',
        '위험·수익·분산 개념 익히기',
        '세금·보험·대출의 기본 주의점',
        '금융사기 예방과 교육용 계산 연습',
      ],
      featured: true,
      sortOrder: 4,
      whyMatters:
          '금융 지식은 평생 반복되는 선택의 기준입니다. '
          '쉬운 이해와 신중한 원칙이 함께해야 실생활에 도움이 됩니다.',
      learningOutcomes: [
        '수입·지출·저축의 기본 구조를 설명할 수 있다',
        '위험과 수익의 관계를 이해한다',
        '과장 광고·사기 정보에 더 신중해진다',
      ],
      coreQuestion: '돈의 흐름을 이해하고 신중하게 판단하려면?',
      valueProposition: '상품 추천이 아닌 금융 원리와 생활 판단을 교육 중심으로 안내합니다.',
      startPoint: '금융 기초와 돈 관리 메뉴부터 시작하세요.',
      menuHighlights: [
        '금융 기초·돈 관리',
        '예금·적금·부동산',
        '주식·ETF·채권·금',
        '보험·대출·세금·연금',
        '금융사기 예방·계산도구',
      ],
      beginnerFocus: ['이자·현금흐름 개념', '저축과 비상자금', '금융사기 기본 예방'],
      intermediateFocus: ['분산·위험·수익 관계', '보험·대출·세금 기초', '교육용 계산기로 감각 익히기'],
      advancedFocus: ['연금·은퇴 준비 관점', '시장·경제 지표의 의미', '개인 의사결정 전 확인 습관'],
      useCases: [
        '가계부와 비상자금 기준 세우기',
        '대출·보험 설명을 이해하기',
        '자동차 구매·유지비와 금융 판단 연결하기',
      ],
      safetyNotice:
          '본 사이트는 교육용 정보입니다. '
          '개인별 투자·대출·세금·보험 판단은 공식기관과 전문가 확인이 필요합니다. '
          '특정 상품 매매 추천이나 수익을 보장하지 않습니다.',
      relatedSiteIds: ['car', 'ai-story'],
      confirmedFeatures: [
        '금융 기초~연금·세금 교육 메뉴',
        '금융사기 예방',
        '교육용 계산 도구',
        '용어·시나리오·출처',
        '상품 추천 비포함 원칙',
      ],
    ),
    KnowledgeSite(
      id: 'english',
      routeSlug: 'language',
      name: '소통영어',
      shortName: '영어',
      description: '단어·문장·회화를 테마별로 익히는 생활영어 학습 전문관',
      detailedDescription:
          '소통영어(SotongLanguage)는 한국어 초급자를 위한 어학 학습 플랫폼으로, '
          '기본 단어, 문장, 대화, 문법 레슨, 퀴즈, 여행 표현, '
          '테마별 회화(인사·자기소개·여행·농업·공장·IT 등)를 제공합니다. '
          '문법 암기보다 실제 장면에서 바로 쓰는 표현을 중심으로 '
          '짧은 반복 학습을 이어가도록 구성됩니다.',
      categoryId: 'english-language',
      icon: Icons.translate_outlined,
      color: Color(0xFF5B4B8A),
      url: 'https://sotong-language.web.app',
      status: SiteStatus.live,
      targetUsers: ['영어 입문자', '생활회화 학습자', '학생', '직장인', '어르신'],
      difficulty: DifficultyLevel.beginner,
      topics: ['기본 단어', '생활 문장', '테마 회화', '문법 레슨', '여행 표현'],
      keywords: ['영어', '회화', '표현', '문법', '듣기', '말하기', '학습', '여행영어'],
      recommendedPath: [
        '인사·자기소개 등 생활 장면 고르기',
        '핵심 단어·문장 짧게 익히기',
        '테마 대화로 바로 써보기',
        '필요한 문법 레슨만 보완',
        '퀴즈·복습으로 고정하기',
      ],
      featured: true,
      sortOrder: 5,
      whyMatters:
          '영어는 정보 접근과 소통의 도구입니다. '
          '처음부터 어렵게 시작하면 포기하기 쉬우므로 생활 중심으로 쌓는 것이 중요합니다.',
      learningOutcomes: [
        '자주 쓰는 생활 문장을 말할 수 있다',
        '짧은 학습 루틴을 만들 수 있다',
        '틀려도 대화를 이어가는 자신감을 얻는다',
      ],
      coreQuestion: '영어를 기초부터 생활 속에서 어떻게 이어갈까?',
      valueProposition: '단어·문장·회화를 테마별로 나눠 부담 없이 반복할 수 있습니다.',
      startPoint: '인사·자기소개 문장과 기본 단어부터 시작하세요.',
      menuHighlights: ['기본 단어·문장', '테마별 대화', '문법 레슨', '퀴즈', '여행·상황 표현'],
      beginnerFocus: ['인사·자기소개', '자주 쓰는 생활 문장', '하루 10분 반복 습관'],
      intermediateFocus: ['여행·업무 장면 표현', '기초 문법 레슨 보완', '테마 대화 확장'],
      advancedFocus: [
        '현장·IT·농업 등 테마 문장',
        '인터뷰·일기형 연습',
        'AI 도구와 함께 복습(관련 전문관 연결)',
      ],
      useCases: [
        '카페·병원·여행에서 짧은 문장 쓰기',
        '직장·학습에서 기본 표현 익히기',
        '가족과 함께 하루 한 장면 복습',
      ],
      safetyNotice:
          '학습 자료이며 상황과 문화권에 따라 자연스러운 표현이 달라질 수 있습니다. '
          '중요한 공식·법률·의료 통역에는 전문가의 도움을 받으세요.',
      relatedSiteIds: ['ai-story'],
      confirmedFeatures: [
        '단어·문장·회화 데이터',
        '테마별 대화',
        '문법 레슨·퀴즈',
        '여행 표현',
        '초급자 중심 구성',
      ],
    ),
  ];
}
