-- ============================================
-- 088: Временная функция с хардкодом UUID для отладки
-- ============================================

-- Создать простую функцию без запроса к vaishnavas (для отладки)
CREATE OR REPLACE FUNCTION check_is_superuser()
RETURNS BOOLEAN AS $$
BEGIN
    -- ВРЕМЕННО: проверяем конкретный UUID (adrian@adrian.ru)
    RETURN auth.uid() = '2160b531-4e37-4d2a-ba46-cc1ee230cfeb'::uuid;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- После успешного теста заменим на нормальную проверку через vaishnavas
