-- ============================================
-- 090: Дать права на выполнение функции check_is_superuser
-- ============================================

-- Явно разрешить роли authenticated выполнять функцию
GRANT EXECUTE ON FUNCTION check_is_superuser() TO authenticated;
GRANT EXECUTE ON FUNCTION check_is_superuser() TO anon;
