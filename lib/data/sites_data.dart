import 'package:flutter/material.dart';

import '../models/difficulty_level.dart';
import '../models/knowledge_site.dart';
import '../models/site_quick_link.dart';
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
      relatedSiteIds: ['english', 'finance', 'development', 'country-ai'],
      secondaryCategoryIds: ['dev-automation', 'farm-rural'],
      homeGroupIds: ['future'],
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
      relatedSiteIds: ['car', 'ai-story', 'plc'],
      secondaryCategoryIds: ['plc-automation'],
      homeGroupIds: ['tech'],
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
      secondaryCategoryIds: ['elec-tech', 'finance-economy'],
      homeGroupIds: ['life'],
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
      relatedSiteIds: ['car', 'ai-story', 'health'],
      secondaryCategoryIds: ['health-life'],
      homeGroupIds: ['life'],
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
      relatedSiteIds: ['ai-story', 'development', 'health'],
      secondaryCategoryIds: ['ai-digital', 'dev-automation'],
      homeGroupIds: ['life'],
      confirmedFeatures: [
        '단어·문장·회화 데이터',
        '테마별 대화',
        '문법 레슨·퀴즈',
        '여행 표현',
        '초급자 중심 구성',
      ],
    ),
    KnowledgeSite(
      id: 'health',
      routeSlug: 'health',
      name: '소통건강',
      shortName: '건강',
      description: '질환·증상·생활습관을 근거 기반으로 안내하는 건강·생활 전문관',
      detailedDescription:
          '소통건강(Sotong Health)은 한국인을 위한 교육용 건강정보 플랫폼입니다. '
          '질환·증상·검진·치료 이해·영양·운동·연령별 관리를 연결하고, '
          '공식 출처와 검증 상태를 확인할 수 있도록 구성합니다. '
          '개인 진단·처방·약물 용량 결정을 대신하지 않으며, '
          'AI 건강 길잡이는 로컬 지식 검색·방문 준비 정리용이고 외부 생성형 AI API는 연결되어 있지 않습니다. '
          '의료진 감수 완료 콘텐츠는 아직 없다고 명시되어 있습니다.',
      categoryId: 'health-life',
      icon: Icons.favorite_outline,
      color: Color(0xFFB42318),
      url: 'https://sotong-health-site.web.app',
      status: SiteStatus.live,
      targetUsers: ['일반인', '중장년', '가족 돌봄자', '생활 건강 학습자'],
      difficulty: DifficultyLevel.beginner,
      topics: ['건강 기초', '주요 질환', '증상으로 찾기', '영양·운동', '연령별 건강', '응급 안내'],
      keywords: ['건강', '질환', '증상', '검진', '영양', '운동', '예방', '노후 건강'],
      recommendedPath: [
        '건강 기초교실과 사이트 이용 안내 확인',
        '증상·질환 메뉴로 관심 주제 살펴보기',
        '영양·운동·예방 생활습관 확인',
        '응급 상황 안내와 병원 방문 준비 습관 익히기',
        '출처·한계를 함께 확인하며 학습',
      ],
      featured: true,
      sortOrder: 6,
      whyMatters:
          '건강 정보는 많지만 근거와 한계가 흐려지면 오해가 생깁니다. '
          '쉬운 설명과 공식 출처 확인 습관이 함께 필요합니다.',
      learningOutcomes: [
        '교육용 건강정보와 진단·처방을 구분할 수 있다',
        '증상·질환·생활습관 정보를 체계적으로 찾아볼 수 있다',
        '응급 상황과 전문가 상담이 필요한 때를 구분할 수 있다',
      ],
      coreQuestion: '건강 정보를 어떻게 올바르게 이해하고 생활습관에 연결할까?',
      valueProposition: '진단이 아니라 이해와 생활 준비를 돕는 건강정보 전문관입니다.',
      startPoint: '건강 기초교실 또는 관심 질환·증상 메뉴부터 시작하세요.',
      menuHighlights: [
        '건강 기초교실',
        '인체 구조와 기능',
        '주요 질환·증상으로 찾기',
        '검진·치료 이해·영양·운동',
        '연령별 건강·응급상황',
        'AI 건강 길잡이(로컬 지식 안내)',
      ],
      beginnerFocus: ['건강 기초와 이용 안내', '생활습관·예방의 기본', '응급 시 119 안내 확인'],
      intermediateFocus: ['질환·증상 연결 이해', '검진·치료 용어 익히기', '영양·운동·연령별 관리'],
      advancedFocus: ['출처·검증 상태 확인', '방문 준비 체크리스트 활용', '한계(진단 아님)를 분명히 하기'],
      useCases: [
        '병원 방문 전 물어볼 내용을 정리하기',
        '중장년 생활습관 정보를 가족과 함께 보기',
        '응급 증상과 일반 정보를 구분하기',
      ],
      safetyNotice:
          '일반적인 교육용 건강정보이며 진단·처방·약물 변경을 대신하지 않습니다. '
          '응급 증상은 즉시 119 또는 의료기관을 이용하고, '
          '개인 증상은 의료전문가 확인이 필요합니다. '
          '외부 생성형 AI API는 연결되어 있지 않습니다.',
      relatedSiteIds: ['finance', 'english', 'country-ai'],
      secondaryCategoryIds: ['finance-economy', 'farm-rural'],
      homeGroupIds: ['life'],
      confirmedFeatures: [
        '질환·증상·검진·영양·운동 메뉴',
        '응급상황 안내',
        '로컬 지식 기반 AI 건강 길잡이(외부 AI 미연결)',
        '출처·검증·검색',
        '진단·처방 금지 원칙',
      ],
    ),
    KnowledgeSite(
      id: 'plc',
      routeSlug: 'plc',
      name: '소통PLC',
      shortName: 'PLC',
      description: 'PLC 기초부터 제조사·통신·MFC 연동까지 다루는 산업자동화 전문관',
      detailedDescription:
          '소통PLC는 PLC와 산업자동화 기술 학습·개발 참고를 위한 공개 기술 지식 플랫폼입니다. '
          'PLC 시작하기·기초, LS ELECTRIC·미쓰비시·지멘스, '
          'MFC 연동·산업용 통신·센서·제어기기·실습 예제, '
          '현장 문제 해결·포트폴리오 자료를 제공합니다. '
          '교육·참고 목적이며 실제 설비 적용 시 공식 매뉴얼과 안전 규격을 확인해야 합니다.',
      categoryId: 'plc-automation',
      icon: Icons.precision_manufacturing_outlined,
      color: Color(0xFF4A6FA5),
      url: 'https://sotongware-plc.web.app',
      status: SiteStatus.live,
      targetUsers: ['자동화 입문자', '설비 실무자', '전기·제어 학습자', 'MFC·통신 개발자'],
      difficulty: DifficultyLevel.allLevels,
      topics: ['PLC 기초', 'LS·미쓰비시·지멘스', '센서·제어', '산업 통신', 'MFC 연동', '현장 트러블슈팅'],
      keywords: ['PLC', '피엘씨', '자동화', '제어', '센서', '통신', 'MFC', '공장 자동화'],
      recommendedPath: [
        'PLC 시작하기와 기초 개념 확인',
        '제조사별 입문 자료 살펴보기',
        '센서·제어기기와 통신 개념 익히기',
        'MFC·연동·실습 예제 확장',
        '현장 문제 해결과 안전 주의점 점검',
      ],
      featured: true,
      sortOrder: 7,
      whyMatters:
          '공장과 설비의 자동화는 센서·제어·통신 이해가 핵심입니다. '
          '기초부터 제조사·연동까지 이어져야 현장 학습이 가능합니다.',
      learningOutcomes: [
        'PLC의 역할과 기본 구조를 설명할 수 있다',
        '제조사·센서·통신의 연결 관계를 이해할 수 있다',
        '실제 작업 전 안전·매뉴얼 확인의 필요성을 안다',
      ],
      coreQuestion: 'PLC와 공장자동화를 어디서부터 어떻게 배울까?',
      valueProposition: '기초·제조사·통신·MFC 연동을 한 흐름으로 안내합니다.',
      startPoint: 'PLC 시작하기와 기초, 학습 로드맵부터 시작하세요.',
      menuHighlights: [
        'PLC 시작하기·기초·로드맵',
        'LS·미쓰비시·지멘스',
        'MFC 연동·산업용 통신',
        '센서·제어기기·실습',
        '현장 문제 해결·자료실',
      ],
      beginnerFocus: ['PLC란 무엇인가', '기본 입출력·스캔 개념', '안전 주의'],
      intermediateFocus: ['제조사별 특징', '센서·제어기기', '통신 기초'],
      advancedFocus: ['MFC/C++ 연동', '현장 트러블슈팅', '프로젝트·포트폴리오'],
      useCases: [
        '자동화 입문자가 전체 지도를 잡기',
        '전기 기초 후 제어·통신으로 확장하기',
        'PC·MFC와 PLC 데이터 연동 개념 익히기',
      ],
      safetyNotice:
          '감전·화재·기계 동작 위험이 있습니다. '
          '실제 설비 작업 전 전원 차단과 안전절차를 지키고, '
          '현장 매뉴얼과 자격 있는 담당자 확인이 필요합니다. '
          '개인용·상용 최신 프레임·메모리 주소를 보장하지 않습니다.',
      relatedSiteIds: ['elec', 'development', 'smart-farm', 'web-app-dev'],
      secondaryCategoryIds: ['elec-tech', 'dev-automation', 'smartfarm-agri'],
      homeGroupIds: ['tech'],
      confirmedFeatures: [
        'PLC 기초·로드맵',
        '제조사별 자료',
        'MFC·통신·센서 메뉴',
        '실습·현장 문제 해결',
        '교육·참고 목적 명시',
      ],
    ),
    KnowledgeSite(
      id: 'smart-farm',
      routeSlug: 'smart-farm',
      name: '소통스마트팜',
      shortName: '스마트팜',
      description: '센서·제어·데이터·운영까지 스마트팜 기술을 체계적으로 안내하는 전문관',
      detailedDescription:
          '소통스마트팜은 스마트농업에 쓰이는 하드웨어·소프트웨어·PLC·센서·통신·'
          '데이터 분석·자동화 기술을 체계적으로 설명하는 기술정보 사이트입니다. '
          '과장된 “AI가 다 해준다”는 표현을 피하고, '
          'AI 결과와 제어 명령을 구분하며 수동안전·인터록·비상정지의 필요성을 함께 설명합니다. '
          '현재 단계는 입문·기초 중심 학습 콘텐츠와 교육용 퀴즈·프롬프트 라이브러리를 포함합니다.',
      categoryId: 'smartfarm-agri',
      icon: Icons.agriculture_outlined,
      color: Color(0xFF3F7D4E),
      url: 'https://sotong-smart-farm.web.app',
      status: SiteStatus.live,
      targetUsers: ['귀농·귀촌 준비자', '스마트팜 운영자', '농업계 학생', '센서·PLC 기술자', '개발자'],
      difficulty: DifficultyLevel.allLevels,
      topics: ['스마트팜 이해', '재배·축산 환경', '센서·계측', '제어·PLC', '통신·소프트웨어', '안전·보안'],
      keywords: ['스마트팜', '스마트농업', '농사', '농업', '센서', '제어', '데이터', '자동화'],
      recommendedPath: [
        '스마트팜 이해와 적용 범위 확인',
        '재배·환경과 센서·계측 기초',
        '제어·PLC·통신 개념 연결',
        '소프트웨어·데이터·AI의 역할과 한계 구분',
        '구축·운영·안전·보안 점검',
      ],
      featured: true,
      sortOrder: 8,
      whyMatters:
          '스마트팜은 센서·제어·데이터·운영이 함께 맞물립니다. '
          '기술만 따로 보면 현장 적용이 어렵습니다.',
      learningOutcomes: [
        '스마트팜 구성 요소를 설명할 수 있다',
        '센서·제어·데이터 흐름을 구분할 수 있다',
        'AI·자동화의 한계와 안전장치를 이해한다',
      ],
      coreQuestion: '스마트팜과 농업기술을 어떤 순서로 이해해야 할까?',
      valueProposition: '과장 없이 센서·제어·데이터·운영을 한 줄로 연결합니다.',
      startPoint: '스마트팜 이해 메뉴부터 시작하고 센서·제어로 확장하세요.',
      menuHighlights: [
        '스마트팜 이해',
        '재배·축산 환경',
        '센서·계측·제어·PLC',
        '하드웨어·통신·소프트웨어',
        'AI·데이터·구축·운영·안전',
      ],
      beginnerFocus: ['스마트팜 개념', '환경·센서의 역할', '안전 기본'],
      intermediateFocus: ['제어·PLC 연결', '통신·소프트웨어', '운영 체크포인트'],
      advancedFocus: ['데이터·AI의 한계 구분', '구축·보안', '현장 조건별 검토'],
      useCases: [
        '귀농 전 기술 용어 지도 잡기',
        'PLC·센서 지식을 농업 현장에 연결하기',
        '농업 데이터 시각화·개발로 확장하기',
      ],
      safetyNotice:
          '전기·농약·기계·고온·시설 안전에 주의하세요. '
          '작물과 지역 환경에 따라 결과가 달라질 수 있으며, '
          '실제 도입 전 전문가와 현장 조건 확인이 필요합니다.',
      relatedSiteIds: ['plc', 'development', 'country-ai'],
      secondaryCategoryIds: ['plc-automation', 'farm-rural', 'dev-automation'],
      homeGroupIds: ['tech'],
      confirmedFeatures: [
        '스마트팜 전체 메뉴 구조',
        '센서·PLC·통신·소프트웨어',
        'AI·데이터 역할과 한계 설명',
        '교육용 퀴즈·프롬프트 라이브러리',
        '안전·보안 안내',
      ],
    ),
    KnowledgeSite(
      id: 'development',
      routeSlug: 'development',
      name: '소통개발',
      shortName: '개발',
      description: '개발 기초부터 Python·Dart·Flutter·실무·AI 활용까지 배우는 프로그래밍 전문관',
      detailedDescription:
          '소통개발(SotongDev)은 초보부터 실무·아키텍처·AI 활용까지 '
          '체계적으로 학습할 수 있는 Flutter Web 교육 사이트입니다. '
          '맞춤 로드맵, 컴퓨터 기본지식, Python, Dart·Flutter, 개발 도구, '
          '실무·프로젝트·퀴즈·용어집을 제공합니다. '
          '예제 코드는 학습용이며 실제 운영 전 보안·오류·백업 검토가 필요합니다.',
      categoryId: 'dev-automation',
      icon: Icons.code_outlined,
      color: Color(0xFF355C7D),
      url: 'https://sotong-dev.web.app',
      status: SiteStatus.live,
      targetUsers: ['코딩 입문자', '학생', '주니어 개발자', '실무 전환 학습자'],
      difficulty: DifficultyLevel.allLevels,
      topics: [
        '개발 기초',
        'Python',
        'Dart·Flutter',
        '개발 도구',
        '실무·프로젝트',
        'AI 시대 개발',
      ],
      keywords: ['코딩', '프로그래밍', '개발', 'Python', 'Flutter', 'Dart', '앱 만들기'],
      recommendedPath: [
        '맞춤 학습 로드맵과 오늘 학습 확인',
        '개발자 기본지식으로 컴퓨터·네트워크 감각 잡기',
        'Python 또는 Dart·Flutter 입문',
        '도구·실무·미니 프로젝트로 확장',
        '퀴즈·용어집으로 복습',
      ],
      featured: true,
      sortOrder: 9,
      whyMatters:
          '소프트웨어는 생활과 산업의 기반입니다. '
          '기초부터 언어·도구·프로젝트로 이어져야 실무 학습이 가능합니다.',
      learningOutcomes: [
        '개발 학습의 전체 지도를 잡을 수 있다',
        'Python 또는 Flutter 입문 경로를 선택할 수 있다',
        '학습용 코드와 운영 코드의 차이를 이해한다',
      ],
      coreQuestion: '코딩과 앱 개발을 어떤 순서로 시작하면 될까?',
      valueProposition: '기초·언어·도구·프로젝트·AI 활용을 로드맵으로 이어줍니다.',
      startPoint: '맞춤 학습 로드맵 또는 개발자 기본지식부터 시작하세요.',
      menuHighlights: [
        '맞춤 로드맵·오늘 학습',
        '개발자 기본지식',
        'Python',
        'Dart·Flutter',
        '퀴즈·용어집·검색',
      ],
      beginnerFocus: ['로드맵 설정', '컴퓨터 기초', '첫 언어 입문'],
      intermediateFocus: ['문법·모듈', 'HTTP·자료구조 감각', '미니 프로젝트'],
      advancedFocus: ['실무·성능·패키징', 'AI·머신러닝 활용 학습', '프로젝트 심화'],
      useCases: [
        '앱 만들기를 위한 Flutter 입문',
        'PLC·스마트팜 데이터를 다루는 소프트웨어 기초',
        'AI 도구를 개발 학습에 보조로 쓰기',
      ],
      safetyNotice:
          '예제 코드는 학습용입니다. '
          '실제 운영 전 보안·오류·백업을 검토하고, '
          '비밀번호와 API 키를 소스에 저장하지 마세요.',
      relatedSiteIds: [
        'ai-story',
        'plc',
        'smart-farm',
        'english',
        'web-app-dev',
      ],
      secondaryCategoryIds: ['ai-digital', 'plc-automation', 'smartfarm-agri'],
      homeGroupIds: ['tech'],
      confirmedFeatures: [
        '로드맵·진도·퀴즈',
        '기본지식·Python·Dart·Flutter',
        '도구·실무·프로젝트 레슨',
        '용어집·검색',
        '학습용 코드 정책',
      ],
    ),
    KnowledgeSite(
      id: 'web-app-dev',
      routeSlug: 'web-app-dev',
      name: '소통웹·앱·MFC DEV',
      shortName: '웹앱MFC',
      description: '웹·Flutter 앱·MFC 개발을 단계별로 학습하고 실무 자료와 개발 프롬프트를 확인하는 개발 전문관',
      detailedDescription:
          '소통웹·앱·MFC DEV(SotongWebAppDev)는 웹사이트·앱·MFC 개발에 필요한 '
          '환경·도구·개발과정·AI 프롬프트·설정·검증·배포를 체계적으로 정리한 '
          '개인 개발 지식 플랫폼입니다. '
          '웹 개발, 앱 개발, MFC 개발 메뉴로 분야별 순서를 따라가며 '
          'Cursor/GPT 프롬프트 복사, 검증·수수료·Git·배포 절차, '
          '웹(Firebase)·앱(APK/Play)·MFC(현장 배포) 준비를 확인할 수 있습니다. '
          '예제·프롬프트는 학습·참고용이며 실제 운영 전 보안·백업·현장 절차 확인이 필요합니다.',
      categoryId: 'dev-automation',
      icon: Icons.developer_board_outlined,
      color: Color(0xFF2F5D8C),
      url: 'https://sotong-web-app-dev.web.app',
      status: SiteStatus.live,
      targetUsers: ['웹 개발 입문자', 'Flutter 앱 학습자', 'MFC·현장 개발자', '실무 전환 학습자'],
      difficulty: DifficultyLevel.allLevels,
      topics: ['웹 개발', '앱 개발', 'MFC 개발', '개발 환경·도구', '프롬프트', '검증·배포'],
      keywords: [
        '웹개발',
        '앱개발',
        'MFC',
        'Flutter',
        'Firebase',
        '프롬프트',
        '배포',
        'SotongWebAppDev',
      ],
      recommendedPath: [
        '관심 분야(웹·앱·MFC) 개요 확인',
        '개발환경·도구 선택 가이드 살펴보기',
        '개발 과정과 프롬프트 메뉴로 실습 흐름 잡기',
        '검증·Git·배포(유지보수) 절차 확인',
        '소통개발·소통PLC와 교차 학습',
      ],
      featured: true,
      sortOrder: 11,
      whyMatters:
          '언어 문법만으로는 실제 웹·앱·MFC 산출물을 만들기 어렵습니다. '
          '환경·도구·과정·검증·배포가 한 줄로 이어져야 실무 학습이 됩니다.',
      learningOutcomes: [
        '웹·앱·MFC 각각의 학습·배포 흐름을 구분할 수 있다',
        '환경·도구·프롬프트를 단계별로 활용할 수 있다',
        '검증·Git·배포 전 점검 항목을 확인할 수 있다',
      ],
      coreQuestion: '웹·앱·MFC 개발을 환경부터 배포까지 어떻게 따라갈까?',
      valueProposition: '분야별 과정·도구·프롬프트·배포를 한곳에서 안내합니다.',
      startPoint: '웹·앱·MFC 중 관심 분야의 개요·환경 메뉴부터 시작하세요.',
      menuHighlights: [
        '웹사이트 개발(환경·도구·과정·프롬프트·Firebase)',
        '앱 개발(환경·도구·과정·APK·Play Store)',
        'MFC 개발(환경·도구·UI·PLC 연동·현장 배포)',
        '검증·개선·유지보수',
      ],
      beginnerFocus: ['분야 개요', '환경·도구 선택', '기본 개발 과정'],
      intermediateFocus: ['프롬프트 활용', '검증·Git', '배포 준비'],
      advancedFocus: ['아키텍처·보안·성능 참고', '운영·플레이북', 'PLC·현장 연동'],
      useCases: [
        '웹 Hosting 배포 전 절차 점검하기',
        'Flutter 앱 서명·스토어 준비 흐름 보기',
        'MFC와 PLC 장치 연동 학습을 소통PLC와 함께 보기',
      ],
      safetyNotice:
          '예제 코드와 프롬프트는 학습·참고용입니다. '
          '실제 운영·현장 배포 전 보안·오류·백업·자격·매뉴얼을 확인하고, '
          '비밀번호와 API 키·서비스 계정 키를 소스에 저장하지 마세요.',
      relatedSiteIds: ['development', 'plc', 'ai-story'],
      secondaryCategoryIds: ['plc-automation', 'ai-digital'],
      homeGroupIds: ['tech'],
      confirmedFeatures: [
        '웹·앱·MFC 분야별 메뉴',
        '환경·도구·과정·프롬프트',
        '검증·Git·배포·유지보수',
        'Firebase·APK/Play·현장 배포 안내',
        '학습·참고용 프롬프트·자료',
      ],
    ),
    KnowledgeSite(
      id: 'country-ai',
      routeSlug: 'country-ai',
      name: '소통농촌AI',
      shortName: '농촌AI',
      description: '사매면 사례로 농촌생활·지역발전·AI 활용 아이디어를 정리하는 전문관',
      detailedDescription:
          '소통농촌AI(사매 미래 AI마을)는 사매면의 현황·생활정보·발전 아이디어를 '
          '주민과 행정이 함께 검토할 수 있도록 정리한 민간 정보·제안 플랫폼입니다. '
          '미래 사매, 주민의 하루, 생활·돌봄, 사업·지역경제, 문화·공동체, '
          '실행·제안·사매 차별화 전략 메뉴를 제공합니다. '
          '로컬 구조화 데이터 기반이며, AI 제안은 참고자료이고 최종 결정은 사람이 합니다. '
          '의견 보내기는 데모 UI이며 실제 전송·저장 서버는 현재 단계에 없습니다.',
      categoryId: 'farm-rural',
      icon: Icons.cottage_outlined,
      color: Color(0xFF6B8F71),
      url: 'https://sotong-country-ai.web.app',
      status: SiteStatus.live,
      targetUsers: ['주민', '행정·기획 관계자', '귀촌 관심자', '지역발전 학습자'],
      difficulty: DifficultyLevel.beginner,
      topics: ['사매면 이해', '주민의 하루', '생활·돌봄', '농업·관광', '차별화 전략', 'AI 활용 아이디어'],
      keywords: ['시골', '귀촌', '지역', '마을', '농촌', '사매', '지역발전', '관광'],
      recommendedPath: [
        '비전과 사매면 이해하기',
        '주민의 하루·생활정보 살펴보기',
        '사업·지역경제·문화 메뉴 확인',
        '차별화 전략·로드맵·시범사업 아이디어 검토',
        '현실/제안/검증필요 라벨을 구분해 읽기',
      ],
      featured: true,
      sortOrder: 10,
      whyMatters:
          '지역 발전은 기술만이 아니라 생활·주민·행정·예산이 함께 맞춰져야 합니다. '
          '사례와 제안의 경계를 분명히 보는 것이 중요합니다.',
      learningOutcomes: [
        '농촌·지역 정보를 현실과 제안으로 구분해 읽을 수 있다',
        '사매면 사례를 통해 지역 이슈의 틀을 이해할 수 있다',
        'AI 아이디어를 참고 수준으로 다룰 수 있다',
      ],
      coreQuestion: '농촌생활과 지역발전을 어떻게 체계적으로 살펴볼까?',
      valueProposition: '사매면 사례로 생활·경제·문화·실행 제안을 한곳에서 봅니다.',
      startPoint: '비전·사매면 이해하기 또는 주민의 하루부터 시작하세요.',
      menuHighlights: [
        '비전·사매면 이해하기·주민의 하루',
        '생활도우미·교통·건강·돌봄',
        '스마트농업·상권·빈집·귀농',
        '문화·행사·관광·교육',
        '차별화 전략·로드맵·시범사업·출처',
      ],
      beginnerFocus: ['사매면 이해', '주민의 하루', '생활정보'],
      intermediateFocus: ['사업·상권·관광', '문화·공동체', '실행 제안 구분'],
      advancedFocus: ['차별화 전략 문서', '시범사업·성과 프레임', '출처·검증필요 라벨'],
      useCases: [
        '귀촌 전 지역 생활 이슈 미리 보기',
        '스마트팜·AI 아이디어를 지역 맥락에 연결하기',
        '주민·행정 논의용 공통 자료로 활용하기',
      ],
      safetyNotice:
          '지역과 주민 상황에 따라 적용 결과가 다릅니다. '
          '실제 사업은 주민 의견·예산·행정·법규 검토가 필요하며, '
          'AI 제안은 참고자료이고 최종 결정이 아닙니다. '
          '개인정보·의료·안전 판단에서 사람의 최종 확인이 필요합니다.',
      relatedSiteIds: ['smart-farm', 'ai-story', 'health'],
      secondaryCategoryIds: ['smartfarm-agri', 'ai-digital', 'health-life'],
      homeGroupIds: ['future'],
      confirmedFeatures: [
        '사매면 비전·생활·경제·문화 메뉴',
        '주민의 하루',
        '차별화 전략·로드맵·시범사업',
        '현실/제안/검증필요 라벨',
        '로컬 데이터 기반(생성형 AI 결정 아님)',
      ],
    ),
    KnowledgeSite(
      id: 'save-live',
      routeSlug: 'save-live',
      name: '소통노후',
      shortName: '소통노후',
      description: '인생 후반기와 노후를 체계적으로 준비하는 지식 전문관',
      detailedDescription:
          '소통노후는 돈과 평생 일, 건강, 관계, 주거, 돌봄, 농촌생활, '
          '마음의 쉼과 삶의 마무리까지 인생 후반기를 체계적으로 준비하는 '
          '노후 지식 전문관입니다. '
          '정해진 질문에 답하거나 개인정보를 입력하는 방식이 아니라, '
          '다양한 사람들의 노후 인생과 선택에 따른 미래를 읽고 비교하며 '
          '자신의 방향을 생각하도록 돕습니다. '
          '로컬 콘텐츠 기반이며 외부 생성형 AI API는 연결되어 있지 않습니다. '
          '제도·모집정보는 공식 원문에서 최신 확인이 필요합니다.',
      categoryId: 'life-retirement',
      icon: Icons.self_improvement_outlined,
      color: Color(0xFF8A6A2F),
      url: 'https://sotong-save-live.web.app',
      status: SiteStatus.live,
      targetUsers: [
        '직장생활 후 은퇴를 준비하는 사람',
        '이미 은퇴한 사람',
        '프리랜서로 계속 일하는 사람',
        '사업을 이어가거나 정리하려는 사람',
        '농촌에서 농사와 생활을 이어가는 사람',
        '공무원·교직·공공기관 퇴직자',
        '전업주부·가족돌봄 중심으로 살아온 사람',
        '혼자 노후를 맞이하는 1인 가구',
        '부부가 함께 노후를 맞이하는 사람',
        '자녀 없이 부부가 함께 살아가는 사람',
        '재취업·제2직업을 준비하는 사람',
        '전문기술·예술·창작을 이어가는 사람',
        '경제적 준비가 부족한 상태에서 다시 설계하는 사람',
      ],
      difficulty: DifficultyLevel.allLevels,
      topics: [
        '노후맞이 인생들',
        'AI 인생로드맵',
        '돈과 평생일',
        '건강·관계·생활',
        '농촌과 제2의 인생',
        '노후 주거·돌봄',
        '마음쉼터',
        '아름다운 마무리',
      ],
      keywords: [
        '소통노후',
        '노후',
        '노후 준비',
        '인생 후반기',
        '은퇴',
        '평생 일',
        '노후 건강',
        '주거',
        '돌봄',
        '농촌생활',
        '마음의 쉼',
        'AI 인생설계',
        '노후설계',
        '은퇴준비',
        '평생일',
        '프리랜서 노후',
        '사업자 노후',
        '부부 노후',
        '자녀 없는 부부',
        '1인 가구',
        '실버타운',
        '고령자복지주택',
        '장기요양',
        '노후 주거',
        '마음쉼터',
        '아름다운 마무리',
        'SotongSaveLive',
        '소통세이브라이브',
        '세이브라이브',
      ],
      recommendedPath: [
        '노후맞이 인생들에서 다양한 유형 살펴보기',
        '내 상황과 비슷한 인생 경로 비교',
        'AI 인생로드맵으로 연령대별 흐름 확인',
        '돈·건강·주거·돌봄 메뉴를 연결해 보기',
        '마음쉼터·아름다운 마무리로 정리',
      ],
      featured: true,
      sortOrder: 12,
      whyMatters:
          '돈과 평생 일, 건강, 관계, 주거, 돌봄, 농촌생활, '
          '마음의 쉼과 삶의 마무리까지 인생 후반기를 체계적으로 준비하는 '
          '노후 지식 전문관입니다.',
      learningOutcomes: [
        '노후설계가 돈만의 문제가 아님을 이해할 수 있다',
        '다양한 인생 유형과 시나리오를 비교할 수 있다',
        '주거·돌봄·마음수양 선택지의 차이를 구분할 수 있다',
        '개인 맞춤 확정조언이 아닌 참고 학습의 한계를 안다',
      ],
      coreQuestion: '인생 후반기와 노후를 어떻게 체계적으로 준비할까?',
      valueProposition:
          '돈과 평생 일, 건강, 관계, 주거, 돌봄, 농촌생활, '
          '마음의 쉼과 삶의 마무리까지 함께 살펴봅니다.',
      startPoint: '노후맞이 인생들 또는 AI 인생로드맵부터 시작하세요.',
      menuHighlights: [
        '노후맞이 인생들',
        'AI 인생로드맵',
        '돈과 평생일',
        '건강·관계·생활',
        '농촌과 제2의 인생',
        '노후 주거·돌봄',
        '마음쉼터',
        '아름다운 마무리',
      ],
      beginnerFocus: ['노후맞이 인생 유형 읽기', '연령대별 로드맵 훑어보기', '돈·일·건강의 연결 이해'],
      intermediateFocus: [
        '부부·1인 가구·농촌 시나리오 비교',
        '실버타운·공공주택·돌봄시설 차이',
        '5년·10년 후 변화 시나리오',
      ],
      advancedFocus: ['평생일·부분은퇴·사업 정리', '재가·시설 돌봄 선택 비교', '사전연명의료의향·삶의 마무리 정리'],
      useCases: [
        '은퇴 전 다양한 노후 선택지를 미리 읽고 비교하기',
        '자녀 없는 부부·1인 가구의 주거·돌봄 준비 살펴보기',
        '농촌 노후와 평생일을 함께 검토하기',
        '실버타운·고령자복지주택·장기요양 차이 이해하기',
        '마음쉼터로 노후 정신적 안정 읽기',
      ],
      safetyNotice:
          '의료·법률·연금·세무 내용은 개인 맞춤 확정조언이 아닙니다. '
          '제도·모집정보·요양·주거 시설 정보는 공식 출처에서 최신 확인이 필요합니다. '
          '개인정보와 자산정보를 입력하지 않는 읽기·비교 플랫폼입니다.',
      relatedSiteIds: ['health', 'finance', 'country-ai', 'ai-story'],
      secondaryCategoryIds: ['health-life', 'finance-economy', 'farm-rural'],
      homeGroupIds: ['life-retirement'],
      confirmedFeatures: [
        '노후맞이 인생들·인생 유형 비교',
        'AI 인생로드맵(연령대·시나리오)',
        '돈과 평생일·건강·관계·생활',
        '농촌·주거·돌봄·마음쉼터·마무리',
        '로컬 콘텐츠·외부 생성형 AI 미연결',
        '로그인·개인정보 저장 없음',
        'Firebase Spark Hosting 운영',
      ],
      quickLinks: [
        SiteQuickLink(label: '홈', url: 'https://sotong-save-live.web.app/'),
        SiteQuickLink(
          label: '노후맞이 인생들',
          url: 'https://sotong-save-live.web.app/life-paths',
        ),
        SiteQuickLink(
          label: '자녀 없이 부부가 함께 살아가는 노후',
          url:
              'https://sotong-save-live.web.app/life-paths/childfree-couple-retirement',
        ),
        SiteQuickLink(
          label: 'AI 인생로드맵',
          url: 'https://sotong-save-live.web.app/roadmap',
        ),
        SiteQuickLink(
          label: '돈과 평생일',
          url: 'https://sotong-save-live.web.app/money-work',
        ),
        SiteQuickLink(
          label: '농촌과 제2의 인생',
          url: 'https://sotong-save-live.web.app/rural',
        ),
        SiteQuickLink(
          label: '노후 주거·돌봄',
          url: 'https://sotong-save-live.web.app/housing-care',
        ),
        SiteQuickLink(
          label: '마음쉼터',
          url: 'https://sotong-save-live.web.app/mind-lounge',
        ),
        SiteQuickLink(
          label: '아름다운 마무리',
          url: 'https://sotong-save-live.web.app/legacy',
        ),
      ],
    ),
  ];
}
