-- ============================================
-- 055: Модуль "Проживание" - Переводы
-- ============================================

INSERT INTO translations (key, ru, en, hi, page) VALUES
    -- Навигация модуля
    ('module_kitchen', 'Кухня', 'Kitchen', 'रसोई', 'layout'),
    ('module_housing', 'Проживание', 'Housing', 'आवास', 'layout'),
    ('nav_housing', 'Проживание', 'Housing', 'आवास', 'layout'),
    ('nav_occupancy', 'Заселение', 'Occupancy', 'अधिभोग', 'layout'),
    ('nav_buildings', 'Здания', 'Buildings', 'भवन', 'layout'),
    ('nav_rooms', 'Комнаты', 'Rooms', 'कमरे', 'layout'),
    ('nav_guests', 'Гости', 'Guests', 'अतिथि', 'layout'),

    -- Страница зданий
    ('buildings_title', 'Здания', 'Buildings', 'भवन', 'buildings'),
    ('add_building', 'Добавить здание', 'Add building', 'भवन जोड़ें', 'buildings'),
    ('edit_building', 'Редактировать здание', 'Edit building', 'भवन संपादित करें', 'buildings'),
    ('building_name', 'Название', 'Name', 'नाम', 'buildings'),
    ('building_type', 'Тип здания', 'Building type', 'भवन का प्रकार', 'buildings'),
    ('building_floors', 'Этажей', 'Floors', 'मंजिलें', 'buildings'),
    ('building_rooms_count', 'Комнат', 'Rooms', 'कमरे', 'buildings'),
    ('building_address', 'Адрес', 'Address', 'पता', 'buildings'),
    ('delete_building', 'Удалить здание', 'Delete building', 'भवन हटाएं', 'buildings'),
    ('delete_building_confirm', 'Удалить это здание? Все комнаты и заселения будут удалены.', 'Delete this building? All rooms and residents will be deleted.', 'इस भवन को हटाएं? सभी कमरे और निवासी हटा दिए जाएंगे।', 'buildings'),
    ('no_buildings', 'Зданий пока нет', 'No buildings yet', 'अभी कोई भवन नहीं', 'buildings'),

    -- Страница комнат
    ('rooms_title', 'Комнаты', 'Rooms', 'कमरे', 'rooms'),
    ('add_room', 'Добавить комнату', 'Add room', 'कमरा जोड़ें', 'rooms'),
    ('edit_room', 'Редактировать комнату', 'Edit room', 'कमरा संपादित करें', 'rooms'),
    ('room_number', 'Номер', 'Number', 'नंबर', 'rooms'),
    ('room_type', 'Тип комнаты', 'Room type', 'कमरे का प्रकार', 'rooms'),
    ('room_floor', 'Этаж', 'Floor', 'मंजिल', 'rooms'),
    ('room_capacity', 'Мест', 'Capacity', 'क्षमता', 'rooms'),
    ('room_building', 'Здание', 'Building', 'भवन', 'rooms'),
    ('room_amenities', 'Удобства', 'Amenities', 'सुविधाएं', 'rooms'),
    ('has_bathroom', 'Санузел', 'Bathroom', 'बाथरूम', 'rooms'),
    ('has_ac', 'Кондиционер', 'AC', 'एसी', 'rooms'),
    ('has_kitchen', 'Кухня', 'Kitchen', 'रसोई', 'rooms'),
    ('has_wifi', 'Wi-Fi', 'Wi-Fi', 'वाई-फाई', 'rooms'),
    ('delete_room', 'Удалить комнату', 'Delete room', 'कमरा हटाएं', 'rooms'),
    ('delete_room_confirm', 'Удалить эту комнату?', 'Delete this room?', 'इस कमरे को हटाएं?', 'rooms'),
    ('no_rooms', 'Комнат пока нет', 'No rooms yet', 'अभी कोई कमरा नहीं', 'rooms'),
    ('all_buildings', 'Все здания', 'All buildings', 'सभी भवन', 'rooms'),
    ('all_floors', 'Все этажи', 'All floors', 'सभी मंजिलें', 'rooms'),

    -- Страница заселения
    ('occupancy_title', 'Заселение', 'Occupancy', 'अधिभोग', 'occupancy'),
    ('occupancy_chart', 'Шахматка', 'Chart', 'चार्ट', 'occupancy'),
    ('occupancy_list', 'Список', 'List', 'सूची', 'occupancy'),
    ('check_in', 'Заезд', 'Check-in', 'चेक-इन', 'occupancy'),
    ('check_out', 'Выезд', 'Check-out', 'चेक-आउट', 'occupancy'),
    ('add_resident', 'Заселить', 'Add resident', 'निवासी जोड़ें', 'occupancy'),
    ('edit_resident', 'Редактировать', 'Edit', 'संपादित करें', 'occupancy'),
    ('checkout_resident', 'Выселить', 'Check out', 'चेक-आउट', 'occupancy'),
    ('delete_resident', 'Удалить запись', 'Delete record', 'रिकॉर्ड हटाएं', 'occupancy'),
    ('delete_resident_confirm', 'Удалить запись о проживании?', 'Delete residence record?', 'निवास रिकॉर्ड हटाएं?', 'occupancy'),
    ('arrivals_today', 'Заезды сегодня', 'Arrivals today', 'आज के आगमन', 'occupancy'),
    ('departures_today', 'Выезды сегодня', 'Departures today', 'आज के प्रस्थान', 'occupancy'),
    ('room_available', 'Свободно', 'Available', 'उपलब्ध', 'occupancy'),
    ('room_occupied', 'Занято', 'Occupied', 'व्यस्त', 'occupancy'),
    ('room_full', 'Полная', 'Full', 'भरा हुआ', 'occupancy'),

    -- Страница гостей
    ('guests_title', 'Проживающие', 'Residents', 'निवासी', 'guests'),
    ('guest_name', 'Имя гостя', 'Guest name', 'अतिथि का नाम', 'guests'),
    ('guest_phone', 'Телефон', 'Phone', 'फ़ोन', 'guests'),
    ('guest_email', 'Email', 'Email', 'ईमेल', 'guests'),
    ('guest_country', 'Страна', 'Country', 'देश', 'guests'),
    ('guest_passport', 'Паспорт', 'Passport', 'पासपोर्ट', 'guests'),
    ('resident_category', 'Категория', 'Category', 'श्रेणी', 'guests'),
    ('select_team_member', 'Выбрать из команды', 'Select team member', 'टीम से चुनें', 'guests'),
    ('or_enter_guest', 'Или введите данные гостя', 'Or enter guest data', 'या अतिथि डेटा दर्ज करें', 'guests'),
    ('all_categories', 'Все категории', 'All categories', 'सभी श्रेणियां', 'guests'),
    ('status_active', 'Проживает', 'Active', 'सक्रिय', 'guests'),
    ('status_checked_out', 'Выехал', 'Checked out', 'चेक आउट', 'guests'),
    ('status_cancelled', 'Отменено', 'Cancelled', 'रद्द', 'guests'),
    ('no_residents', 'Проживающих пока нет', 'No residents yet', 'अभी कोई निवासी नहीं', 'guests'),

    -- Статистика
    ('stat_total_rooms', 'Всего комнат', 'Total rooms', 'कुल कमरे', 'housing'),
    ('stat_total_beds', 'Всего мест', 'Total beds', 'कुल बिस्तर', 'housing'),
    ('stat_occupied', 'Занято', 'Occupied', 'व्यस्त', 'housing'),
    ('stat_available', 'Свободно', 'Available', 'उपलब्ध', 'housing'),
    ('stat_occupancy_rate', 'Заполненность', 'Occupancy rate', 'अधिभोग दर', 'housing'),

    -- Общие
    ('select_room', 'Выберите комнату', 'Select room', 'कमरा चुनें', 'housing'),
    ('select_building', 'Выберите здание', 'Select building', 'भवन चुनें', 'housing'),
    ('select_category', 'Выберите категорию', 'Select category', 'श्रेणी चुनें', 'housing'),
    ('floor_n', 'Этаж', 'Floor', 'मंजिल', 'housing'),
    ('beds', 'мест', 'beds', 'बिस्तर', 'housing'),
    ('description', 'Описание', 'Description', 'विवरण', 'housing'),
    ('active', 'Активно', 'Active', 'सक्रिय', 'housing'),
    ('inactive', 'Неактивно', 'Inactive', 'निष्क्रिय', 'housing'),

    -- Welcome page
    ('welcome_title', 'Добро пожаловать!', 'Welcome!', 'स्वागत है!', 'index'),
    ('welcome_subtitle', 'Выберите модуль для работы', 'Select a module to work with', 'काम करने के लिए एक मॉड्यूल चुनें', 'index'),
    ('module_kitchen_subtitle', 'Меню, рецепты, склад', 'Menu, recipes, stock', 'मेनू, व्यंजन, स्टॉक', 'index'),
    ('module_housing_subtitle', 'Здания, комнаты, гости', 'Buildings, rooms, guests', 'भवन, कमरे, अतिथि', 'index'),
    ('welcome_kitchen_menu', 'Планирование меню на неделю', 'Weekly menu planning', 'साप्ताहिक मेनू योजना', 'index'),
    ('welcome_kitchen_recipes', 'База рецептов с ингредиентами', 'Recipe database with ingredients', 'सामग्री के साथ व्यंजनों का डेटाबेस', 'index'),
    ('welcome_kitchen_stock', 'Учёт остатков и заявки', 'Stock tracking and requests', 'स्टॉक ट्रैकिंग और अनुरोध', 'index'),
    ('welcome_housing_occupancy', 'Шахматка заселения', 'Occupancy chart', 'अधिभोग चार्ट', 'index'),
    ('welcome_housing_buildings', 'Управление зданиями и комнатами', 'Building and room management', 'भवन और कमरे का प्रबंधन', 'index'),
    ('welcome_housing_guests', 'Учёт проживающих', 'Resident tracking', 'निवासी ट्रैकिंग', 'index'),

    -- Настройки проживания
    ('nav_housing_dictionaries', 'Справочники', 'Dictionaries', 'शब्दकोश', 'layout'),
    ('housing_dictionaries_title', 'Справочники проживания', 'Housing Dictionaries', 'आवास शब्दकोश', 'housing_dictionaries'),
    ('dict_building_types', 'Типы зданий', 'Building Types', 'भवन प्रकार', 'housing_dictionaries'),
    ('dict_room_types', 'Типы комнат', 'Room Types', 'कमरे के प्रकार', 'housing_dictionaries'),
    ('dict_resident_categories', 'Категории проживающих', 'Resident Categories', 'निवासी श्रेणियां', 'housing_dictionaries'),
    ('add_building_type', 'Добавить тип здания', 'Add building type', 'भवन प्रकार जोड़ें', 'housing_dictionaries'),
    ('add_room_type', 'Добавить тип комнаты', 'Add room type', 'कमरे का प्रकार जोड़ें', 'housing_dictionaries'),
    ('add_resident_category', 'Добавить категорию', 'Add category', 'श्रेणी जोड़ें', 'housing_dictionaries'),
    ('default_capacity', 'Вместимость', 'Default capacity', 'डिफ़ॉल्ट क्षमता', 'housing_dictionaries')

ON CONFLICT (key) DO UPDATE SET
    ru = EXCLUDED.ru,
    en = EXCLUDED.en,
    hi = EXCLUDED.hi,
    page = EXCLUDED.page;
