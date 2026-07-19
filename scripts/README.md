# 성경 데이터 임포트 가이드

## 개요

`assets/data/` 에 번들된 JSON 파일이 앱 최초 실행 시 SQLite 로 자동 임포트됩니다.
현재 포함된 파일은 **샘플 데이터** 입니다. 전체 데이터를 위해 아래 절차를 따르세요.

---

## 1. KJV (King James Version) — 영어 성경

### 라이선스
**공개 도메인 (Public Domain)** — 1611년 출판, 저작권 만료

### 데이터 다운로드
다음 소스 중 하나를 사용하세요:

```bash
# 옵션 A: scrollmapper/bible_databases (권장)
# https://github.com/scrollmapper/bible_databases/raw/master/json/kjv.json
# 포맷: [{"b":1,"c":1,"v":1,"t":"In the beginning..."}]

# 옵션 B: aruljohn/Bible-kjv (책별 JSON)
# https://github.com/aruljohn/Bible-kjv
```

### 임포트 실행
```bash
# 다운로드
curl -L https://raw.githubusercontent.com/scrollmapper/bible_databases/master/json/kjv.json \
     -o /tmp/kjv.json

# 정규화 + 앱 assets 에 복사
dart run scripts/import_kjv.dart /tmp/kjv.json

# 결과물: frontend/assets/data/kjv_full.json
```

### BibleImportService 경로 업데이트
```dart
// lib/core/services/bible_import_service.dart
static const _kjvAssetPath = 'assets/data/kjv_full.json'; // 이미 설정됨
```

---

## 2. 개역한글 — 한국어 성경

### 라이선스
개역한글은 **공개 도메인** 입니다 (1961년 이전 저작물).
개역개정(NIrV)은 저작권이 있으므로 사용 불가.

### 데이터 다운로드
```bash
# MongooseOrion/kor-bible (개역한글)
# https://github.com/MongooseOrion/kor-bible

# 또는 luwrain/bible (SWORD 포맷 파생)
# https://github.com/luwrain/bible/tree/master/translations
```

### 임포트 실행
```bash
dart run scripts/import_korean_rv.dart /tmp/korean_rv.json

# 결과물: frontend/assets/data/korean_rv_full.json
```

---

## 3. pubspec.yaml 확인

`assets/data/` 가 포함되어 있는지 확인:

```yaml
flutter:
  assets:
    - assets/data/
    - assets/databases/
```

---

## 4. 앱 실행

```bash
cd frontend
flutter pub get
dart run build_runner build
flutter run
```

앱 최초 실행 시 임포트 진행 화면이 표시되고, 완료 후 자동으로 성경 읽기 화면으로 이동합니다.

---

## 전체 데이터 크기 참고

| 파일 | 크기 | 절 수 |
|------|------|--------|
| kjv_full.json | ~4 MB | 31,102 |
| korean_rv_full.json | ~3.5 MB | 31,102 |

---

## 샘플 데이터 (현재 포함)

| 파일 | 내용 |
|------|------|
| kjv_sample.json | Genesis 1-3, Psalm 23, John 1 & 3:16, Romans 8 |
| korean_rv_sample.json | 동일 본문 (개역한글) |

샘플 데이터로도 앱의 핵심 기능(성경 읽기, 단어 클릭, 대역 보기)을 테스트할 수 있습니다.
