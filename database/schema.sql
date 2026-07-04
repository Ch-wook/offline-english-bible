-- database/schema.sql
-- Offline English Bible - SQLite 전체 스키마
-- 소스: KJV (공개 도메인) + 개역한글 (공개 도메인)
-- 사전: Wiktionary (CC-BY-SA) + WordNet (MIT) + Strong's (공개 도메인)

PRAGMA journal_mode=WAL;
PRAGMA foreign_keys=ON;
PRAGMA synchronous=NORMAL;
PRAGMA cache_size=-32000;
PRAGMA temp_store=MEMORY;

-- ════════════════════════════════════════════════════════
-- BIBLE DATA
-- ════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS bible_books (
    id                   INTEGER PRIMARY KEY,
    name                 TEXT NOT NULL,
    name_korean          TEXT NOT NULL,
    abbreviation         TEXT NOT NULL,
    abbreviation_korean  TEXT NOT NULL,
    testament            TEXT NOT NULL CHECK (testament IN ('OT', 'NT')),
    order_index          INTEGER NOT NULL UNIQUE,
    chapter_count        INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS bible_translations (
    code          TEXT PRIMARY KEY,
    name          TEXT NOT NULL,
    language      TEXT NOT NULL,
    copyright     TEXT NOT NULL,
    total_verses  INTEGER NOT NULL DEFAULT 0
);

-- 모든 번역본 절 텍스트 (KJV + 개역한글)
CREATE TABLE IF NOT EXISTS verse_translations (
    id               INTEGER PRIMARY KEY AUTOINCREMENT,
    translation_code TEXT NOT NULL REFERENCES bible_translations(code),
    book_id          INTEGER NOT NULL REFERENCES bible_books(id),
    chapter          INTEGER NOT NULL,
    verse            INTEGER NOT NULL,
    text             TEXT NOT NULL,
    strong_refs      TEXT,         -- JSON: ["H430","H3068"]
    UNIQUE (translation_code, book_id, chapter, verse)
);

CREATE TABLE IF NOT EXISTS cross_references (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    from_book_id  INTEGER NOT NULL,
    from_chapter  INTEGER NOT NULL,
    from_verse    INTEGER NOT NULL,
    to_book_id    INTEGER NOT NULL,
    to_chapter    INTEGER NOT NULL,
    to_verse      INTEGER NOT NULL,
    to_verse_end  INTEGER,
    rank          REAL NOT NULL DEFAULT 0.0
);

-- ════════════════════════════════════════════════════════
-- DICTIONARY — WIKTIONARY (단어 뜻, IPA, 품사, 활용형)
-- ════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS dictionary_entries (
    id               INTEGER PRIMARY KEY AUTOINCREMENT,
    word             TEXT NOT NULL,
    word_normalized  TEXT NOT NULL UNIQUE,   -- 인덱스 핵심
    ipa_us           TEXT NOT NULL DEFAULT '',
    ipa_uk           TEXT NOT NULL DEFAULT '',
    frequency_rank   INTEGER NOT NULL DEFAULT 999999,
    bible_frequency  INTEGER NOT NULL DEFAULT 0,
    etymology        TEXT NOT NULL DEFAULT ''
);

CREATE TABLE IF NOT EXISTS word_senses (
    id               INTEGER PRIMARY KEY AUTOINCREMENT,
    entry_id         INTEGER NOT NULL REFERENCES dictionary_entries(id),
    part_of_speech   TEXT NOT NULL,
    sense_order      INTEGER NOT NULL,
    definition       TEXT NOT NULL,
    bible_definition TEXT NOT NULL DEFAULT '',
    register         TEXT NOT NULL DEFAULT '',
    is_archaic       INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS word_examples (
    id               INTEGER PRIMARY KEY AUTOINCREMENT,
    sense_id         INTEGER NOT NULL REFERENCES word_senses(id),
    example_type     TEXT NOT NULL CHECK (example_type IN ('general', 'bible')),
    text             TEXT NOT NULL,
    source_reference TEXT NOT NULL DEFAULT '',
    book_id          INTEGER,
    chapter          INTEGER,
    verse            INTEGER
);

-- 활용형: plural, past_tense, past_participle, present_participle 등
CREATE TABLE IF NOT EXISTS word_forms (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    entry_id   INTEGER NOT NULL REFERENCES dictionary_entries(id),
    form_type  TEXT NOT NULL,
    form       TEXT NOT NULL
);

-- ════════════════════════════════════════════════════════
-- DICTIONARY — WORDNET (동의어, 반의어, 관련어)
-- ════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS wordnet_synsets (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    synset_id   TEXT NOT NULL UNIQUE,   -- '00001740-n'
    pos_code    TEXT NOT NULL,          -- 'n','v','a','r'
    definition  TEXT NOT NULL,
    examples    TEXT NOT NULL DEFAULT '[]'
);

CREATE TABLE IF NOT EXISTS wordnet_lemmas (
    id           INTEGER PRIMARY KEY AUTOINCREMENT,
    entry_id     INTEGER NOT NULL REFERENCES dictionary_entries(id),
    synset_id    INTEGER NOT NULL REFERENCES wordnet_synsets(id),
    lemma_order  INTEGER NOT NULL DEFAULT 0
);

-- relation_type: hypernym | hyponym | antonym | similar | also | holonym | meronym
CREATE TABLE IF NOT EXISTS wordnet_relations (
    id               INTEGER PRIMARY KEY AUTOINCREMENT,
    from_synset_id   INTEGER NOT NULL REFERENCES wordnet_synsets(id),
    to_synset_id     INTEGER NOT NULL REFERENCES wordnet_synsets(id),
    relation_type    TEXT NOT NULL
);

-- ════════════════════════════════════════════════════════
-- STRONG'S CONCORDANCE (히브리어/헬라어 원어)
-- ════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS strong_entries (
    id                INTEGER PRIMARY KEY AUTOINCREMENT,
    strong_number     TEXT NOT NULL UNIQUE,  -- 'H001', 'G001'
    testament         TEXT NOT NULL CHECK (testament IN ('OT', 'NT')),
    original_word     TEXT NOT NULL,
    transliteration   TEXT NOT NULL DEFAULT '',
    pronunciation     TEXT NOT NULL DEFAULT '',
    part_of_speech    TEXT NOT NULL DEFAULT '',
    short_definition  TEXT NOT NULL,
    full_definition   TEXT NOT NULL,
    derivation        TEXT NOT NULL DEFAULT '',
    kjv_frequency     INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS verse_strong_mappings (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    book_id       INTEGER NOT NULL,
    chapter       INTEGER NOT NULL,
    verse         INTEGER NOT NULL,
    word_position INTEGER NOT NULL,
    kjv_word      TEXT NOT NULL,
    strong_number TEXT NOT NULL  -- FK to strong_entries.strong_number
);

-- ════════════════════════════════════════════════════════
-- GRAMMAR ENGINE
-- ════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS grammar_rules (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    rule_type   TEXT NOT NULL,
    pattern     TEXT NOT NULL,
    label       TEXT NOT NULL,
    description TEXT NOT NULL DEFAULT '',
    priority    INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS pos_lookup (
    id               INTEGER PRIMARY KEY AUTOINCREMENT,
    word             TEXT NOT NULL,
    word_normalized  TEXT NOT NULL UNIQUE,
    primary_pos      TEXT NOT NULL,
    all_pos          TEXT NOT NULL DEFAULT '[]'
);

-- ════════════════════════════════════════════════════════
-- INDEXES (조회 성능 최적화)
-- ════════════════════════════════════════════════════════

-- 핵심: Bible Reader 장 조회 (200ms 목표)
CREATE INDEX IF NOT EXISTS idx_verse_chapter_lookup
    ON verse_translations (translation_code, book_id, chapter);

-- 단어 조회 (Bottom Sheet 200ms 목표)
CREATE INDEX IF NOT EXISTS idx_dict_word_normalized
    ON dictionary_entries (word_normalized);

-- Strong 번호 조회
CREATE INDEX IF NOT EXISTS idx_strong_number
    ON strong_entries (strong_number);

-- 문법 분석
CREATE INDEX IF NOT EXISTS idx_pos_word
    ON pos_lookup (word_normalized);

-- 원어 매핑
CREATE INDEX IF NOT EXISTS idx_strong_mapping_verse
    ON verse_strong_mappings (book_id, chapter, verse);

-- WordNet
CREATE INDEX IF NOT EXISTS idx_wordnet_lemma_entry
    ON wordnet_lemmas (entry_id);

CREATE INDEX IF NOT EXISTS idx_wordnet_relations_from
    ON wordnet_relations (from_synset_id, relation_type);

-- ════════════════════════════════════════════════════════
-- FTS5 전문 검색 (성경 구절 검색)
-- ════════════════════════════════════════════════════════

CREATE VIRTUAL TABLE IF NOT EXISTS verses_fts USING fts5(
    text,
    content=verse_translations,
    content_rowid=id,
    tokenize="unicode61"
);

CREATE TRIGGER IF NOT EXISTS verse_ai AFTER INSERT ON verse_translations BEGIN
    INSERT INTO verses_fts(rowid, text) VALUES (new.id, new.text);
END;

CREATE TRIGGER IF NOT EXISTS verse_ad AFTER DELETE ON verse_translations BEGIN
    INSERT INTO verses_fts(verses_fts, rowid, text)
    VALUES('delete', old.id, old.text);
END;

-- ════════════════════════════════════════════════════════
-- DEFAULT DATA
-- ════════════════════════════════════════════════════════

INSERT OR IGNORE INTO bible_translations (code, name, language, copyright)
VALUES
    ('KJV',       'King James Version',  'en', 'Public Domain'),
    ('KOREAN_RV', '개역한글',             'ko', 'Public Domain');
