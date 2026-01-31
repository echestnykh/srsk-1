// ==================== PORTAL-AUTH.JS ====================
// Авторизация для Personal Portal
// Доступ для гостей (guest) и команды (staff)

(function() {
'use strict';

const db = window.portalSupabase;

// Глобальный объект текущего пользователя
window.currentGuest = null;

/**
 * Проверка авторизации гостя
 * @returns {Promise<object|null>} Данные гостя или null
 */
async function checkGuestAuth() {
    try {
        // Проверяем сессию
        const { data: { session }, error: sessionError } = await db.auth.getSession();

        console.log('[Portal Auth] Session:', session ? session.user.id : 'null');

        if (sessionError || !session) {
            console.log('[Portal Auth] No session, redirecting');
            redirectToLogin('no_session');
            return null;
        }

        // Загружаем данные пользователя
        const { data: vaishnava, error: userError } = await db
            .from('vaishnavas')
            .select(`
                id,
                first_name,
                last_name,
                spiritual_name,
                email,
                phone,
                whatsapp,
                telegram,
                country,
                city,
                photo_url,
                user_type,
                spiritual_master,
                status,
                diksha_guru,
                is_active
            `)
            .eq('user_id', session.user.id)
            .maybeSingle();

        console.log('[Portal Auth] Vaishnava query result:', { vaishnava, userError });

        if (userError) {
            const errMsg = `[Portal Auth] Query error: ${JSON.stringify(userError)}`;
            console.error(errMsg);
            alert(errMsg);
            return null;
        }

        if (!vaishnava) {
            const errMsg = `[Portal Auth] User not found for auth.uid: ${session.user.id}`;
            console.error(errMsg);
            alert(errMsg);
            return null;
        }

        // Проверяем активность аккаунта
        if (vaishnava.is_active === false) {
            console.error('Аккаунт деактивирован');
            await db.auth.signOut();
            redirectToLogin('account_disabled');
            return null;
        }

        // Сохраняем данные пользователя глобально
        window.currentGuest = {
            id: vaishnava.id,
            authId: session.user.id,
            email: session.user.email,
            firstName: vaishnava.first_name,
            lastName: vaishnava.last_name,
            spiritualName: vaishnava.spiritual_name,
            phone: vaishnava.phone,
            whatsapp: vaishnava.whatsapp,
            telegram: vaishnava.telegram,
            country: vaishnava.country,
            city: vaishnava.city,
            photoUrl: vaishnava.photo_url,
            spiritualMaster: vaishnava.spiritual_master,
            dikshaGuru: vaishnava.diksha_guru,
            status: vaishnava.status,
            userType: vaishnava.user_type,
            isStaff: vaishnava.user_type === 'staff'
        };

        return window.currentGuest;

    } catch (error) {
        console.error('Ошибка проверки авторизации:', error);
        redirectToLogin('error');
        return null;
    }
}

/**
 * Редирект на страницу входа
 * @param {string} reason - Причина редиректа
 */
function redirectToLogin(reason) {
    const currentPage = window.location.pathname;
    // Не редиректим если уже на странице логина
    if (currentPage.includes('login.html')) return;

    window.location.href = `login.html?reason=${reason}&redirect=${encodeURIComponent(currentPage)}`;
}

/**
 * Выход из аккаунта
 */
async function logout() {
    try {
        await db.auth.signOut();
        window.currentGuest = null;
        window.location.href = 'login.html';
    } catch (error) {
        console.error('Ошибка выхода:', error);
        // Принудительно очищаем и редиректим
        window.currentGuest = null;
        window.location.href = 'login.html';
    }
}

/**
 * Вход по email/password
 * @param {string} email
 * @param {string} password
 * @returns {Promise<{success: boolean, error?: string}>}
 */
async function login(email, password) {
    try {
        const { data, error } = await db.auth.signInWithPassword({
            email: email,
            password: password
        });

        if (error) {
            return { success: false, error: error.message };
        }

        // Проверяем пользователя
        const { data: vaishnava, error: userError } = await db
            .from('vaishnavas')
            .select('user_type, is_active')
            .eq('user_id', data.user.id)
            .single();

        if (userError || !vaishnava) {
            await db.auth.signOut();
            return { success: false, error: 'user_not_found' };
        }

        if (vaishnava.is_active === false) {
            await db.auth.signOut();
            return { success: false, error: 'account_disabled' };
        }

        return { success: true };

    } catch (error) {
        console.error('Ошибка входа:', error);
        return { success: false, error: 'unknown_error' };
    }
}

/**
 * Получить имя гостя для отображения
 * @returns {string}
 */
function getGuestDisplayName() {
    if (!window.currentGuest) return '';

    return window.currentGuest.spiritualName ||
           `${window.currentGuest.firstName || ''} ${window.currentGuest.lastName || ''}`.trim() ||
           'Гость';
}

/**
 * Вычислить процент заполнения профиля
 * @returns {number} 0-100
 */
function getProfileCompleteness() {
    if (!window.currentGuest) return 0;

    const fields = [
        'firstName',
        'lastName',
        'spiritualName',
        'email',
        'phone',
        'whatsapp',
        'country',
        'city',
        'photoUrl',
        'spiritualMaster'
    ];

    let filled = 0;
    for (const field of fields) {
        if (window.currentGuest[field]) filled++;
    }

    return Math.round((filled / fields.length) * 100);
}

// Экспорт
window.PortalAuth = {
    checkGuestAuth,
    login,
    logout,
    getGuestDisplayName,
    getProfileCompleteness,
    redirectToLogin
};

})();
