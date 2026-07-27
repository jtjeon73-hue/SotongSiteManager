import 'package:flutter/material.dart';

import '../data/knowledge_data.dart';
import '../theme/app_colors.dart';
import '../widgets/common_ui.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PageContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: '소개',
            subtitle: '소통사이트매니저가 지향하는 지식 플랫폼의 목적과 원칙입니다.',
          ),
          _AboutBlock(
            title: '왜 만들었나요',
            body:
                '세상의 중요한 지식은 이미 많이 존재합니다. 그러나 처음 배우는 사람에게는 어렵고, '
                '실무자에게는 단편적으로 흩어져 있는 경우가 많습니다. '
                '소통사이트매니저는 소통회장이 만든 여러 전문 지식 사이트를 하나로 연결해, '
                '관심에서 시작해 이해하고, 배우고, 실생활에 활용할 수 있도록 안내하는 '
                '통합 지식 허브입니다.',
          ),
          _AboutBlock(
            title: '쉬운 설명과 깊이 있는 내용의 균형',
            body:
                '쉬운 말만으로는 전문성이 부족해지고, 깊은 내용만으로는 입문이 막힙니다. '
                '그래서 각 지식은 “왜 알아야 하는가”부터 “핵심 개념 → 생활 사례 → 원리 → '
                '실무 활용 → 실수와 안전 → 복습 → 다음 학습”으로 이어지도록 설계합니다. '
                '메인 허브는 방향을 제시하고, 실제 깊은 학습은 각 전문 사이트에서 이어갑니다.',
          ),
          _AboutBlock(
            title: '정보 수집이 아니라 이해와 활용',
            body:
                '링크를 많이 모으는 것이 목표가 아닙니다. '
                '방문자가 자신의 목적에 맞는 사이트를 발견하고, '
                '왜 배워야 하는지 이해한 뒤, 생활과 실무에 적용할 수 있게 돕는 것이 원칙입니다. '
                '검색과 학습 길잡이, 분야별 탐색은 모두 이 연결을 쉽게 만들기 위한 장치입니다.',
          ),
          _AboutBlock(
            title: '함께 쓰는 지식 공간',
            body:
                '초보자, 어르신, 학생, 실무자가 같은 허브에서 출발할 수 있어야 합니다. '
                '큰 글씨, 높은 대비, 단순한 탐색, 긴 한글 제목의 줄바꿈, '
                '충분한 터치 영역은 배려가 아니라 기본 품질입니다. '
                '고급스럽고 신뢰감 있는 디자인 안에서도 누구나 편하게 읽고 선택할 수 있게 만듭니다.',
          ),
          _AboutBlock(
            title: '계속 연결하고 발전시키는 계획',
            body:
                '현재는 소통AI스토리, 소통전기, 소통카, 소통금융, 소통영어를 연결합니다. '
                '앞으로 건강, 프로그래밍, PLC·산업자동화, 스마트팜, 농업·귀촌, '
                '자동차·농기계, 재무·세금, 외국어, 역사·과학, 지역·관광, 취미·노후처럼 '
                '삶의 중요한 분야를 지속적으로 확장합니다. '
                '새 사이트는 데이터 한 곳을 추가하는 방식으로 홈·검색·분야·길잡이에 반영됩니다.',
          ),
          _AboutBlock(
            title: '정확성과 안전이 중요한 분야의 운영 원칙',
            body:
                '전기, 금융, 건강, 산업자동화처럼 안전과 책임이 큰 분야는 '
                '단정적인 처방이나 과장된 약속을 피하고, '
                '기본 개념·주의사항·확인 습관을 분명히 안내합니다. '
                '필요하면 전문가·공식 자료·현장 확인을 함께 권장하며, '
                '무료 정적 운영 원칙 아래에서도 신뢰할 수 있는 설명을 우선합니다.',
          ),
          const SizedBox(height: 8),
          Card(
            color: AppColors.surfaceMuted,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('콘텐츠 품질 체크리스트', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 10),
                  for (
                    var i = 0;
                    i < KnowledgeData.contentPrinciples.length;
                    i++
                  )
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        '${i + 1}. ${KnowledgeData.contentPrinciples[i]}',
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutBlock extends StatelessWidget {
  const _AboutBlock({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(body, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ),
    );
  }
}
