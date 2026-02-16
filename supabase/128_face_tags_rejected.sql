-- Добавить поле rejected в face_tags для мягкого удаления отметки пользователем
ALTER TABLE public.face_tags
    ADD COLUMN IF NOT EXISTS rejected boolean NOT NULL DEFAULT false;

-- Разрешить пользователю обновлять свои отметки (ставить rejected = true)
CREATE POLICY "face_tags_update_own"
ON public.face_tags
FOR UPDATE
TO authenticated
USING (
    (select auth.uid()) IN (
        SELECT v.user_id
        FROM public.vaishnavas v
        WHERE v.id = face_tags.vaishnava_id
    )
)
WITH CHECK (
    (select auth.uid()) IN (
        SELECT v.user_id
        FROM public.vaishnavas v
        WHERE v.id = face_tags.vaishnava_id
    )
);
