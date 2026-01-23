-- ============================================
-- 052: Модуль "Проживание" - Комнаты
-- ============================================

-- ============================================
-- 1. ТИПЫ КОМНАТ
-- ============================================
CREATE TABLE IF NOT EXISTS room_types (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    slug TEXT UNIQUE NOT NULL,
    name_ru TEXT NOT NULL,
    name_en TEXT,
    name_hi TEXT,
    default_capacity INTEGER DEFAULT 1,
    color TEXT DEFAULT '#6366f1',
    sort_order INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE room_types ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Allow all room_types" ON room_types;
CREATE POLICY "Allow all room_types" ON room_types FOR ALL USING (true) WITH CHECK (true);

-- Начальные типы комнат
INSERT INTO room_types (slug, name_ru, name_en, name_hi, default_capacity, color, sort_order) VALUES
    ('single', 'Одноместная', 'Single', 'सिंगल', 1, '#3b82f6', 1),
    ('double', 'Двухместная', 'Double', 'डबल', 2, '#10b981', 2),
    ('triple', 'Трёхместная', 'Triple', 'ट्रिपल', 3, '#f59e0b', 3),
    ('quad', 'Четырёхместная', 'Quad', 'क्वाड', 4, '#ef4444', 4),
    ('dorm', 'Общая', 'Dormitory', 'डॉर्मिटरी', 8, '#8b5cf6', 5)
ON CONFLICT (slug) DO UPDATE SET
    name_ru = EXCLUDED.name_ru,
    name_en = EXCLUDED.name_en,
    name_hi = EXCLUDED.name_hi,
    default_capacity = EXCLUDED.default_capacity,
    color = EXCLUDED.color,
    sort_order = EXCLUDED.sort_order;

-- ============================================
-- 2. КОМНАТЫ
-- ============================================
CREATE TABLE IF NOT EXISTS rooms (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    building_id UUID NOT NULL REFERENCES buildings(id) ON DELETE CASCADE,
    room_type_id UUID REFERENCES room_types(id) ON DELETE SET NULL,
    number TEXT NOT NULL,
    floor INTEGER DEFAULT 1,
    capacity INTEGER DEFAULT 1,
    has_bathroom BOOLEAN DEFAULT false,
    has_ac BOOLEAN DEFAULT false,
    has_kitchen BOOLEAN DEFAULT false,
    has_wifi BOOLEAN DEFAULT true,
    description_ru TEXT,
    description_en TEXT,
    description_hi TEXT,
    is_active BOOLEAN DEFAULT true,
    sort_order INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(building_id, number)
);

ALTER TABLE rooms ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Allow all rooms" ON rooms;
CREATE POLICY "Allow all rooms" ON rooms FOR ALL USING (true) WITH CHECK (true);

CREATE INDEX IF NOT EXISTS idx_rooms_building ON rooms(building_id);
CREATE INDEX IF NOT EXISTS idx_rooms_type ON rooms(room_type_id);
CREATE INDEX IF NOT EXISTS idx_rooms_floor ON rooms(floor);
CREATE INDEX IF NOT EXISTS idx_rooms_active ON rooms(is_active);

-- Триггер для updated_at
DROP TRIGGER IF EXISTS update_rooms_updated_at ON rooms;
CREATE TRIGGER update_rooms_updated_at BEFORE UPDATE ON rooms
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ============================================
-- 3. ТЕСТОВЫЕ ДАННЫЕ
-- ============================================
DO $$
DECLARE
    govardhan_id UUID;
    sevarthi_id UUID;
    single_type_id UUID;
    double_type_id UUID;
    triple_type_id UUID;
BEGIN
    SELECT id INTO govardhan_id FROM buildings WHERE name_ru LIKE '%Говардхан%' LIMIT 1;
    SELECT id INTO sevarthi_id FROM buildings WHERE name_ru LIKE '%севартхов%' LIMIT 1;
    SELECT id INTO single_type_id FROM room_types WHERE slug = 'single' LIMIT 1;
    SELECT id INTO double_type_id FROM room_types WHERE slug = 'double' LIMIT 1;
    SELECT id INTO triple_type_id FROM room_types WHERE slug = 'triple' LIMIT 1;

    -- Комнаты в гостевом доме (если здание существует)
    IF govardhan_id IS NOT NULL THEN
        INSERT INTO rooms (building_id, room_type_id, number, floor, capacity, has_bathroom, has_ac, sort_order) VALUES
            (govardhan_id, double_type_id, '101', 1, 2, true, true, 1),
            (govardhan_id, double_type_id, '102', 1, 2, true, true, 2),
            (govardhan_id, single_type_id, '103', 1, 1, true, false, 3),
            (govardhan_id, triple_type_id, '201', 2, 3, true, true, 4),
            (govardhan_id, double_type_id, '202', 2, 2, true, true, 5),
            (govardhan_id, double_type_id, '203', 2, 2, false, false, 6),
            (govardhan_id, single_type_id, '301', 3, 1, true, true, 7),
            (govardhan_id, double_type_id, '302', 3, 2, true, true, 8)
        ON CONFLICT (building_id, number) DO NOTHING;
    END IF;

    -- Комнаты в доме севартхов (если здание существует)
    IF sevarthi_id IS NOT NULL THEN
        INSERT INTO rooms (building_id, room_type_id, number, floor, capacity, has_bathroom, sort_order) VALUES
            (sevarthi_id, single_type_id, '1', 1, 1, false, 1),
            (sevarthi_id, single_type_id, '2', 1, 1, false, 2),
            (sevarthi_id, double_type_id, '3', 1, 2, true, 3),
            (sevarthi_id, single_type_id, '4', 2, 1, false, 4),
            (sevarthi_id, double_type_id, '5', 2, 2, true, 5)
        ON CONFLICT (building_id, number) DO NOTHING;
    END IF;
END $$;
