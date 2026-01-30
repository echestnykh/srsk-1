// AUTH-CHECK.JS
// Проверка авторизации на защищенных страницах
// Подключать ПЕРЕД layout.js на каждой странице (кроме login.html)

(async function() {
    'use strict';

    // Проверяем что не на странице логина
    if (window.location.pathname.endsWith('login.html')) {
        return;
    }

    try {
        // Создаем Supabase клиент
        const db = window.supabase.createClient(CONFIG.SUPABASE_URL, CONFIG.SUPABASE_ANON_KEY);

        // Проверяем текущую сессию
        const { data: { session }, error } = await db.auth.getSession();

        if (error) {
            console.error('Auth check error:', error);
        }

        // Если нет сессии - редирект на логин
        if (!session) {
            // Сохраняем текущий URL для возврата после логина
            localStorage.setItem('srsk_redirect_after_login', window.location.pathname + window.location.search);
            window.location.href = '/login.html';
            return;
        }

        // Пользователь авторизован - продолжаем загрузку страницы
        console.log('User authenticated:', session.user.email);

        // Загружаем данные вайшнава по email
        try {
            const { data: vaishnava, error: vError } = await db
                .from('vaishnavas')
                .select('id, spiritual_name, first_name, last_name, photo_url')
                .eq('email', session.user.email)
                .eq('is_deleted', false)
                .single();

            // Сохраняем информацию о пользователе глобально
            window.currentUser = {
                ...session.user,
                vaishnava_id: vaishnava?.id,
                name: vaishnava?.spiritual_name || vaishnava?.first_name || session.user.email,
                photo_url: vaishnava?.photo_url
            };

            if (vError && vError.code !== 'PGRST116') {
                console.warn('Failed to load vaishnava data:', vError);
            }
        } catch (err) {
            console.warn('Failed to load vaishnava data:', err);
            window.currentUser = session.user;
        }

    } catch (err) {
        console.error('Auth check exception:', err);
        // При ошибке редиректим на логин
        window.location.href = '/login.html';
    }
})();
