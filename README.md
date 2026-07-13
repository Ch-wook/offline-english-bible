# Offline English Bible 📖

> **오프라인 영어 성경 학습 플랫폼** — AI 없이 완전 오프라인으로 동작하는 성경 기반 영어 학습 앱

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)
[![CI](https://github.com/Ch-wook/offline-english-bible/actions/workflows/ci.yml/badge.svg)](https://github.com/Ch-wook/offline-english-bible/actions)

---

## 📋 프로젝트 개요

단순한 성경 앱이 아닌, **오프라인 영어 성경 학습 플랫폼**입니다.

- 🌐 **완전 오프라인** — 인터넷 없이 모든 핵심 기능 동작
- 🤖 **AI-Free** — OpenAI/Gemini/Claude API 미사용
- 📱 **Android + iOS** 지원
- 🔒 **라이선스 준수** — 공개 도메인 및 오픈 라이선스 데이터의 출처와 조건 명시

---

## ✨ 주요 기능

| 기능 | 설명 | 상태 |
|------|------|------|
| 📖 **성경 읽기** | KJV + 개역한글 대역 보기, 여러 읽기 탭, 빠른 글자 설정, 자동 스크롤 | ✅ |
| 📚 **앱 내부 사전** | 단어를 누르면 한국어 뜻, IPA, 품사, 예문, 유의어와 발음 재생을 앱 안에서 표시 | ✅ |
| 🔤 **단어장** | SM-2 SRS 알고리즘 기반 간격 반복 복습 | ✅ |
| 🔍 **전문 검색** | FTS5 기반 성경 전체 검색 (< 200ms) | ✅ |
| 🖊️ **형광펜/북마크** | 6가지 색상 형광펜, 절 북마크 | ✅ |
| 🧠 **문법 분석** | 오프라인 POS 태거 (KJV 고어 지원) | ✅ |
| ⚙️ **설정** | 글자 크기, 줄 간격, 테마, 번역본 | ✅ |

---

## 🏗️ 아키텍처

```
Clean Architecture + MVVM + Feature-First
```

```
frontend/lib/
├── core/
│   ├── database/          # Drift SQLite (WAL 모드, FTS5)
│   ├── di/                # 의존성 주입 (Riverpod)
│   ├── error/             # Failure 타입 계층
│   ├── services/          # 초기화, 임포트 서비스
│   └── utils/             # Result<T,F> 모나드
├── features/
│   ├── bible/             # 성경 읽기 (Domain/Data/Presentation)
│   ├── dictionary/        # Wiktionary + WordNet 사전
│   ├── vocabulary/        # 단어장 + SRS 복습
│   ├── search/            # FTS5 전문 검색
│   ├── highlights/        # 형광펜 + 북마크
│   ├── grammar/           # 오프라인 POS 태거
│   └── settings/          # 앱 설정
├── routes/                # GoRouter
├── shared/                # 공용 위젯
└── theme/                 # Material 3 테마
```

### 기술 스택

| 레이어 | 기술 |
|--------|------|
| **UI** | Flutter + Material Design 3 |
| **상태 관리** | Riverpod (StateNotifier, FutureProvider, family) |
| **라우팅** | GoRouter (StatefulShellRoute) |
| **로컬 DB** | Drift (SQLite, WAL, FTS5) |
| **설정 저장** | Hive |
| **아키텍처** | Clean Architecture + MVVM |

---

## 📖 데이터 소스 (저작권)

| 데이터 | 출처 | 라이선스 |
|--------|------|----------|
| KJV 성경 | King James Version (1611) | **공개 도메인** |
| 개역한글 성경 | 한국 성경공회 (1961) | **공개 도메인** |
| 단어 정의 | [Wiktionary](https://kaikki.org/dictionary/English/) | CC BY-SA 4.0 |
| 영문 정의·동의어·반의어 | [WordNet 3.0](https://wordnet.princeton.edu/) | Princeton WordNet License |
| 발음 표기 | [CMU Pronouncing Dictionary](http://www.speech.cs.cmu.edu/cgi-bin/cmudict) | CMUdict License |
| 영한 뜻 보강 | [quick_english-korean StarDict](https://stardict.uber.space/ko/index.html) | GNU GPL |

앱 코드는 MIT 라이선스이며, 번들 데이터에는 각 데이터 소스의 라이선스가 별도로 적용됩니다.

---

## 🚀 시작하기

### 요구사항

- Flutter 3.x
- Dart 3.x
- Android SDK / Xcode

### 설치

```bash
git clone https://github.com/Ch-wook/offline-english-bible.git
cd offline-english-bible/frontend

# 의존성 설치
flutter pub get

# Drift 코드 생성
flutter pub run build_runner build --delete-conflicting-outputs

# 실행
flutter run
```

### 오프라인 데이터

앱에는 KJV 31,102절, 개역한글 전체 본문과 KJV에서 탭할 수 있는 모든 단어를 처리하는 사전 데이터가 함께 들어 있습니다. 최초 실행 시 이 자산을 로컬 SQLite 데이터베이스로 가져오며 이후 사전 조회를 포함한 핵심 기능은 네트워크 없이 동작합니다.

원본 성경 데이터를 다시 생성하려면 다음 스크립트를 사용합니다:

```bash
dart run scripts/import_kjv.dart <kjv.json> assets/data/
dart run scripts/import_korean_rv.dart <korean_rv.json> assets/data/
```

### 사전 데이터 생성

```bash
dart run scripts/build_offline_dictionary.dart \
  frontend/assets/data/kjv_full.json \
  <kaikki-korean-extract.jsonl.gz> \
  <wordnet-dict-directory> \
  <cmudict-file> \
  frontend/assets/data/dictionary_full.json \
  frontend/lib/core/data/bible_word_korean_dict.dart \
  <quick-english-korean-stardict-directory>
```

생성 데이터의 출처와 라이선스 전문은 [`THIRD_PARTY_DATA.md`](THIRD_PARTY_DATA.md)를 확인하세요.

### Android APK 설치

`main` 브랜치에 푸시하면 GitHub Actions가 테스트와 릴리스 서명 빌드를 수행하고 APK를 [GitHub Releases](https://github.com/Ch-wook/offline-english-bible/releases/latest)에 자동 업로드합니다.

---

## 🧪 테스트

```bash
# 전체 테스트 실행
flutter test

# 커버리지 포함
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

### 테스트 구조

```
test/
├── features/
│   ├── bible/
│   │   ├── domain/usecases/     # GetAllBooksUseCase, GetChapterUseCase
│   │   └── data/repositories/   # BibleRepositoryImpl
│   ├── dictionary/
│   │   └── domain/usecases/     # LookupWordUseCase
│   ├── vocabulary/
│   │   └── domain/entities/     # VocabItem SM-2 알고리즘
│   ├── grammar/
│   │   └── data/services/       # OfflinePosTagger
│   └── bible/
│       └── presentation/        # BibleReaderProvider
└── helpers/
    └── provider_container_helper.dart
```

---

## 📁 스크립트

| 스크립트 | 설명 |
|----------|------|
| `scripts/import_kjv.dart` | KJV JSON → SQLite |
| `scripts/import_korean_rv.dart` | 개역한글 JSON → SQLite |
| `scripts/import_wiktionary.dart` | Wiktionary JSONL → 사전 JSON |
| `scripts/import_wordnet.dart` | WordNet → 동의어/반의어 병합 |
| `scripts/build_offline_dictionary.dart` | Wiktionary + WordNet + CMUdict + KJV를 통합한 전체 오프라인 사전 생성 |

---

## 🔧 개발 원칙

- **Offline First** — 인터넷 없이 동작
- **Clean Architecture** — Domain/Data/Presentation 레이어 분리
- **SOLID** — 인터페이스 기반 의존성 역전
- **Repository Pattern** — 데이터 소스 추상화
- **Test Driven** — 모든 Use Case 테스트 작성
- **No AI API** — AI API 미사용

---

## 📄 라이선스

이 프로젝트는 MIT 라이선스를 따릅니다. 자세한 내용은 [LICENSE](LICENSE) 파일을 참조하세요.

성경 데이터 및 사전 데이터는 각 원본 라이선스를 따릅니다 (위 표 참조).
