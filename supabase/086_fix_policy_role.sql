-- ============================================
-- 086: Исправление роли в политике user_permissions
-- ============================================

-- Пересоздать политики с явным указанием роли authenticated
DROP POLICY IF EXISTS "Superusers can insert permissions" ON user_permissions;
DROP POLICY IF EXISTS "Superusers can update permissions" ON user_permissions;
DROP POLICY IF EXISTS "Superusers can delete permissions" ON user_permissions;

-- INSERT: для роли authenticated с проверкой суперпользователя
CREATE POLICY "Superusers can insert permissions"
ON user_permissions FOR INSERT
TO authenticated  -- ВАЖНО: явно указываем роль
WITH CHECK (check_is_superuser());

-- UPDATE: для роли authenticated с проверкой суперпользователя
CREATE POLICY "Superusers can update permissions"
ON user_permissions FOR UPDATE
TO authenticated  -- ВАЖНО: явно указываем роль
USING (check_is_superuser());

-- DELETE: для роли authenticated с проверкой суперпользователя
CREATE POLICY "Superusers can delete permissions"
ON user_permissions FOR DELETE
TO authenticated  -- ВАЖНО: явно указываем роль
USING (check_is_superuser());
