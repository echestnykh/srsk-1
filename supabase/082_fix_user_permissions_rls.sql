-- ============================================
-- 082: Исправление RLS политик для user_permissions
-- ============================================

-- Убрать старые политики
DROP POLICY IF EXISTS "Managers can insert permissions" ON user_permissions;
DROP POLICY IF EXISTS "Managers can update permissions" ON user_permissions;
DROP POLICY IF EXISTS "Managers can delete permissions" ON user_permissions;

-- Новые политики с прямой проверкой без функций (избегаем рекурсии)

-- INSERT: только суперпользователи
CREATE POLICY "Superusers can insert permissions"
ON user_permissions FOR INSERT
WITH CHECK (
    EXISTS (
        SELECT 1 FROM vaishnavas
        WHERE user_id = auth.uid()
          AND is_superuser = true
          AND is_deleted = false
    )
);

-- UPDATE: только суперпользователи
CREATE POLICY "Superusers can update permissions"
ON user_permissions FOR UPDATE
USING (
    EXISTS (
        SELECT 1 FROM vaishnavas
        WHERE user_id = auth.uid()
          AND is_superuser = true
          AND is_deleted = false
    )
);

-- DELETE: только суперпользователи
CREATE POLICY "Superusers can delete permissions"
ON user_permissions FOR DELETE
USING (
    EXISTS (
        SELECT 1 FROM vaishnavas
        WHERE user_id = auth.uid()
          AND is_superuser = true
          AND is_deleted = false
    )
);
