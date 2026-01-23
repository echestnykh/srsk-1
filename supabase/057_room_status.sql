-- ============================================
-- 057: Статус комнаты (ремонт, консервация)
-- ============================================

-- Добавляем поле статуса в таблицу rooms
-- active - активна (по умолчанию)
-- maintenance - на ремонте
-- mothballed - законсервирована
ALTER TABLE rooms ADD COLUMN IF NOT EXISTS status TEXT DEFAULT 'active';

-- Проверка допустимых значений
ALTER TABLE rooms DROP CONSTRAINT IF EXISTS rooms_status_check;
ALTER TABLE rooms ADD CONSTRAINT rooms_status_check
    CHECK (status IN ('active', 'maintenance', 'mothballed'));

COMMENT ON COLUMN rooms.status IS 'Статус комнаты: active, maintenance (ремонт), mothballed (консервация)';

-- Переводы
INSERT INTO translations (key, ru, en, hi, page) VALUES
    ('room_status', 'Статус комнаты', 'Room status', 'कमरे की स्थिति', 'rooms'),
    ('room_status_active', 'Активна', 'Active', 'सक्रिय', 'rooms'),
    ('room_status_maintenance', 'На ремонте', 'Under maintenance', 'मरम्मत में', 'rooms'),
    ('room_status_mothballed', 'Законсервирована', 'Mothballed', 'संरक्षित', 'rooms'),
    ('floor_plan_maintenance', 'На ремонте', 'Maintenance', 'मरम्मत में', 'floor_plan'),
    ('floor_plan_mothballed', 'Законсервирована', 'Mothballed', 'संरक्षित', 'floor_plan'),
    ('floor_plan_occupied', 'Заселена', 'Occupied', 'व्यस्त', 'floor_plan'),
    ('floor_plan_departing', 'Освобождается сегодня', 'Departing today', 'आज खाली हो रहा है', 'floor_plan')
ON CONFLICT (key) DO UPDATE SET
    ru = EXCLUDED.ru,
    en = EXCLUDED.en,
    hi = EXCLUDED.hi,
    page = EXCLUDED.page;
