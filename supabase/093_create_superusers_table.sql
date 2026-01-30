-- ============================================
-- 093: Создать таблицу superusers без RLS
-- ============================================

-- Создать простую таблицу для хранения UUID суперпользователей
CREATE TABLE IF NOT EXISTS superusers (
    user_id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE
);

-- Отключить RLS на этой таблице (для быстрой проверки)
ALTER TABLE superusers DISABLE ROW LEVEL SECURITY;

-- Заполнить текущими суперпользователями
INSERT INTO superusers (user_id)
SELECT user_id
FROM vaishnavas
WHERE is_superuser = true
  AND is_deleted = false
  AND user_id IS NOT NULL
ON CONFLICT (user_id) DO NOTHING;

-- Пересоздать политику на user_permissions используя superusers
DROP POLICY IF EXISTS "Superusers can insert permissions" ON user_permissions;

CREATE POLICY "Superusers can insert permissions"
ON user_permissions FOR INSERT
TO authenticated
WITH CHECK (
    auth.uid() IN (SELECT user_id FROM superusers)
);
