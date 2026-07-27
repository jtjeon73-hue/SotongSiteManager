import '../models/home_site_group.dart';

abstract final class HomeGroupsData {
  static const List<HomeSiteGroup> groups = [
    HomeSiteGroup(
      id: 'life',
      title: '생활과 자기계발',
      subtitle: '건강·자동차·금융·영어로 일상 판단을 돕습니다.',
      siteIds: ['health', 'car', 'finance', 'english'],
    ),
    HomeSiteGroup(
      id: 'tech',
      title: '기술과 실무',
      subtitle: '전기·PLC·개발·스마트팜으로 현장과 학습을 연결합니다.',
      siteIds: ['elec', 'plc', 'development', 'smart-farm'],
    ),
    HomeSiteGroup(
      id: 'future',
      title: 'AI와 미래·지역',
      subtitle: 'AI 이해와 농촌·지역발전 아이디어를 함께 봅니다.',
      siteIds: ['ai-story', 'country-ai'],
    ),
  ];
}
