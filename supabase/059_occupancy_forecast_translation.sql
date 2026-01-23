-- Переводы для дашборда заселения
INSERT INTO translations (key, ru, en, hi) VALUES
    ('occupancy_forecast', 'Загрузка на неделю', 'Week occupancy', 'सप्ताह का अधिभोग'),
    ('arrivals_departures', 'Заезд / выезд', 'Arrivals / departures', 'आगमन / प्रस्थान'),
    ('summary', 'Сводка:', 'Summary:', 'सारांश:')
ON CONFLICT (key) DO UPDATE SET
    ru = EXCLUDED.ru,
    en = EXCLUDED.en,
    hi = EXCLUDED.hi;
