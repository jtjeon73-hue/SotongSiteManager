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
            subtitle: '소통사이트매니저가 지향하는 지식 안내의 철학과 원칙입니다.',
          ),
          _Block(
            title: '왜 이 플랫폼을 만들었는가',
            body:
                '세상의 중요한 지식은 이미 많지만, 처음 배우는 사람에게는 어렵고 '
                '실무자에게는 흩어져 있는 경우가 많습니다. '
                '소통사이트매니저는 소통회장이 만든 전문 지식 사이트를 하나로 연결해 '
                '관심에서 시작해 이해하고, 배우고, 실생활에 활용할 수 있도록 안내합니다.',
          ),
          _Block(
            title: '누구나 배울 수 있어야 한다는 방향',
            body:
                '초보자, 어르신, 학생, 실무자가 같은 허브에서 출발할 수 있어야 합니다. '
                '큰 글씨, 높은 대비, 단순한 탐색, 충분한 터치 영역은 배려가 아니라 기본 품질입니다.',
          ),
          _Block(
            title: '쉬운 설명이 얕은 설명을 의미하지 않는다',
            body:
                '쉬운 말로 시작하되, 필요할 때 원리·실무·심화로 이어집니다. '
                '기초부터 실무까지 끊기지 않는 구조를 지향합니다.',
          ),
          _Block(
            title: '생활과 일에 활용하도록 돕는 목표',
            body:
                '정보를 모으는 것이 목표가 아닙니다. '
                '방문자가 목적에 맞는 전문관을 발견하고, 왜 배우는지 이해한 뒤 '
                '생활과 실무에 적용할 수 있게 돕는 것이 원칙입니다.',
          ),
          _Block(
            title: '출처·정확성·안전성을 중요하게',
            body:
                '전기·금융·자동차·건강처럼 안전과 책임이 큰 분야는 '
                '단정적인 처방이나 과장된 약속을 피하고, '
                '기본 개념·주의사항·확인 습관을 분명히 안내합니다. '
                '광고나 자극적인 정보보다 신뢰할 수 있는 설명을 우선합니다.',
          ),
          _Block(
            title: '분야별 주의사항',
            body:
                '금융: 교육용 정보이며 개인별 투자·대출·세금 판단은 전문가 확인이 필요합니다.\n'
                '전기: 감전·화재 위험이 있는 작업은 자격 있는 전문가에게 의뢰하세요.\n'
                '자동차: 안전과 직결되는 정비는 전문 정비소 점검이 필요합니다.\n'
                'AI: 결과는 오류가 있을 수 있으므로 중요한 정보는 추가 확인하세요.\n'
                '영어: 학습 자료이며 상황과 문화권에 따라 표현이 달라질 수 있습니다.',
          ),
          _Block(
            title: '앞으로의 확장',
            body:
                '현재는 AI·전기·자동차·금융·영어 전문관을 연결합니다. '
                '건강, 프로그래밍, PLC, 스마트팜, 농업·귀촌, 지역·문화, 취미·노후처럼 '
                '삶의 중요한 분야를 지속적으로 확장합니다.',
          ),
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

class _Block extends StatelessWidget {
  const _Block({required this.title, required this.body});

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
