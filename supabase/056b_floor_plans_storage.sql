-- ============================================
-- 056b: Создание Storage Bucket для планов этажей
-- ============================================

-- Создаём bucket для хранения изображений планов этажей
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
    'floor-plans',
    'floor-plans',
    true,  -- публичный доступ для чтения
    5242880,  -- 5 МБ лимит
    ARRAY['image/jpeg', 'image/png', 'image/webp']
)
ON CONFLICT (id) DO UPDATE SET
    public = true,
    file_size_limit = 5242880,
    allowed_mime_types = ARRAY['image/jpeg', 'image/png', 'image/webp'];

-- RLS политики для bucket

-- Политика на чтение (публичный доступ)
CREATE POLICY "Public read access for floor-plans"
ON storage.objects FOR SELECT
USING (bucket_id = 'floor-plans');

-- Политика на загрузку (все авторизованные пользователи)
CREATE POLICY "Allow upload to floor-plans"
ON storage.objects FOR INSERT
WITH CHECK (bucket_id = 'floor-plans');

-- Политика на обновление
CREATE POLICY "Allow update in floor-plans"
ON storage.objects FOR UPDATE
USING (bucket_id = 'floor-plans');

-- Политика на удаление
CREATE POLICY "Allow delete from floor-plans"
ON storage.objects FOR DELETE
USING (bucket_id = 'floor-plans');
