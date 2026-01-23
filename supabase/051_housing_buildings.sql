-- ============================================
-- 051: Модуль "Проживание" - Здания
-- ============================================

-- ============================================
-- 1. ТИПЫ ЗДАНИЙ
-- ============================================
CREATE TABLE IF NOT EXISTS building_types (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    slug TEXT UNIQUE NOT NULL,
    name_ru TEXT NOT NULL,
    name_en TEXT,
    name_hi TEXT,
    color TEXT DEFAULT '#6366f1',
    sort_order INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE building_types ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Allow all building_types" ON building_types;
CREATE POLICY "Allow all building_types" ON building_types FOR ALL USING (true) WITH CHECK (true);

-- Начальные типы зданий
INSERT INTO building_types (slug, name_ru, name_en, name_hi, color, sort_order) VALUES
    ('guesthouse', 'Гостевой дом', 'Guest House', 'अतिथि गृह', '#8b5cf6', 1),
    ('team_house', 'Дом команды', 'Team House', 'टीम का घर', '#10b981', 2)
ON CONFLICT (slug) DO UPDATE SET
    name_ru = EXCLUDED.name_ru,
    name_en = EXCLUDED.name_en,
    name_hi = EXCLUDED.name_hi,
    color = EXCLUDED.color,
    sort_order = EXCLUDED.sort_order;

-- ============================================
-- 2. ЗДАНИЯ
-- ============================================
CREATE TABLE IF NOT EXISTS buildings (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    building_type_id UUID REFERENCES building_types(id) ON DELETE SET NULL,
    name_ru TEXT NOT NULL,
    name_en TEXT,
    name_hi TEXT,
    floors INTEGER DEFAULT 1,
    description_ru TEXT,
    description_en TEXT,
    description_hi TEXT,
    photo_url TEXT,
    address TEXT,
    is_active BOOLEAN DEFAULT true,
    sort_order INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE buildings ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Allow all buildings" ON buildings;
CREATE POLICY "Allow all buildings" ON buildings FOR ALL USING (true) WITH CHECK (true);

CREATE INDEX IF NOT EXISTS idx_buildings_type ON buildings(building_type_id);
CREATE INDEX IF NOT EXISTS idx_buildings_active ON buildings(is_active);

-- Триггер для updated_at
DROP TRIGGER IF EXISTS update_buildings_updated_at ON buildings;
CREATE TRIGGER update_buildings_updated_at BEFORE UPDATE ON buildings
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ============================================
-- 3. ТЕСТОВЫЕ ДАННЫЕ
-- ============================================
DO $$
DECLARE
    guesthouse_type_id UUID;
    team_house_type_id UUID;
BEGIN
    SELECT id INTO guesthouse_type_id FROM building_types WHERE slug = 'guesthouse' LIMIT 1;
    SELECT id INTO team_house_type_id FROM building_types WHERE slug = 'team_house' LIMIT 1;

    -- Гостевой дом
    INSERT INTO buildings (building_type_id, name_ru, name_en, name_hi, floors, description_ru, sort_order)
    VALUES (guesthouse_type_id, 'Гостевой дом "Говардхан"', 'Govardhan Guest House', 'गोवर्धन अतिथि गृह', 3, 'Основной гостевой дом для паломников', 1)
    ON CONFLICT DO NOTHING;

    -- Дом команды 1
    INSERT INTO buildings (building_type_id, name_ru, name_en, name_hi, floors, description_ru, sort_order)
    VALUES (team_house_type_id, 'Дом севартхов', 'Sevarthi House', 'सेवार्थी गृह', 2, 'Жильё для постоянных севартхов', 2)
    ON CONFLICT DO NOTHING;

    -- Дом команды 2
    INSERT INTO buildings (building_type_id, name_ru, name_en, name_hi, floors, description_ru, sort_order)
    VALUES (team_house_type_id, 'Дом брахмачари', 'Brahmachari House', 'ब्रह्मचारी गृह', 2, 'Жильё для брахмачари', 3)
    ON CONFLICT DO NOTHING;
END $$;
