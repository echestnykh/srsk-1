-- ============================================
-- 058: Переводы для статистики на странице зданий
-- ============================================

INSERT INTO translations (key, ru, en, hi, page) VALUES
    ('tomorrow', 'Завтра', 'Tomorrow', 'कल', 'buildings')
ON CONFLICT (key) DO UPDATE SET
    ru = EXCLUDED.ru,
    en = EXCLUDED.en,
    hi = EXCLUDED.hi,
    page = EXCLUDED.page;
