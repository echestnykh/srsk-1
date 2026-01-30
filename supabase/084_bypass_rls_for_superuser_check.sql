-- ============================================
-- 084: Обход RLS для проверки суперпользователя
-- ============================================

-- Создать функцию которая проверяет суперпользователя с явным обходом RLS
CREATE OR REPLACE FUNCTION check_is_superuser()
RETURNS BOOLEAN AS $$
DECLARE
    result BOOLEAN;
BEGIN
    -- Используем SELECT с явным указанием что функция SECURITY DEFINER
    -- и должна обходить RLS на vaishnavas
    SELECT EXISTS(
        SELECT 1 FROM vaishnavas
        WHERE user_id = auth.uid()
          AND is_superuser = true
          AND is_deleted = false
    ) INTO result;

    RETURN result;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER STABLE;

-- Пересоздать политики на user_permissions используя новую функцию
DROP POLICY IF EXISTS "Superusers can insert permissions" ON user_permissions;
DROP POLICY IF EXISTS "Superusers can update permissions" ON user_permissions;
DROP POLICY IF EXISTS "Superusers can delete permissions" ON user_permissions;

CREATE POLICY "Superusers can insert permissions"
ON user_permissions FOR INSERT
WITH CHECK (check_is_superuser());

CREATE POLICY "Superusers can update permissions"
ON user_permissions FOR UPDATE
USING (check_is_superuser());

CREATE POLICY "Superusers can delete permissions"
ON user_permissions FOR DELETE
USING (check_is_superuser());
