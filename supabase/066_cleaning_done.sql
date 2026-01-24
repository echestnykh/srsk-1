-- Поле для отметки что уборка после выезда выполнена
ALTER TABLE residents ADD COLUMN IF NOT EXISTS cleaning_done BOOLEAN DEFAULT FALSE;
