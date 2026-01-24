-- Добавляем поля для раннего заезда и позднего выезда

-- Поля в residents
ALTER TABLE residents ADD COLUMN IF NOT EXISTS early_checkin BOOLEAN DEFAULT FALSE;
ALTER TABLE residents ADD COLUMN IF NOT EXISTS late_checkout BOOLEAN DEFAULT FALSE;

-- Поля в bookings
ALTER TABLE bookings ADD COLUMN IF NOT EXISTS early_checkin BOOLEAN DEFAULT FALSE;
ALTER TABLE bookings ADD COLUMN IF NOT EXISTS late_checkout BOOLEAN DEFAULT FALSE;

-- Переводы
INSERT INTO translations (key, ru, en, hi, context) VALUES
    ('nav_timeline', 'Шахматка', 'Timeline', 'टाइमलाइन', 'layout'),
    ('early_checkin', 'Ранний заезд', 'Early Check-in', 'जल्दी चेक-इन', 'housing'),
    ('late_checkout', 'Поздний выезд', 'Late Checkout', 'देर से चेक-आउट', 'housing')
ON CONFLICT (key) DO UPDATE SET
    ru = EXCLUDED.ru,
    en = EXCLUDED.en,
    hi = EXCLUDED.hi;
