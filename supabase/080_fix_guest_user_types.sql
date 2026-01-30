-- ============================================
-- 080: Исправление типа пользователей для гостей
-- ============================================

-- Обновить user_type для гостей (is_team_member = false)
UPDATE vaishnavas
SET user_type = 'guest'
WHERE is_deleted = false
  AND (is_team_member = false OR is_team_member IS NULL)
  AND user_type = 'staff';

-- Назначить роль Guest всем гостям у кого есть user_id
DO $$
DECLARE
    guest_role_id UUID;
    guest_record RECORD;
BEGIN
    -- Получить ID роли Guest
    SELECT r.id INTO guest_role_id
    FROM roles r
    JOIN modules m ON r.module_id = m.id
    WHERE m.code = 'housing'
      AND r.code = 'guest'
    LIMIT 1;

    IF guest_role_id IS NULL THEN
        RAISE NOTICE 'Guest role not found';
        RETURN;
    END IF;

    -- Для каждого гостя с user_id назначить роль если её нет
    FOR guest_record IN
        SELECT v.user_id
        FROM vaishnavas v
        WHERE v.is_deleted = false
          AND v.user_type = 'guest'
          AND v.user_id IS NOT NULL
          AND NOT EXISTS (
              SELECT 1 FROM user_roles ur
              WHERE ur.user_id = v.user_id
                AND ur.role_id = guest_role_id
          )
    LOOP
        INSERT INTO user_roles (user_id, role_id, is_active, assigned_at)
        VALUES (guest_record.user_id, guest_role_id, true, NOW());
    END LOOP;
END $$;
