# Firebase Hosting 참고

실제 운영 설정은 저장소 루트의 다음 파일을 기준으로 합니다.

| 파일 | 역할 |
| --- | --- |
| `.firebaserc` | Firebase Project ID를 `sotongsitemanager`로 고정 |
| `firebase.json` | Hosting public=`build/web`, SPA rewrite, 캐시 헤더 |

## 확정된 프로젝트

- 이름: **SotongSiteManager**
- Project ID: **sotongsitemanager**
- 번호: **300481711308**
- 운영 주소: https://sotongsitemanager.web.app
- 요금제: Spark 무료 (결제 계정 미연결)

## 배포 명령

```bash
firebase use
# 출력이 sotongsitemanager 인지 확인

flutter build web --release
firebase deploy --only hosting --project sotongsitemanager
```

## 주의

- Hosting만 사용합니다.
- Firestore / Functions / Storage / Authentication을 이 설정으로 추가하지 않습니다.
- 다른 소통웨어 Firebase 프로젝트 설정을 복사해 연결하지 않습니다.
- Blaze 전환·결제 연결을 하지 않습니다.

자세한 운영 설명은 `README.md`의 “Firebase Hosting 운영 정보”를 보세요.
