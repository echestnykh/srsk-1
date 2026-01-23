-- ============================================
-- 062: Переводы для бронирований
-- ============================================

INSERT INTO translations (key, ru, en, hi) VALUES
    -- Навигация
    ('nav_bookings', 'Бронирования', 'Bookings', 'बुकिंग'),

    -- Кнопки и заголовки
    ('add_booking', 'Забронировать', 'Book', 'बुक करें'),
    ('booking_title', 'Новая бронь', 'New Booking', 'नई बुकिंग'),
    ('booking_edit', 'Редактировать бронь', 'Edit Booking', 'बुकिंग संपादित करें'),
    ('bookings_title', 'Бронирования', 'Bookings', 'बुकिंग'),
    ('booking_details', 'Детали брони', 'Booking Details', 'बुकिंग विवरण'),

    -- Шаги модалки
    ('booking_step_1', 'Данные брони', 'Booking Data', 'बुकिंग डेटा'),
    ('booking_step_2', 'Выбор комнат', 'Select Rooms', 'कमरे चुनें'),
    ('booking_next', 'Далее', 'Next', 'अगला'),
    ('booking_back', 'Назад', 'Back', 'पीछे'),
    ('booking_save', 'Сохранить', 'Save', 'सहेजें'),

    -- Поля формы
    ('booking_name', 'Название брони', 'Booking Name', 'बुकिंग का नाम'),
    ('booking_name_placeholder', 'Например: Группа из Москвы', 'E.g.: Group from Moscow', 'उदा.: मॉस्को से समूह'),
    ('booking_contact_name', 'Контактное лицо', 'Contact Person', 'संपर्क व्यक्ति'),
    ('booking_contact_phone', 'Телефон', 'Phone', 'फ़ोन'),
    ('booking_contact_email', 'Email', 'Email', 'ईमेल'),
    ('booking_contact_country', 'Страна', 'Country', 'देश'),
    ('booking_beds_count', 'Количество мест', 'Number of Beds', 'बेड की संख्या'),
    ('booking_dates', 'Даты', 'Dates', 'तारीखें'),
    ('booking_retreat', 'Ретрит', 'Retreat', 'रिट्रीट'),
    ('booking_notes', 'Примечания', 'Notes', 'टिप्पणियाँ'),

    -- Выбор комнат
    ('booking_select_rooms', 'Выберите комнаты для брони', 'Select Rooms for Booking', 'बुकिंग के लिए कमरे चुनें'),
    ('booking_selected', 'Выбрано', 'Selected', 'चयनित'),
    ('booking_of', 'из', 'of', 'में से'),
    ('booking_beds', 'мест', 'beds', 'बेड'),
    ('booking_click_to_add', 'Кликните на свободные места', 'Click on available beds', 'उपलब्ध बेड पर क्लिक करें'),

    -- Статусы
    ('booking_status_checked_in', 'Заселены', 'Checked In', 'चेक-इन'),
    ('booking_status_cancelled', 'Отменена', 'Cancelled', 'रद्द'),
    ('booking_status_completed', 'Завершена', 'Completed', 'पूर्ण'),

    -- Список бронирований
    ('bookings_empty', 'Нет бронирований', 'No Bookings', 'कोई बुकिंग नहीं'),
    ('bookings_filter_all', 'Все', 'All', 'सभी'),
    ('bookings_filter_not_checked_in', 'Не заселились', 'Not Checked In', 'चेक-इन नहीं'),
    ('bookings_filter_upcoming', 'Предстоящие', 'Upcoming', 'आगामी'),
    ('booking_progress', 'Прогресс', 'Progress', 'प्रगति'),
    ('booking_filled', 'заселено', 'filled', 'भरा'),

    -- Карточка брони
    ('booking_contact', 'Контакт', 'Contact', 'संपर्क'),
    ('booking_beds_total', 'Всего мест', 'Total Beds', 'कुल बेड'),
    ('booking_view_rooms', 'Показать комнаты', 'View Rooms', 'कमरे देखें'),
    ('booking_cancel', 'Отменить бронь', 'Cancel Booking', 'बुकिंग रद्द करें'),
    ('booking_cancel_confirm', 'Отменить эту бронь?', 'Cancel this booking?', 'इस बुकिंग को रद्द करें?'),

    -- Заселение из брони
    ('booking_checkin_title', 'Заселить гостя', 'Check In Guest', 'अतिथि चेक-इन'),
    ('booking_checkin_from_booking', 'Из брони', 'From Booking', 'बुकिंग से'),
    ('booking_placeholder', 'Забронировано', 'Booked', 'बुक किया गया'),

    -- Цвета на плане
    ('floor_plan_booked', 'Забронировано', 'Booked', 'बुक किया गया'),

    -- Статус уборки
    ('needs_cleaning', 'Уборка', 'Cleaning', 'सफाई'),

    -- Легенда статусов
    ('legend', 'Легенда:', 'Legend:', 'लीजेंड:'),
    ('status_available', 'Свободно', 'Available', 'उपलब्ध'),
    ('status_booked', 'Забронировано', 'Booked', 'बुक किया गया'),
    ('status_partial', 'Частично заселено', 'Partially Occupied', 'आंशिक रूप से भरा'),
    ('status_occupied', 'Заселено', 'Occupied', 'भरा हुआ'),
    ('status_cleaning', 'Уборка', 'Cleaning', 'सफाई'),

    -- Страница уборки
    ('nav_cleaning', 'Уборка', 'Cleaning', 'सफाई'),
    ('cleaning_title', 'Уборка', 'Cleaning', 'सफाई'),
    ('cleaning_today', 'Сегодня', 'Today', 'आज'),
    ('cleaning_tomorrow', 'Завтра', 'Tomorrow', 'कल'),
    ('cleaning_week', 'На неделе', 'This Week', 'इस सप्ताह'),
    ('cleaning_month', 'В месяце', 'This Month', 'इस महीने'),
    ('cleaning_upcoming', 'Ближайшие дни', 'Upcoming', 'आगामी'),
    ('cleaning_no_rooms', 'Нет комнат для уборки', 'No rooms to clean', 'सफाई के लिए कोई कमरा नहीं'),

    -- Дни недели
    ('weekday_mon', 'Пн', 'Mon', 'सोम'),
    ('weekday_tue', 'Вт', 'Tue', 'मंगल'),
    ('weekday_wed', 'Ср', 'Wed', 'बुध'),
    ('weekday_thu', 'Чт', 'Thu', 'गुरु'),
    ('weekday_fri', 'Пт', 'Fri', 'शुक्र'),
    ('weekday_sat', 'Сб', 'Sat', 'शनि'),
    ('weekday_sun', 'Вс', 'Sun', 'रवि'),

    -- Виды отображения
    ('view_list', 'Список', 'List', 'सूची'),
    ('view_calendar', 'Календарь', 'Calendar', 'कैलेंडर'),

    -- Добавление уборки
    ('add_cleaning', 'Уборка', 'Cleaning', 'सफाई'),
    ('add_cleaning_title', 'Назначить уборку', 'Schedule Cleaning', 'सफाई शेड्यूल करें'),
    ('cleaning_date', 'Дата уборки', 'Cleaning Date', 'सफाई की तारीख'),
    ('cleaning_after_checkout', 'После выезда', 'After Checkout', 'चेकआउट के बाद'),
    ('cleaning_manual', 'Назначена вручную', 'Manual', 'मैन्युअल'),
    ('manual_cleaning', 'Назначена вручную', 'Manually scheduled', 'मैन्युअल रूप से निर्धारित'),
    ('mark_done', 'Выполнено', 'Mark as done', 'पूर्ण के रूप में चिह्नित करें')

ON CONFLICT (key) DO UPDATE SET
    ru = EXCLUDED.ru,
    en = EXCLUDED.en,
    hi = EXCLUDED.hi;
