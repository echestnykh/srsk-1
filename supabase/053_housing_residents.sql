-- ============================================
-- 053: Модуль "Проживание" - Проживающие
-- ============================================

-- ============================================
-- 1. КАТЕГОРИИ ПРОЖИВАЮЩИХ
-- ============================================
CREATE TABLE IF NOT EXISTS resident_categories (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    slug TEXT UNIQUE NOT NULL,
    name_ru TEXT NOT NULL,
    name_en TEXT,
    name_hi TEXT,
    color TEXT DEFAULT '#6366f1',
    sort_order INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE resident_categories ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Allow all resident_categories" ON resident_categories;
CREATE POLICY "Allow all resident_categories" ON resident_categories FOR ALL USING (true) WITH CHECK (true);

-- Начальные категории
INSERT INTO resident_categories (slug, name_ru, name_en, name_hi, color, sort_order) VALUES
    ('team', 'Команда', 'Team', 'टीम', '#10b981', 1),
    ('guest', 'Гость', 'Guest', 'अतिथि', '#3b82f6', 2),
    ('retreat', 'Участник ретрита', 'Retreat participant', 'रिट्रीट प्रतिभागी', '#8b5cf6', 3),
    ('volunteer', 'Волонтёр', 'Volunteer', 'स्वयंसेवक', '#f59e0b', 4)
ON CONFLICT (slug) DO UPDATE SET
    name_ru = EXCLUDED.name_ru,
    name_en = EXCLUDED.name_en,
    name_hi = EXCLUDED.name_hi,
    color = EXCLUDED.color,
    sort_order = EXCLUDED.sort_order;

-- ============================================
-- 2. ПРОЖИВАЮЩИЕ (ЗАСЕЛЕНИЯ)
-- ============================================
CREATE TABLE IF NOT EXISTS residents (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    room_id UUID NOT NULL REFERENCES rooms(id) ON DELETE CASCADE,
    category_id UUID REFERENCES resident_categories(id) ON DELETE SET NULL,

    -- Связь с членом команды (если это команда)
    team_member_id UUID REFERENCES team_members(id) ON DELETE SET NULL,

    -- Связь с ретритом (если участник ретрита)
    retreat_id UUID REFERENCES retreats(id) ON DELETE SET NULL,

    -- Данные гостя (если не team_member)
    guest_name TEXT,
    guest_phone TEXT,
    guest_email TEXT,
    guest_country TEXT,
    guest_passport TEXT,
    guest_notes TEXT,

    -- Даты проживания
    check_in DATE NOT NULL,
    check_out DATE,

    -- Статус
    status TEXT DEFAULT 'active', -- 'active', 'checked_out', 'cancelled'

    -- Примечания
    notes TEXT,

    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE residents ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Allow all residents" ON residents;
CREATE POLICY "Allow all residents" ON residents FOR ALL USING (true) WITH CHECK (true);

CREATE INDEX IF NOT EXISTS idx_residents_room ON residents(room_id);
CREATE INDEX IF NOT EXISTS idx_residents_category ON residents(category_id);
CREATE INDEX IF NOT EXISTS idx_residents_team_member ON residents(team_member_id);
CREATE INDEX IF NOT EXISTS idx_residents_retreat ON residents(retreat_id);
CREATE INDEX IF NOT EXISTS idx_residents_dates ON residents(check_in, check_out);
CREATE INDEX IF NOT EXISTS idx_residents_status ON residents(status);

-- Триггер для updated_at
DROP TRIGGER IF EXISTS update_residents_updated_at ON residents;
CREATE TRIGGER update_residents_updated_at BEFORE UPDATE ON residents
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ============================================
-- 3. ПРОВЕРКА: либо team_member_id, либо guest_name
-- ============================================
ALTER TABLE residents DROP CONSTRAINT IF EXISTS residents_has_person;
ALTER TABLE residents ADD CONSTRAINT residents_has_person CHECK (
    team_member_id IS NOT NULL OR guest_name IS NOT NULL
);

-- ============================================
-- 4. ТЕСТОВЫЕ ДАННЫЕ
-- ============================================
DO $$
DECLARE
    room_101_id UUID;
    room_201_id UUID;
    sevarthi_room_1_id UUID;
    team_category_id UUID;
    guest_category_id UUID;
    member_id UUID;
BEGIN
    -- Получаем ID комнат
    SELECT r.id INTO room_101_id
    FROM rooms r
    JOIN buildings b ON r.building_id = b.id
    WHERE b.name_ru LIKE '%Говардхан%' AND r.number = '101'
    LIMIT 1;

    SELECT r.id INTO room_201_id
    FROM rooms r
    JOIN buildings b ON r.building_id = b.id
    WHERE b.name_ru LIKE '%Говардхан%' AND r.number = '201'
    LIMIT 1;

    SELECT r.id INTO sevarthi_room_1_id
    FROM rooms r
    JOIN buildings b ON r.building_id = b.id
    WHERE b.name_ru LIKE '%севартхов%' AND r.number = '1'
    LIMIT 1;

    -- Получаем ID категорий
    SELECT id INTO team_category_id FROM resident_categories WHERE slug = 'team' LIMIT 1;
    SELECT id INTO guest_category_id FROM resident_categories WHERE slug = 'guest' LIMIT 1;

    -- Получаем ID члена команды
    SELECT id INTO member_id FROM team_members LIMIT 1;

    -- Заселение члена команды (если есть комната и член команды)
    IF sevarthi_room_1_id IS NOT NULL AND member_id IS NOT NULL AND team_category_id IS NOT NULL THEN
        INSERT INTO residents (room_id, category_id, team_member_id, check_in, check_out, status)
        VALUES (sevarthi_room_1_id, team_category_id, member_id, '2025-01-01', '2025-03-31', 'active')
        ON CONFLICT DO NOTHING;
    END IF;

    -- Заселение гостя (если есть комната)
    IF room_101_id IS NOT NULL AND guest_category_id IS NOT NULL THEN
        INSERT INTO residents (room_id, category_id, guest_name, guest_phone, guest_country, check_in, check_out, status)
        VALUES (room_101_id, guest_category_id, 'Иван Петров', '+7 999 123-45-67', 'Россия', CURRENT_DATE, CURRENT_DATE + 7, 'active')
        ON CONFLICT DO NOTHING;
    END IF;

    -- Ещё один гость
    IF room_201_id IS NOT NULL AND guest_category_id IS NOT NULL THEN
        INSERT INTO residents (room_id, category_id, guest_name, guest_phone, guest_country, check_in, check_out, status)
        VALUES (room_201_id, guest_category_id, 'John Smith', '+1 555 123-4567', 'USA', CURRENT_DATE - 2, CURRENT_DATE + 5, 'active')
        ON CONFLICT DO NOTHING;
    END IF;
END $$;
