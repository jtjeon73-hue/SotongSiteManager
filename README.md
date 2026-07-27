# 소통사이트매니저 (SotongSiteManager)

세상의 중요한 지식을 **쉽고 깊이 있게** 연결하는 소통웨어 통합 지식 플랫폼입니다.

표시 이름: **소통사이트매니저**  
영문 보조 이름: **Sotong Knowledge Manager**

> 관심에서 시작해 이해하고, 배우고, 실생활에 활용하는 소통 지식 플랫폼

---

## 핵심 비전

소통사이트매니저는 단순 링크 모음이 아닙니다.

소통회장이 만든 여러 전문 지식 사이트를 하나의 허브로 연결하고,  
초보자·어르신·학생·실무자가 중요한 지식을 쉽게 시작하면서도  
필요할 때 실무·전문 수준까지 깊이 들어갈 수 있도록 안내합니다.

목표 인상:

- “중요한 지식을 이렇게 쉽고 체계적으로 설명한 곳이 있었구나.”
- “처음 배우는 사람부터 실무자까지 계속 찾아볼 수 있겠다.”
- “이 사이트를 다른 사람에게 자신 있게 소개하고 싶다.”

---

## 현재 연결 사이트

| 사이트 | 주소 | 상태 |
| --- | --- | --- |
| 소통AI스토리 | https://sotongware-ai-story.web.app | 운영 중 |
| 소통전기 | https://sotong-elec.web.app | 운영 중 |
| 소통카 | https://sotong-car.web.app | 운영 중 |
| 소통금융 | https://sotong-finance.web.app | 운영 중 |
| 소통영어 | https://sotong-language.web.app | 운영 중 |

---

## 주요 화면

1. **홈** — 브랜드 메시지, 검색 진입, 운영 사이트, 추천 지식, 분야 탐색, 시작점, 운영 철학
2. **전체 사이트** — 전문 분야 카드와 사이트 방문
3. **분야별 지식** — 확장 가능한 분류와 준비 중 안내
4. **학습 길잡이** — 목적별 추천 사이트와 학습 순서
5. **통합 검색** — 로컬 메타데이터 검색 (외부 유료 API 없음)
6. **소개** — 목적, 원칙, 확장 계획, 안전·정확성 운영 기준

---

## 기술 구조

- Flutter Web (Material 3)
- `go_router` — URL 직접 접근·새로고침 대응
- `url_launcher` — 외부 사이트 새 탭 열기
- `google_fonts` / Noto Sans KR — 한글 가독성
- 로컬 정적 데이터 (`lib/data/knowledge_data.dart`)
- 무료 Firebase Hosting 배포를 전제로 한 정적 웹 빌드

```
lib/
  main.dart
  app.dart
  theme/
  models/
  data/
  screens/
  widgets/
  services/
  utils/
```

---

## 실행 방법

```bash
flutter pub get
flutter run -d chrome
```

특정 포트:

```bash
flutter run -d chrome --web-port=8080
```

---

## 검사 방법

```bash
dart format .
flutter analyze --fatal-infos
flutter test
```

가능하면 Playwright(선택):

```bash
# 릴리스 빌드 후 정적 서버로 확인
flutter build web --release
# 로컬 서버 예: python -m http.server 4173 --directory build/web
```

---

## 빌드 방법

```bash
flutter build web --release
```

산출물: `build/web/`

---

## 새로운 지식 사이트 추가 방법

1. `lib/models/`의 모델 필드를 확인합니다. (`KnowledgeSite` 등)
2. `lib/data/knowledge_data.dart`의 `sites` 목록에 항목을 **한 곳만** 추가합니다.
3. 필요하면:
   - 새 분야 → `categories`에 추가
   - 홈 추천 → `featuredKnowledge`에 추가
   - 목적 추천 → `learningGoals`의 `siteIds`에 id 연결
4. `flutter test`로 검색·사이트 목록 반영을 확인합니다.
5. `flutter build web --release` 후 Hosting에 배포합니다.

최소 예시:

```dart
KnowledgeSite(
  id: 'health',
  name: '소통건강',
  shortName: '건강',
  description: '생활 건강 지식을 쉽게 안내',
  detailedDescription: '...',
  categoryId: 'health-life',
  icon: Icons.favorite_outline,
  color: Color(0xFFB42318),
  url: 'https://your-site.web.app',
  status: SiteStatus.live,
  targetUsers: ['입문자', '어르신'],
  difficulty: DifficultyLevel.beginner,
  topics: ['수면', '운동'],
  keywords: ['건강', '생활'],
  recommendedPath: ['왜 알아야 하는가', '핵심 개념', '생활 사례'],
  featured: true,
  sortOrder: 6,
),
```

추가만으로 **홈 / 전체 사이트 / 검색 / 분야별 지식 / 학습 길잡이**에 반영되도록 설계되어 있습니다.

---

## 무료 운영 원칙

1단계에서는 다음을 사용하지 않습니다.

- 로그인/회원가입/결제/광고
- 개인정보 수집
- Firestore 쓰기, Functions
- 외부 생성형 AI / 유료 검색 API

정적 웹 + 무료 Firebase Hosting으로 운영 가능한 구조를 유지합니다.

권장 Firebase Project ID 후보: `sotong-site-manager`  
(아직 프로젝트가 없다면 생성·배포는 별도 확인 후 진행)

---

## 향후 발전 계획 (2단계+)

- 건강, 프로그래밍, PLC, 스마트팜, 농업·귀촌 등 전문 사이트 연결
- 사이트별 학습 경로 미리보기 고도화
- 접근성·키보드 탐색 강화
- 오프라인 캐시/PWA 보강
- (필요 시) 무료 범위 안의 경량 분석

---

## 라이선스 / 소유

SotongSiteManager — 소통웨어 통합 지식 플랫폼
