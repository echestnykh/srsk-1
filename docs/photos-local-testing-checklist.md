# Чеклист локального тестирования (по PLAN-dev-and-photos.md)

Цель: проверить реализованный функционал Фаз 1-3 в Dev окружении (Supabase dev: vzuiwpeovnzfokekdetq) и локальном UI.

**Окружение:** Dev + localhost

---

## 0. Предусловия

- [x] Dev Supabase проект доступен: `vzuiwpeovnzfokekdetq`
- [x] Ветка/сборка содержит актуальный код
- [x] Локальный сервер запущен: `npm run serve` (http://localhost:3000)
- [x] Применены миграции 108-122 в Dev
- [x] Storage bucket `retreat-photos` существует и public
- [x] Edge Functions задеплоены в Dev:
  - `index-faces`
  - `search-face`
  - `delete-photos`
  - `telegram-webhook`
  - `send-notification`
- [x] Secrets заданы в Dev Supabase:
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`
  - `AWS_REGION` = `ap-south-1`
  - `TELEGRAM_BOT_TOKEN`
  - `TELEGRAM_WEBHOOK_SECRET`
- [] Telegram Webhook зарегистрирован на Dev URL
- [x] Роль/permission `upload_photos` существует и назначена фотографу
- [x] В `js/config.js` и `guest-portal/js/portal-config.js` включен auto-env (dev по `localhost`, `dev.*`, `vercel.app`)

---

## 1. Подготовка тестовых данных

- [ ] Создать тестовый ретрит
- [ ] Создать 3-5 гостей и регистрации на ретрит
- [ ] Создать тестового фотографа с permission `upload_photos`

---

## 2. Фаза 1: Фотогалерея без AI

### 2.1 Доступы
- [ ] Фотограф: доступ к `photos/upload.html` и `photos/manage.html`
- [ ] Суперпользователь: доступ есть (через `has_permission`)
- [ ] Обычный гость: нет доступа к `photos/*`

### 2.2 Загрузка фото (upload.html)
- [ ] Загрузка 1 фото < 5MB
- [ ] Загрузка фото > 5MB (клиентская компрессия)
- [ ] Batch загрузка 10+ фото
- [ ] Неверный формат (txt/pdf) дает ошибку
- [ ] В БД создаются записи `retreat_photos` со статусом `pending`
- [ ] В Storage появляются файлы `retreat-photos/<retreat_id>/<photo_id>.jpg`

### 2.3 Галерея гостя (guest-portal/photos.html)
- [ ] Гость видит только фото своих ретритов (RLS)
- [ ] Работает lightbox, навигация и скачивание
- [ ] Прямая ссылка к чужому ретриту недоступна

### 2.4 Управление (manage.html)
- [ ] Список фото загружается
- [ ] Удаление одного фото удаляет Storage + БД + `photo_faces`/`face_tags` (CASCADE)
- [ ] Массовое удаление работает
- [ ] Realtime обновления в двух вкладках

---

## 3. Фаза 2: AI распознавание лиц

### 3.1 Индексация лиц (index-faces)
- [ ] После загрузки фото запускается индексация автоматически
- [ ] `index_status` переходит `pending -> processing -> indexed`
- [ ] `faces_count` заполняется для фото с лицами
- [ ] Фото без лиц: `faces_count = 0`, статус `indexed`
- [ ] Ошибки: `index_status = failed`, `index_error` заполнен
- [ ] Повторная индексация работает (кнопка "Переиндексировать")
- [ ] При повторе старые `photo_faces` удаляются (нет duplicate key)
- [ ] Детект зависших фото > 20 сек возвращает в `pending`
- [ ] Остановка после 10 подряд ошибок (защита от бесконечного polling)

### 3.2 Поиск лица (search-face)
- [ ] Гость с `vaishnavas.photo_url` может искать без загрузки селфи
- [ ] Если фото нет, открывается file picker
- [ ] Поиск завершает за 1-2 сек и фильтрует галерею
- [ ] Срабатывает порог similarity 85%
- [ ] `face_tags` создаются при первом поиске
- [ ] Повторный поиск использует кэш (`face_tags`), AWS не вызывается
- [ ] Сообщение "не найдено" при отсутствии совпадений

---

## 4. Фаза 3: Telegram бот + уведомления

### 4.1 Подключение бота
- [ ] В Guest Portal доступна кнопка "Подключить Telegram"
- [ ] Создается `telegram_link_tokens` (used=false, expires_at ~15 мин)
- [ ] Deep link открывает бота `/start TOKEN`
- [ ] `vaishnavas.telegram_chat_id` заполняется
- [ ] Polling обновляет UI до "Подключен"

### 4.2 Команды
- [ ] `/help` отвечает корректно
- [ ] `/stop` очищает `telegram_chat_id`
- [ ] Неверный/использованный/просроченный токен дает ошибку

### 4.3 Уведомления
- [ ] После загрузки фото фотографом приходит broadcast всем подключенным
- [ ] После "Найти себя" приходит уведомление (если включено в ТЗ)
- [ ] Rate limit 25 msg/sec соблюдается
- [ ] Retry при 429/timeout работает, 403 очищает chat_id

---

## 5. Интеграционный прогон (минимум)

- [ ] Фотограф загрузил 20+ фото
- [ ] Индексация завершилась без ошибок
- [ ] Гость нашел себя, фильтр применился
- [ ] Telegram уведомления пришли
- [ ] Удаление 2-3 фото удаляет всё корректно

---

## 6. Логи и контроль

- [ ] Edge Functions logs без критических ошибок
- [ ] В БД нет зависших `processing` > 20 сек
- [ ] Нет бесконечных вызовов Edge Functions

---

## Итог

Если все пункты пройдены, функционал готов к выкату в Production.
