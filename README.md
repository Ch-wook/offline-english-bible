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
- 🔒 **저작권 안전** — 공개 도메인 데이터만 사용

---

## ✨ 주요 기능

| 기능 | 설명 | 상태 |
|------|------|------|
| 📖 **성경 읽기** | KJV + 개역한글 대역 보기, 단어 탭, 자동 스크롤 | ✅ |
| 📚 **사전** | Wiktionary(IPA, 품사, 정의) + WordNet(동의어/반의어) | ✅ |
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
| 동의어/반의어 | [WordNet 3.1](https://wordnet.princeton.edu/) | Princeton License |

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

### 성경 데이터 임포트

앱 최초 실행 시 `assets/data/kjv_sample.json` 의 샘플 데이터가 자동으로 임포트됩니다.

전체 KJV 데이터는 별도 임포트 스크립트를 사용합니다:

```bash
dart run scripts/import_kjv.dart <kjv.json> assets/data/
dart run scripts/import_korean_rv.dart <korean_rv.json> assets/data/
```

### 사전 데이터 임포트

```bash
# 1. Wiktionary 덤프 처리
# https://kaikki.org/dictionary/English/ 에서 다운로드
dart run scripts/import_wiktionary.dart kaikki.org-dictionary-English.jsonl

# 2. WordNet 동의어/반의어 병합
dart run scripts/import_wordnet.dart wordnet.json
```

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
