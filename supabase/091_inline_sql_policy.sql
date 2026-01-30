-- ============================================
-- 091: Использовать inline SQL вместо функции в политике
-- ============================================

-- Заменить вызов функции на прямой SQL
DROP POLICY IF EXISTS "Superusers can insert permissions" ON user_permissions;

CREATE POLICY "Superusers can insert permissions"
ON user_permissions FOR INSERT
TO authenticated
WITH CHECK (
    -- Прямой SQL без вызова функции
    EXISTS (
        SELECT 1 FROM vaishnavas
        WHERE user_id = auth.uid()
          AND is_superuser = true
          AND is_deleted = false
    )
);
