-- ============================================
-- 089: Исправление проверки суперпользователя для управления другими
-- ============================================

-- Вернуть проверку через vaishnavas (не хардкод)
-- Функция проверяет auth.uid() (кто делает запрос), а не user_id из строки
CREATE OR REPLACE FUNCTION check_is_superuser()
RETURNS BOOLEAN AS $$
BEGIN
    -- Проверяем что ТЕКУЩИЙ пользователь (auth.uid()) - суперпользователь
    -- Это работает для управления правами ДРУГИХ пользователей
    RETURN EXISTS(
        SELECT 1 FROM vaishnavas
        WHERE user_id = auth.uid()
          AND is_superuser = true
          AND is_deleted = false
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
