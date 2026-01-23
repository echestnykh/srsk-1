-- ============================================
-- 056: Модуль "Проживание" - Планы этажей
-- ============================================

-- Таблица планов этажей
CREATE TABLE IF NOT EXISTS floor_plans (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    building_id UUID NOT NULL REFERENCES buildings(id) ON DELETE CASCADE,
    floor INTEGER NOT NULL,
    image_url TEXT NOT NULL,
    width INTEGER,
    height INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(building_id, floor)
);

-- Комментарии
COMMENT ON TABLE floor_plans IS 'Изображения планов этажей зданий';
COMMENT ON COLUMN floor_plans.image_url IS 'URL изображения в Supabase Storage';
COMMENT ON COLUMN floor_plans.width IS 'Ширина изображения в пикселях';
COMMENT ON COLUMN floor_plans.height IS 'Высота изображения в пикселях';

-- RLS для floor_plans
ALTER TABLE floor_plans ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow all floor_plans" ON floor_plans FOR ALL USING (true) WITH CHECK (true);

-- Добавляем колонки координат в таблицу rooms
ALTER TABLE rooms ADD COLUMN IF NOT EXISTS plan_x NUMERIC;
ALTER TABLE rooms ADD COLUMN IF NOT EXISTS plan_y NUMERIC;
ALTER TABLE rooms ADD COLUMN IF NOT EXISTS plan_width NUMERIC DEFAULT 8;
ALTER TABLE rooms ADD COLUMN IF NOT EXISTS plan_height NUMERIC DEFAULT 8;

COMMENT ON COLUMN rooms.plan_x IS 'X координата на плане этажа (0-100%)';
COMMENT ON COLUMN rooms.plan_y IS 'Y координата на плане этажа (0-100%)';
COMMENT ON COLUMN rooms.plan_width IS 'Ширина маркера на плане (%)';
COMMENT ON COLUMN rooms.plan_height IS 'Высота маркера на плане (%)';

-- Функция для обновления updated_at
CREATE OR REPLACE FUNCTION update_floor_plans_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Триггер для автообновления updated_at
DROP TRIGGER IF EXISTS floor_plans_updated_at ON floor_plans;
CREATE TRIGGER floor_plans_updated_at
    BEFORE UPDATE ON floor_plans
    FOR EACH ROW
    EXECUTE FUNCTION update_floor_plans_updated_at();

-- Индекс для быстрого поиска по зданию
CREATE INDEX IF NOT EXISTS idx_floor_plans_building ON floor_plans(building_id);

-- ============================================
-- Переводы для планов этажей
-- ============================================

INSERT INTO translations (key, ru, en, hi, page) VALUES
    -- Навигация
    ('nav_floor_plan', 'План этажа', 'Floor Plan', 'मंजिल योजना', 'layout'),

    -- Страница просмотра плана
    ('floor_plan_title', 'План этажа', 'Floor Plan', 'मंजिल योजना', 'floor_plan'),
    ('floor_plan_select_building', 'Выберите здание', 'Select building', 'भवन चुनें', 'floor_plan'),
    ('floor_plan_no_plan', 'План этажа не загружен', 'Floor plan not uploaded', 'मंजिल योजना अपलोड नहीं की गई', 'floor_plan'),
    ('floor_plan_upload', 'Загрузить план', 'Upload plan', 'योजना अपलोड करें', 'floor_plan'),
    ('floor_plan_edit_positions', 'Расставить комнаты', 'Edit positions', 'स्थिति संपादित करें', 'floor_plan'),
    ('floor_plan_floor', 'Этаж', 'Floor', 'मंजिल', 'floor_plan'),
    ('floor_plan_legend', 'Обозначения', 'Legend', 'किंवदंती', 'floor_plan'),
    ('floor_plan_available', 'Свободно', 'Available', 'उपलब्ध', 'floor_plan'),
    ('floor_plan_partial', 'Частично занято', 'Partially occupied', 'आंशिक रूप से व्यस्त', 'floor_plan'),
    ('floor_plan_full', 'Занято', 'Occupied', 'व्यस्त', 'floor_plan'),

    -- Редактор плана
    ('floor_plan_editor_title', 'Редактор плана этажа', 'Floor Plan Editor', 'मंजिल योजना संपादक', 'floor_plan_editor'),
    ('floor_plan_unplaced_rooms', 'Нераспределённые комнаты', 'Unplaced rooms', 'अनियुक्त कमरे', 'floor_plan_editor'),
    ('floor_plan_drag_hint', 'Перетащите комнату на план', 'Drag room to plan', 'कमरे को योजना पर खींचें', 'floor_plan_editor'),
    ('floor_plan_save_positions', 'Сохранить позиции', 'Save positions', 'स्थिति सहेजें', 'floor_plan_editor'),
    ('floor_plan_reset_positions', 'Сбросить', 'Reset', 'रीसेट', 'floor_plan_editor'),
    ('floor_plan_positions_saved', 'Позиции сохранены', 'Positions saved', 'स्थिति सहेजी गई', 'floor_plan_editor'),
    ('floor_plan_all_rooms_placed', 'Все комнаты размещены', 'All rooms placed', 'सभी कमरे रखे गए', 'floor_plan_editor'),

    -- Модалка загрузки
    ('upload_floor_plan', 'Загрузить план этажа', 'Upload floor plan', 'मंजिल योजना अपलोड करें', 'floor_plan'),
    ('upload_floor_plan_select_floor', 'Выберите этаж', 'Select floor', 'मंजिल चुनें', 'floor_plan'),
    ('upload_floor_plan_select_file', 'Выберите изображение', 'Select image', 'छवि चुनें', 'floor_plan'),
    ('upload_floor_plan_hint', 'JPG, PNG до 5 МБ', 'JPG, PNG up to 5 MB', 'JPG, PNG 5 MB तक', 'floor_plan'),
    ('upload_floor_plan_replace', 'Заменить существующий план?', 'Replace existing plan?', 'मौजूदा योजना बदलें?', 'floor_plan'),
    ('uploading', 'Загрузка...', 'Uploading...', 'अपलोड हो रहा है...', 'common'),

    -- Модалка комнаты
    ('room_details', 'Информация о комнате', 'Room details', 'कमरे का विवरण', 'floor_plan'),
    ('room_residents', 'Проживающие', 'Residents', 'निवासी', 'floor_plan'),
    ('room_no_residents', 'Комната свободна', 'Room is empty', 'कमरा खाली है', 'floor_plan'),
    ('room_add_resident', 'Заселить', 'Add resident', 'निवासी जोड़ें', 'floor_plan'),

    -- Кнопки
    ('btn_view_plan', 'План', 'Plan', 'योजना', 'occupancy'),
    ('btn_upload_plan', 'Загрузить план', 'Upload plan', 'योजना अपलोड करें', 'buildings'),
    ('delete_floor_plan', 'Удалить план', 'Delete plan', 'योजना हटाएं', 'floor_plan'),
    ('delete_floor_plan_confirm', 'Удалить план этого этажа?', 'Delete this floor plan?', 'इस मंजिल की योजना हटाएं?', 'floor_plan')

ON CONFLICT (key) DO UPDATE SET
    ru = EXCLUDED.ru,
    en = EXCLUDED.en,
    hi = EXCLUDED.hi,
    page = EXCLUDED.page;
